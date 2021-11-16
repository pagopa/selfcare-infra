# APIM subnet
module "apim_snet" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.58"
  name                 = format("%s-apim-snet", local.project)
  resource_group_name  = azurerm_resource_group.rg_vnet.name
  virtual_network_name = module.vnet.name
  address_prefixes     = var.cidr_subnet_apim

  enforce_private_link_endpoint_network_policies = true
  service_endpoints                              = ["Microsoft.Web"]
}

resource "azurerm_resource_group" "rg_api" {
  name     = format("%s-api-rg", local.project)
  location = var.location

  tags = var.tags
}

locals {
  apim_cert_name_proxy_endpoint = format("%s-proxy-endpoint-cert", local.project)

  api_domain = format("api.%s.%s", var.dns_zone_prefix, var.external_domain)

  origins = {
    base = concat(
              [
                format("https://api.%s.%s", var.dns_zone_prefix, var.external_domain),
                format("https://%s.%s", var.dns_zone_prefix, var.external_domain),
               ],
               var.env_short != "p"? ["https://localhost:3000","http://localhost:3000","https://localhost:3001","http://localhost:3001"]:[]
            ),
    spidAcsOrigins = concat(
                      var.enable_spid_test ? [format("https://%s", module.spid-test-env.spid_testenv_url)] : [],
                      [
                        "https://id.lepida.it",
                        "https://identity.infocert.it",
                        "https://identity.sieltecloud.it",
                        "https://idp.namirialtsp.com",
                        "https://login.id.tim.it",
                        "https://loginspid.aruba.it",
                        "https://posteid.poste.it",
                        "https://spid.intesa.it",
                        "https://spid.register.it"
                      ]
                    )
  }
}

###########################
## Api Management (apim) ##
###########################

module "apim" {
  source               = "git::https://github.com/pagopa/azurerm.git//api_management?ref=v1.0.58"
  subnet_id            = module.apim_snet.id
  location             = azurerm_resource_group.rg_api.location
  name                 = format("%s-apim", local.project)
  resource_group_name  = azurerm_resource_group.rg_api.name
  publisher_name       = var.apim_publisher_name
  publisher_email      = data.azurerm_key_vault_secret.apim_publisher_email.value
  sku_name             = var.apim_sku
  virtual_network_type = "Internal"

  redis_connection_string = module.redis.primary_connection_string
  redis_cache_id          = module.redis.id

  # This enables the Username and Password Identity Provider
  sign_up_enabled = false

  lock_enable = var.lock_enable

  # sign_up_terms_of_service = {
  #   consent_required = false
  #   enabled          = false
  #   text             = ""
  # }

  application_insights_instrumentation_key = azurerm_application_insights.application_insights.instrumentation_key

  xml_content = templatefile("./api/base_policy.tpl", {
    origins = local.origins.base
  })

  tags = var.tags

  depends_on = [
    azurerm_application_insights.application_insights,
    module.redis
  ]
}

resource "azurerm_api_management_custom_domain" "api_custom_domain" {
  api_management_id = module.apim.id

  proxy {
    host_name = local.api_domain
    key_vault_id = replace(
    data.azurerm_key_vault_certificate.app_gw_platform.secret_id,
    "/${data.azurerm_key_vault_certificate.app_gw_platform.version}",
    ""
    )
  }
}

#########
## API ##
#########

## monitor ##
module "monitor" {
  source              = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.58"
  name                = format("%s-monitor", var.env_short)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  description  = "Monitor"
  display_name = "Monitor"
  path         = ""
  protocols    = ["https"]

  service_url = null

  content_format = "openapi"
  content_value = templatefile("./api/monitor/openapi.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = file("./api/base_policy.xml")

  subscription_required = false

  api_operation_policies = [
    {
      operation_id = "get"
      xml_content  = file("./api/monitor/mock_policy.xml")
    }
  ]
}

resource "azurerm_api_management_api_version_set" "apim_hub_spid_login_api" {
  name                = format("%s-spid-login-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = "SPID"
  versioning_scheme   = "Segment"
}

module "apim_hub_spid_login_api_v1" {
  source              = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.58"
  name                = format("%s-spid-login-api-v1", local.project)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
  version_set_id      = azurerm_api_management_api_version_set.apim_hub_spid_login_api.id


  description  = "Login SPID Service Provider"
  display_name = "SPID V1"
  path         = "spid"
  api_version  = "v1"
  protocols    = ["https"]

  service_url = format("http://%s/hub-spid-login-ms", var.reverse_proxy_ip)

  content_format = "swagger-json"
  content_value = templatefile("./api/hubspidlogin_api/v1/swagger.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = file("./api/hubspidlogin_api/v1/policy.xml")

  subscription_required = false


  api_operation_policies = [
    {
      operation_id = "postACS"
      xml_content  = templatefile("./api/hubspidlogin_api/v1/postacs_policy.xml.tpl", {
        origins = local.origins.spidAcsOrigins
      })
    },
    {
      operation_id = "getMetadata"
      xml_content  = file("./api/hubspidlogin_api/v1/metadata_policy.xml.tpl")
    }
  ]
}

resource "azurerm_api_management_api_version_set" "apim_uservice_party_process" {
  name                = format("%s-party-prc-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = "Party Process Micro Service"
  versioning_scheme   = "Segment"
}

module "apim_uservice_party_process_v1" {
  source              = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.58"
  name                = format("%s-party-prc-api-v1", local.project)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
  version_set_id      = azurerm_api_management_api_version_set.apim_uservice_party_process.id


  description  = "This service is the party process"
  display_name = "Party Process Micro Service V1"
  path         = "party-process"
  api_version  = "v1"
  protocols    = ["https"]

  service_url = format("http://%s/uservice-party-process/pdnd-interop-uservice-party-process/0.1", var.reverse_proxy_ip)

  content_format = "openapi"
  content_value = templatefile("./api/party_process/v1/party-process.yml.tpl", {
    host     = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
    basePath = "party-process/v1"
  })

  xml_content = file("./api/base_policy.xml")

  subscription_required = false

  // TODO these are mocks! remove me after integration
  api_operation_policies = [
    {
      operation_id = "getOnBoardingInfo"
      xml_content  = file("./api/party_process/v1/getOnBoardingInfo_policy.xml")
    },
    {
      operation_id = "createLegals"
      xml_content  = file("./api/party_process/v1/createLegals_policy.xml")
    },
    {
      operation_id = "invalidateOnboarding"
      xml_content  = file("./api/party_process/v1/invalidateOnboarding_policy.xml")
    },
    {
      operation_id = "confirmOnBoarding"
      xml_content  = file("./api/party_process/v1/confirmOnboarding_policy.xml")
    }
  ]
}

resource "azurerm_api_management_api_version_set" "apim_uservice_party_management" {
  name                = format("%s-party-mgmt-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = "Party Management Micro Service"
  versioning_scheme   = "Segment"
}

module "apim_uservice_party_management_v1" {
  source              = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.58"
  name                = format("%s-party-mgmt-api-v1", local.project)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
  version_set_id      = azurerm_api_management_api_version_set.apim_uservice_party_management.id


  description  = "This service is the party manager"
  display_name = "Party Management Micro Service V1"
  path         = "party-management"
  api_version  = "v1"
  protocols    = ["https"]

  service_url = format("http://%s/uservice-party-management/pdnd-interop-uservice-party-management/0.1", var.reverse_proxy_ip)

  content_format = "openapi"
  content_value = templatefile("./api/party_management/v1/party-management.yml.tpl", {
    host     = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
    basePath = "party-management/v1"
  })

  xml_content = file("./api/base_policy.xml")

  subscription_required = false

  // TODO these are mocks! remove me after integration
  api_operation_policies = [
    {
      operation_id = "getOrganizationById"
      xml_content  = file("./api/party_management/v1/getOrganizationById_policy.xml")
    }
  ]
}

resource "azurerm_api_management_api_version_set" "apim_uservice_party_registry_proxy" {
  name                = format("%s-party-reg-proxy-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = "Party Registry Proxy Server"
  versioning_scheme   = "Segment"
}

module "apim_uservice_party_registry_proxy_v1" {
  source              = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.58"
  name                = format("%s-party-reg-proxy-api-v1", local.project)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
  version_set_id      = azurerm_api_management_api_version_set.apim_uservice_party_registry_proxy.id


  description  = "This service is the proxy to the party registry"
  display_name = "Party Registry Proxy Server V1"
  path         = "party-registry-proxy"
  api_version  = "v1"
  protocols    = ["https"]

  service_url = format("http://%s/uservice-party-registry-proxy/pdnd-interop-uservice-party-registry-proxy/0.1", var.reverse_proxy_ip)

  content_format = "openapi"
  content_value = templatefile("./api/party_registry_proxy/v1/party-registry-proxy.yml.tpl", {
    host     = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
    basePath = "party-registry-proxy/v1"
  })

  xml_content = file("./api/base_policy.xml")

  subscription_required = false

  // TODO these are mocks! remove me after integration
  api_operation_policies = [
    {
      operation_id = "searchInstitution"
      xml_content  = file("./api/party_registry_proxy/v1/searchInstitution_policy.xml")
    }
  ]
}

resource "azurerm_api_management_api_version_set" "apim_b4f_dashboard" {
  name                = format("%s-b4f-dashboard-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = "Self Care Dashboard"
  versioning_scheme   = "Segment"
}

module "apim_b4f_dashboard_v1" {
  source              = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.58"
  name                = format("%s-b4f-dashboard-api-v1", local.project)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
  version_set_id      = azurerm_api_management_api_version_set.apim_b4f_dashboard.id


  description  = "Self Care Dashboard API documentation"
  display_name = "Self Care Dashboard V1"
  path         = "dashboard"
  api_version  = "v1"
  protocols    = ["https"]

  service_url = format("http://%s/b4f-dashboard", var.reverse_proxy_ip)

  content_format = "openapi"
  content_value = templatefile("./api/dashboard/v1/dashboard-openapi.json.tpl", {
    host     = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
    basePath = "dashboard/v1"
  })

  xml_content = file("./api/base_policy.xml")

  subscription_required = false
}
