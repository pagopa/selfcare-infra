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

  apim_base_url = format("%s/external", azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name)
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

  redis_connection_string = null
  redis_cache_id          = null

  # This enables the Username and Password Identity Provider
  sign_up_enabled = false
  lock_enable     = false

  application_insights_instrumentation_key = azurerm_application_insights.application_insights.instrumentation_key

  xml_content = file("./api/root_policy.xml")

  tags = var.tags

  depends_on = [
    azurerm_application_insights.application_insights
  ]
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
  path         = "external/status"
  protocols    = ["https"]

  service_url = null

  content_format = "openapi"
  content_value = templatefile("./api/monitor/openapi.json.tpl", {
    host = local.apim_base_url
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

## JWT generator ##
module "jwt_gen_api" {
  source              = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.58"
  name                = format("%s-jwt-gen", var.env_short)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  description  = "JWT Generator"
  display_name = "JWT Generator"
  path         = "external/jwt"
  protocols    = ["https"]

  service_url = null

  content_format = "openapi"
  content_value = templatefile("./api/jwt_gen/openapi.json.tpl", {
    host = format("%s/external_api", azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name)
  })

  xml_content = templatefile("./api/jwt_base_policy.xml.tpl", {
    KID                        = module.jwt.jwt_kid
    JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
  })

  subscription_required = true

  api_operation_policies = [
    {
      operation_id = "get"
      xml_content  = file("./api/jwt_gen/get_policy.xml")
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
  display_name = "Party Process Micro Service"
  path         = "external/party-process"
  api_version  = "v1"
  protocols    = ["https"]

  service_url = format("http://%s/party-process/v1", var.reverse_proxy_ip)

  content_format = "openapi"
  content_value = templatefile("./api/party_process/v1/open-api.yml.tpl", {
    host     = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
    basePath = "party-process/v1"
  })

  xml_content = templatefile("./api/jwt_base_policy.xml.tpl", {
    KID                        = module.jwt.jwt_kid
    JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
  })

  subscription_required = true

  api_operation_policies = [
    {
      operation_id = "getOnboardingInfo"
      xml_content  = file("./api/jwt_auth_op_policy.xml")
    },
    {
      operation_id = "verifyOnboarding"
      xml_content  = file("./api/jwt_auth_op_policy.xml")
    },
    {
      operation_id = "getUserInstitutionRelationships"
      xml_content  = file("./api/jwt_auth_op_policy.xml")
    },
    {
      operation_id = "retrieveInstitutionProducts"
      xml_content  = file("./api/jwt_auth_op_policy.xml")
    },
    {
      operation_id = "getRelationship"
      xml_content  = file("./api/jwt_auth_op_policy.xml")
    },
    {
      operation_id = "getOnboardingDocument"
      xml_content  = file("./api/jwt_auth_op_policy.xml")
    },
    {
      operation_id = "getStatus"
      xml_content  = file("./api/jwt_auth_op_policy.xml")
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
  path         = "external/party-management"
  api_version  = "v1"
  protocols    = ["https"]

  service_url = format("http://%s/party-management/v1", var.reverse_proxy_ip)

  content_format = "openapi"
  content_value = templatefile("./api/party_management/v1/open-api.yml.tpl", {
    host     = "selc-d-apim.azure-api.net" // azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
    basePath = "party-management/v1"
  })

  xml_content = templatefile("./api/jwt_base_policy.xml.tpl", {
    KID                        = module.jwt.jwt_kid
    JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
  })

  subscription_required = true

  api_operation_policies = [
    {
      operation_id = "getPersonById"
      xml_content  = file("./api/jwt_auth_op_policy.xml")
    },
    {
      operation_id = "existsPersonById"
      xml_content  = file("./api/jwt_auth_op_policy.xml")
    },
    {
      operation_id = "getOrganizationById"
      xml_content  = file("./api/jwt_auth_op_policy.xml")
    },
    {
      operation_id = "existsOrganizationById"
      xml_content  = file("./api/jwt_auth_op_policy.xml")
    },
    {
      operation_id = "getOrganizationByExternalId"
      xml_content  = file("./api/jwt_auth_op_policy.xml")
    },
    {
      operation_id = "getPartyAttributes"
      xml_content  = file("./api/jwt_auth_op_policy.xml")
    },
    {
      operation_id = "getRelationships"
      xml_content  = file("./api/jwt_auth_op_policy.xml")
    },
    {
      operation_id = "getRelationshipById"
      xml_content  = file("./api/jwt_auth_op_policy.xml")
    },
    {
      operation_id = "getToken"
      xml_content  = file("./api/jwt_auth_op_policy.xml")
    },
    {
      operation_id = "getStatus"
      xml_content  = file("./api/jwt_auth_op_policy.xml")
    }
  ]
}