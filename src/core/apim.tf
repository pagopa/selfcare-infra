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
    apim-name = format("%s-apim", local.project)
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

module "pdnd_interop_party_prc" {
  source              = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.58"
  name                = format("%s-spid-login-api", local.project)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  description  = "This service is the party process"
  display_name = "Party Process Micro Service"
  path         = "pdnd-interop-uservice-party-process/v1"
  protocols    = ["https"]

  service_url = format("http://%s/pdnd-interop-uservice-party-process-client", var.reverse_proxy_ip) // TODO using a different ingress, reverse_proxy_ip should not be usable...

  content_format = "openapi"
  content_value = templatefile("./api/party_process/party-process.yml.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = file("./api/base_policy.xml")

  subscription_required = false
}

module "apim_pdnd_interop_party_manag" {
  source              = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.58"
  name                = format("%s-spid-login-api", local.project)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  description  = "This service is the party manager"
  display_name = "Party Management Micro Service"
  path         = "party-management/v1"
  protocols    = ["https"]

  service_url = format("http://%s/pdnd-interop-uservice-party-management-client", var.reverse_proxy_ip) // TODO using a different ingress, reverse_proxy_ip should not be usable...

  content_format = "openapi"
  content_value = templatefile("./api/party_management/party-management.yml.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = file("./api/base_policy.xml")

  subscription_required = false
}

module "pdnd_interop_party_reg_proxy" {
  source              = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.58"
  name                = format("%s-spid-login-api", local.project)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  description  = "This service is the proxy to the party registry"
  display_name = "Party Registry Proxy Server"
  path         = "pdnd-interop-uservice-party-registry-proxy/v1"
  protocols    = ["https"]

  service_url = format("http://%s/pdnd-interop-uservice-party-registry-proxy", var.reverse_proxy_ip) // TODO using a different ingress, reverse_proxy_ip should not be usable...

  content_format = "openapi"
  content_value = templatefile("./api/party_registry_proxy/party-registry-proxy.yml.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = file("./api/base_policy.xml")

  subscription_required = false
}
