# APIM subnet
module "apim_snet" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v2.12.5"
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
  source               = "git::https://github.com/pagopa/azurerm.git//api_management?ref=v2.12.5"
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
  source              = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.12.5"
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
resource "azurerm_api_management_api_version_set" "apim_uservice_party_process" {
  name                = format("%s-party-prc-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = "Party Process Micro Service"
  versioning_scheme   = "Segment"
}

module "apim_uservice_party_process_v1" {
  source              = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.12.5"
  name                = format("%s-party-prc-api", local.project)
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
    API_DOMAIN                 = local.api_domain
    KID                        = module.jwt.jwt_kid
    JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
  })

  subscription_required = true

  api_operation_policies = [
    {
      operation_id = "getUserInstitutionRelationships"
      xml_content  = file("./api/jwt_auth_op_policy.xml")
    },
    {
      operation_id = "getRelationship"
      xml_content  = file("./api/jwt_auth_op_policy.xml")
    },
    {
      operation_id = "getInstitution"
      xml_content = templatefile("./api/party_process/getInstitution_op_policy.xml.tpl", {
        CDN_STORAGE_URL = "https://${module.checkout_cdn.storage_primary_web_host}"
      })
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
  source              = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.12.5"
  name                = format("%s-party-mgmt-api", local.project)
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
    host     = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
    basePath = "party-management/v1"
  })

  xml_content = templatefile("./api/jwt_base_policy.xml.tpl", {
    API_DOMAIN                 = local.api_domain
    KID                        = module.jwt.jwt_kid
    JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
  })

  subscription_required = true

  api_operation_policies = [
    {
      operation_id = "getInstitutionById"
      xml_content  = file("./api/jwt_auth_op_policy.xml")
    },
    {
      operation_id = "getPartyAttributes"
      xml_content  = file("./api/jwt_auth_op_policy.xml")
    },
    {
      operation_id = "getInstitutionByExternalId"
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
      operation_id = "bulkInstitutions"
      xml_content  = file("./api/jwt_auth_op_policy.xml")
    }
  ]
}

resource "azurerm_api_management_api_version_set" "apim_user_group_ms" {
  name                = format("%s-ms-user-group-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = "User Group Micro Service"
  versioning_scheme   = "Segment"
}

module "apim_user_group_ms_v1" {
  source              = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.12.5"
  name                = format("%s-ms-user-group-api", local.project)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
  version_set_id      = azurerm_api_management_api_version_set.apim_user_group_ms.id


  description  = "This service is the user group micro service"
  display_name = "User Group Micro Service"
  path         = "external/user-groups"
  api_version  = "v1"
  protocols = [
  "https"]

  service_url = format("http://%s/ms-user-group/user-groups/v1/", var.reverse_proxy_ip)

  content_format = "openapi"
  content_value = templatefile("./api/ms_user_group/v1/open-api.yml.tpl", {
    host     = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
    basePath = "user-groups/v1/"
  })

  xml_content = templatefile("./api/jwt_base_policy.xml.tpl", {
    API_DOMAIN                 = local.api_domain
    KID                        = module.jwt.jwt_kid
    JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
  })

  subscription_required = true

  api_operation_policies = [
    {
      operation_id = "getUserGroupsUsingGET"
      xml_content  = file("./api/jwt_auth_op_policy_user_group.xml")
    }
  ]
}

resource "azurerm_api_management_api_version_set" "apim_external_api_ms" {
  name                = format("%s-ms-external-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = "External API Service"
  versioning_scheme   = "Segment"
}

module "apim_external_api_ms_v1" {
  source              = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.12.5"
  name                = format("%s-ms-external-api", local.project)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
  version_set_id      = azurerm_api_management_api_version_set.apim_external_api_ms.id

  description  = "This service is the proxy for external services"
  display_name = "External API service"
  path         = "external"
  api_version  = "v1"
  protocols = [
  "https"]

  service_url = format("http://%s/external-api/v1/", var.reverse_proxy_ip)

  content_format = "openapi"
  content_value = templatefile("./api/ms_external_api/v1/open-api.yml.tpl", {
    host     = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
    basePath = "v1"
  })

  xml_content = templatefile("./api/jwt_base_policy.xml.tpl", {
    API_DOMAIN                 = local.api_domain
    KID                        = module.jwt.jwt_kid
    JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
  })

  subscription_required = true

  api_operation_policies = [
    {
      operation_id = "getInstitutionsUsingGET"
      xml_content = templatefile("./api/ms_external_api/v1/getInstitutions_op_policy.xml.tpl", {
        CDN_STORAGE_URL = "https://${module.checkout_cdn.storage_primary_web_host}"
      })
    },
    {
      operation_id = "getInstitutionUserProductsUsingGET"
      xml_content  = file("./api/jwt_auth_op_policy.xml")
    },
    {
      operation_id = "getUserGroupsUsingGET"
      xml_content = templatefile("./api/ms_external_api/v1/jwt_auth_op_policy_user_group.xml.tpl", {
        USER_GROUP_BACKEND_BASE_URL = "http://${var.reverse_proxy_ip}/ms-user-group/user-groups/v1/"
      })
    },
    {
      operation_id = "getInstitution"
      xml_content = templatefile("./api/ms_external_api/v1/getInstitution_op_policy.xml.tpl", {
        CDN_STORAGE_URL                = "https://${module.checkout_cdn.storage_primary_web_host}"
        PARTY_PROCESS_BACKEND_BASE_URL = "http://${var.reverse_proxy_ip}/party-process/v1/"
      })
    },
    {
      operation_id = "getProductUsingGET"
      xml_content = templatefile("./api/ms_external_api/v1/getProduct_op_policy.xml.tpl", {
        MS_PRODUCT_BACKEND_BASE_URL = "http://${var.reverse_proxy_ip}/ms-product/v1/"
      })
    },
    {
      operation_id = "getInstitutionProductUsersUsingGET"
      xml_content  = file("./api/jwt_auth_op_policy.xml")
    }
  ]
}

module "apim_external_api_ms_v2" {
  source              = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.12.5"
  name                = format("%s-ms-external-api", local.project)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
  version_set_id      = azurerm_api_management_api_version_set.apim_external_api_ms.id

  description  = "This service is the proxy for external services"
  display_name = "External API service"
  path         = "external"
  api_version  = "v2"
  protocols = [
  "https"]

  service_url = format("http://%s/external-api/v2/", var.reverse_proxy_ip)

  content_format = "openapi"
  content_value = templatefile("./api/ms_external_api/v2/open-api.yml.tpl", {
    host     = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
    basePath = "v2"
  })

  xml_content = file("./api/ms_external_api/v2/base_policy.xml")

  subscription_required = true
  product_ids = [
    module.apim_product_interop.product_id,
    module.apim_product_pn.product_id,
    module.apim_product_pagopa.product_id,
    module.apim_product_idpay.product_id
  ]

  api_operation_policies = [
    {
      operation_id = "getInstitutionsUsingGET"
      xml_content = templatefile("./api/ms_external_api/v2/getInstitutions_op_policy.xml.tpl", {
        CDN_STORAGE_URL            = "https://${module.checkout_cdn.storage_primary_web_host}"
        API_DOMAIN                 = local.api_domain
        KID                        = module.jwt.jwt_kid
        JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
      })
    },
    {
      operation_id = "getInstitutionUserProductsUsingGET"
      xml_content = templatefile("./api/ms_external_api/v2/getInstitutionUserProductsUsingGET_op_policy.xml.tpl", {
        API_DOMAIN                 = local.api_domain
        KID                        = module.jwt.jwt_kid
        JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
      })
    },
    {
      operation_id = "getUserGroupsUsingGET"
      xml_content = templatefile("./api/ms_external_api/v2/jwt_auth_op_policy_user_group.xml.tpl", {
        USER_GROUP_BACKEND_BASE_URL = "http://${var.reverse_proxy_ip}/ms-user-group/user-groups/v1/"
      })
    },
    {
      operation_id = "getInstitution"
      xml_content = templatefile("./api/ms_external_api/v2/getInstitution_op_policy.xml.tpl", {
        CDN_STORAGE_URL                = "https://${module.checkout_cdn.storage_primary_web_host}"
        PARTY_PROCESS_BACKEND_BASE_URL = "http://${var.reverse_proxy_ip}/party-process/v1/"
        API_DOMAIN                     = local.api_domain
        KID                            = module.jwt.jwt_kid
        JWT_CERTIFICATE_THUMBPRINT     = azurerm_api_management_certificate.jwt_certificate.thumbprint
      })
    },
    {
      operation_id = "getProductUsingGET"
      xml_content = templatefile("./api/ms_external_api/v2/getProduct_op_policy.xml.tpl", {
        MS_PRODUCT_BACKEND_BASE_URL = "http://${var.reverse_proxy_ip}/ms-product/v1/"
      })
    },
    {
      operation_id = "getInstitutionProductUsersUsingGET"
      xml_content = templatefile("./api/ms_external_api/v2/getInstitutionProductUsersUsingGET_op_policy.xml.tpl", {
        API_DOMAIN                 = local.api_domain
        KID                        = module.jwt.jwt_kid
        JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
      })
    }
  ]
}


##############
## Products ##
##############

module "apim_product_interop" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.16"

  product_id   = "interop"
  display_name = "INTEROP"
  description  = "Interoperabilità"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/interop/policy.xml")
}

module "apim_product_pn" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.16"

  product_id   = "pn"
  display_name = "PN"
  description  = "Piattaforma Notifiche"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/pn/policy.xml")
}

module "apim_product_pagopa" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.16"

  product_id   = "pagopa"
  display_name = "PAGOPA"
  description  = "Pagamenti pagoPA"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/pagopa/policy.xml")
}

module "apim_product_idpay" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.16"

  product_id   = "idpay"
  display_name = "IDPAY"
  description  = "ID Pay"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/idpay/policy.xml")
}


##################
## Named values ##
##################

resource "azurerm_api_management_named_value" "apim_named_value_backend_access_token" {

  name                = "backend-access-token"
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  display_name = "backend-access-token"
  secret       = true
  value_from_key_vault {
    secret_id = data.azurerm_key_vault_secret.apim_backend_access_token.id
  }

}

data "azurerm_key_vault_secret" "apim_backend_access_token" {
  name         = "apim-backend-access-token"
  key_vault_id = module.key_vault.id
}
