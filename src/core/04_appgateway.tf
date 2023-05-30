## Application gateway public ip ##
resource "azurerm_public_ip" "appgateway_public_ip" {
  name                = "${local.project}-appgateway-pip"
  resource_group_name = azurerm_resource_group.rg_vnet.name
  location            = azurerm_resource_group.rg_vnet.location
  sku                 = "Standard"
  allocation_method   = "Static"

  tags = var.tags
}

# Subnet to host the application gateway
module "appgateway_snet" {
  source               = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v6.14.0"
  name                 = "${local.project}-appgateway-snet"
  address_prefixes     = var.cidr_subnet_appgateway
  resource_group_name  = azurerm_resource_group.rg_vnet.name
  virtual_network_name = module.vnet.name
}

locals {
  allowedIngressPathRegexps = [
    "/spid/*",
    "/dashboard/*",
    "/onboarding/*",
    "/ms-notification-manager/*",
    # "/party-process/*",
    "/party-registry-proxy/*",
    # "/ms-core/*",
  ]

  backends = {
    aks = {
      protocol                    = "Http"
      host                        = trim(azurerm_dns_a_record.dns_a_api.fqdn, ".")
      port                        = 80
      ip_addresses                = [var.reverse_proxy_ip]
      probe                       = "/health"
      probe_name                  = "probe-aks"
      request_timeout             = 60
      fqdns                       = null
      pick_host_name_from_backend = false
    }
    apim = {
      protocol                    = "Https"
      host                        = trim(azurerm_dns_a_record.dns_a_api.fqdn, ".")
      port                        = 443
      ip_addresses                = module.apim.private_ip_addresses
      probe                       = "/external/status"
      probe_name                  = "probe-apim"
      request_timeout             = 60
      fqdns                       = null
      pick_host_name_from_backend = false
    }
    platform-aks = {
      protocol                    = "Https"
      host                        = "${var.aks_platform_env}.pnpg.internal.${var.dns_zone_prefix}.${var.external_domain}"
      port                        = 443
      ip_addresses                = null
      probe                       = "/pnpg/status"
      probe_name                  = "probe-platform-aks"
      request_timeout             = 60
      fqdns                       = ["${var.aks_platform_env}.pnpg.internal.${var.dns_zone_prefix}.${var.external_domain}"]
      pick_host_name_from_backend = false
    }
  }

  listeners = {
    api = {
      protocol           = "Https"
      host               = "api.${var.dns_zone_prefix}.${var.external_domain}"
      port               = 443
      ssl_profile_name   = null
      firewall_policy_id = null

      certificate = {
        name = var.app_gateway_api_certificate_name
        id = replace(
          data.azurerm_key_vault_certificate.app_gw_platform.secret_id,
          "/${data.azurerm_key_vault_certificate.app_gw_platform.version}",
          ""
        )
      }
    }
    api-pnpg = {
      protocol           = "Https"
      host               = "api-pnpg.${var.dns_zone_prefix}.${var.external_domain}"
      port               = 443
      ssl_profile_name   = null
      firewall_policy_id = null
      certificate = {
        name = var.app_gateway_api_pnpg_certificate_name
        id = replace(
          data.azurerm_key_vault_certificate.api_pnpg_selfcare_certificate.secret_id,
          "/${data.azurerm_key_vault_certificate.api_pnpg_selfcare_certificate.version}",
          ""
        )
      }
    }
  }
}

# Application gateway: Multilistener configuraiton
module "app_gw" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//app_gateway?ref=v6.14.0"

  resource_group_name = azurerm_resource_group.rg_vnet.name
  location            = azurerm_resource_group.rg_vnet.location
  name                = "${local.project}-app-gw"

  # SKU
  sku_name = var.app_gateway_sku_name
  sku_tier = var.app_gateway_sku_tier

  # WAF
  waf_enabled = var.app_gateway_waf_enabled

  # Networking
  subnet_id    = module.appgateway_snet.id
  public_ip_id = azurerm_public_ip.appgateway_public_ip.id

  # Configure backends
  backends = local.backends

  # Configure listeners
  listeners = local.listeners

  # maps listener to backend
  routes = {
    api-pnpg-to-platform-aks = {
      listener              = "api-pnpg"
      backend               = "platform-aks"
      rewrite_rule_set_name = null
      priority              = 1
    }
  }

  routes_path_based = {
    api = {
      listener     = "api"
      priority     = null
      url_map_name = "api"
      priority     = 1
    }
  }

  url_path_map = {
    api = {
      default_backend               = "aks"
      default_rewrite_rule_set_name = "rewrite-rule-set-api"
      path_rule = {
        external_api = {
          paths                 = ["/external/*"]
          backend               = "apim"
          rewrite_rule_set_name = null
        }
      }
    }
  }

  ssl_profiles = [{
    name                             = "${local.project}-ssl-profile"
    trusted_client_certificate_names = null
    verify_client_cert_issuer_dn     = false
    ssl_policy = {
      disabled_protocols = []
      policy_type        = "Custom"
      policy_name        = "" # with Custom type set empty policy_name (not required by the provider)
      cipher_suites = [
        "TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256",
        "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384",
      ]
      min_protocol_version = "TLSv1_2"
    }
  }]

  trusted_client_certificates = []

  rewrite_rule_sets = [
    {
      name = "rewrite-rule-set-api"
      rewrite_rules = [
        {
          name          = "ingres-private-urls"
          rule_sequence = 1
          conditions = [{
            variable    = "var_uri_path"
            pattern     = join("|", local.allowedIngressPathRegexps)
            ignore_case = true
            negate      = true
          }]
          request_header_configurations  = []
          response_header_configurations = []
          url = {
            path         = "dummy"
            query_string = null
          }
        },
        {
          name          = "http-headers-api"
          rule_sequence = 100
          conditions    = []
          request_header_configurations = [
            {
              header_name  = "X-Forwarded-For"
              header_value = "{var_client_ip}"
            },
            {
              header_name  = "X-Client-Ip"
              header_value = "{var_client_ip}"
            },
          ]
          response_header_configurations = []
          url                            = null
        },
      ]
    },
  ]

  # TLS
  identity_ids = [azurerm_user_assigned_identity.appgateway.id]

  # Scaling
  app_gateway_min_capacity = var.app_gateway_min_capacity
  app_gateway_max_capacity = var.app_gateway_max_capacity

  alerts_enabled = var.app_gateway_alerts_enabled

  action = [
    {
      action_group_id    = azurerm_monitor_action_group.slack.id
      webhook_properties = null
    },
    {
      action_group_id    = azurerm_monitor_action_group.email.id
      webhook_properties = null
    }
  ]

  # metrics docs
  # https://docs.microsoft.com/en-us/azure/azure-monitor/essentials/metrics-supported#microsoftnetworkapplicationgateways
  monitor_metric_alert_criteria = {

    compute_units_usage = {
      description   = "Abnormal compute units usage, probably an high traffic peak"
      frequency     = "PT5M"
      window_size   = "PT5M"
      severity      = 2
      auto_mitigate = true

      criteria = []
      dynamic_criteria = [
        {
          aggregation              = "Average"
          metric_name              = "ComputeUnits"
          operator                 = "GreaterOrLessThan"
          alert_sensitivity        = "High"
          evaluation_total_count   = 2
          evaluation_failure_count = 2
          dimension                = []
        }
      ]
    }

    backend_pools_status = {
      description   = "One or more backend pools are down, check Backend Health on Azure portal"
      frequency     = "PT5M"
      window_size   = "PT5M"
      severity      = 0
      auto_mitigate = true

      criteria = [
        {
          aggregation = "Average"
          metric_name = "UnhealthyHostCount"
          operator    = "GreaterThan"
          threshold   = 0
          dimension   = []
        }
      ]
      dynamic_criteria = []
    }

    response_time = {
      description   = "Backends response time is too high"
      frequency     = "PT5M"
      window_size   = "PT5M"
      severity      = 2
      auto_mitigate = true

      criteria = []
      dynamic_criteria = [
        {
          aggregation              = "Average"
          metric_name              = "BackendLastByteResponseTime"
          operator                 = "GreaterThan"
          alert_sensitivity        = "High"
          evaluation_total_count   = 2
          evaluation_failure_count = 2
          dimension                = []
        }
      ]
    }

    total_requests = {
      description   = "Traffic is raising"
      frequency     = "PT5M"
      window_size   = "PT15M"
      severity      = 3
      auto_mitigate = true

      criteria = []
      dynamic_criteria = [
        {
          aggregation              = "Total"
          metric_name              = "TotalRequests"
          operator                 = "GreaterThan"
          alert_sensitivity        = "Medium"
          evaluation_total_count   = 1
          evaluation_failure_count = 1
          dimension                = []
        }
      ]
    }

    failed_requests = {
      description   = "Abnormal failed requests"
      frequency     = "PT5M"
      window_size   = "PT5M"
      severity      = 1
      auto_mitigate = true

      criteria = []
      dynamic_criteria = [
        {
          aggregation              = "Total"
          metric_name              = "FailedRequests"
          operator                 = "GreaterThan"
          alert_sensitivity        = "High"
          evaluation_total_count   = 2
          evaluation_failure_count = 2
          dimension                = []
        }
      ]
    }
  }

  tags = var.tags
}
