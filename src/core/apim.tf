# APIM subnet
module "apim_snet" {
  source               = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v7.3.0"
  name                 = format("%s-apim-snet", local.project)
  resource_group_name  = azurerm_resource_group.rg_vnet.name
  virtual_network_name = module.vnet.name
  address_prefixes     = var.cidr_subnet_apim

  private_endpoint_network_policies_enabled = true
  service_endpoints                         = ["Microsoft.Web"]
}

resource "azurerm_resource_group" "rg_api" {
  name     = format("%s-api-rg", local.project)
  location = var.location

  tags = var.tags
}

locals {
  apim_cert_name_proxy_endpoint = format("%s-proxy-endpoint-cert", local.project)

  api_domain      = format("api.%s.%s", var.dns_zone_prefix, var.external_domain)
  logo_api_domain = format("%s.%s", var.dns_zone_prefix, var.external_domain)
  apim_base_url   = "${azurerm_api_management_custom_domain.api_custom_domain.gateway[0].host_name}/external"
}

resource "azurerm_api_management_custom_domain" "api_custom_domain" {
  api_management_id = module.apim.id

  gateway {
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
  source               = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management?ref=v7.3.0"
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

  application_insights = {
    enabled             = true
    instrumentation_key = azurerm_application_insights.application_insights.instrumentation_key
  }

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
  source              = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v7.3.0"
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
  source              = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v7.2.1"
  name                = format("%s-party-prc-api", local.project)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
  version_set_id      = azurerm_api_management_api_version_set.apim_uservice_party_process.id


  description  = "This service is the party process"
  display_name = "Party Process Micro Service"
  path         = "external/party-process"
  api_version  = "v1"
  protocols    = ["https"]

  service_url = "http://${var.private_dns_name}/ms-core/v1"

  content_format = "openapi"
  content_value = templatefile("./api/party_process/v1/open-api.yml.tpl", {
    host     = azurerm_api_management_custom_domain.api_custom_domain.gateway[0].host_name
    basePath = "ms-core/v1"
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
      xml_content = templatefile("./api/party_process/v1/party_op_policy.xml.tpl", {
        CDN_STORAGE_URL            = "https://${module.checkout_cdn.storage_primary_web_host}"
        API_DOMAIN                 = local.api_domain
        KID                        = module.jwt.jwt_kid
        JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
      })
    },
    {
      operation_id = "getRelationship"
      xml_content = templatefile("./api/party_process/v1/party_op_policy.xml.tpl", {
        CDN_STORAGE_URL            = "https://${module.checkout_cdn.storage_primary_web_host}"
        API_DOMAIN                 = local.api_domain
        KID                        = module.jwt.jwt_kid
        JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
      })
    },
    {
      operation_id = "getInstitution"
      xml_content = templatefile("./api/party_process/getInstitution_op_policy.xml.tpl", {
        CDN_STORAGE_URL            = "https://${module.checkout_cdn.storage_primary_web_host}"
        API_DOMAIN                 = local.api_domain
        KID                        = module.jwt.jwt_kid
        JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
      })
    }
  ]
}

resource "azurerm_api_management_api_version_set" "apim_external_api_onboarding_auto" {
  name                = format("%s-external-api-onboarding-auto", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = "SelfCare Onboarding"
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api_version_set" "apim_external_api_onboarding_io" {
  name                = format("%s-external-api-onboarding-io", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = "SelfCare Onboarding PA prod-io"
  versioning_scheme   = "Segment"
}

module "apim_external_api_onboarding_auto_v1" {
  source              = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v7.3.0"
  name                = format("%s-external-api-onboarding-auto", local.project)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
  version_set_id      = azurerm_api_management_api_version_set.apim_external_api_onboarding_auto.id

  description  = "Onboarding API for PA only for io product"
  display_name = "SelfCare Onboarding"
  path         = "external/onboarding-auto"
  api_version  = "v1"
  protocols = [
    "https"
  ]

  service_url = format("http://%s/external-api/v1/", var.private_dns_name)

  content_format = "openapi"
  content_value = templatefile("./api/external-api-onboarding-auto/v1/open-api.yml.tpl", {
    host     = azurerm_api_management_custom_domain.api_custom_domain.gateway[0].host_name
    basePath = "/onboarding-api/v1"
  })

  xml_content = templatefile("./api/jwt_base_policy.xml.tpl", {
    API_DOMAIN                 = local.api_domain
    KID                        = module.jwt.jwt_kid
    JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
  })

  subscription_required = true

  api_operation_policies = [
    {
      operation_id = "autoApprovalOnboardingUsingPOST"
      xml_content  = file("./api/jwt_auth_op_policy.xml")
    }
  ]
}

module "apim_external_api_onboarding_io_v1" {
  source              = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v7.3.0"
  name                = format("%s-external-api-onboarding-io", local.project)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
  version_set_id      = azurerm_api_management_api_version_set.apim_external_api_onboarding_io.id

  description  = "Onboarding API for PA only for io product"
  display_name = "SelfCare Onboarding PA prod-io"
  path         = "external/onboarding-io"
  api_version  = "v1"
  protocols = [
    "https"
  ]

  service_url = format("http://%s/external-api/v1/", var.private_dns_name)

  content_format = "openapi"
  content_value = templatefile("./api/external-api-onboarding-io/v1/open-api.yml.tpl", {
    host     = azurerm_api_management_custom_domain.api_custom_domain.gateway[0].host_name
    basePath = "/onboarding-api/v1"
  })

  xml_content = file("./api/base_policy.xml")

  subscription_required = true

  api_operation_policies = [
    {
      operation_id = "contractOnboardingUsingPOST"
      xml_content = templatefile("./api/external-api-onboarding-io/v1/contractOnboarding_op_policy.xml.tpl", {
        API_DOMAIN                 = local.api_domain
        KID                        = module.jwt.jwt_kid
        JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
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
  source              = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v7.3.0"
  name                = format("%s-party-mgmt-api", local.project)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
  version_set_id      = azurerm_api_management_api_version_set.apim_uservice_party_management.id


  description  = "This service is the party manager"
  display_name = "Party Management Micro Service V1"
  path         = "external/party-management"
  api_version  = "v1"
  protocols    = ["https"]

  service_url = "http://${var.private_dns_name}/ms-core/v1"

  content_format = "openapi"
  content_value = templatefile("./api/party_management/v1/open-api.yml.tpl", {
    host     = azurerm_api_management_custom_domain.api_custom_domain.gateway[0].host_name
    basePath = "ms-core/v1"
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
      # xml_content  = file("./api/jwt_auth_op_policy.xml")
      xml_content = templatefile("./api/party_management/v1/party_op_policy.xml.tpl", {
        CDN_STORAGE_URL            = "https://${module.checkout_cdn.storage_primary_web_host}"
        API_DOMAIN                 = local.api_domain
        KID                        = module.jwt.jwt_kid
        JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
      })
    },
    {
      operation_id = "getPartyAttributes"
      xml_content = templatefile("./api/party_management/v1/party_op_policy.xml.tpl", {
        CDN_STORAGE_URL            = "https://${module.checkout_cdn.storage_primary_web_host}"
        API_DOMAIN                 = local.api_domain
        KID                        = module.jwt.jwt_kid
        JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
      })
    },
    {
      operation_id = "getInstitutionByExternalId"
      xml_content = templatefile("./api/party_management/v1/party_op_policy.xml.tpl", {
        CDN_STORAGE_URL            = "https://${module.checkout_cdn.storage_primary_web_host}"
        API_DOMAIN                 = local.api_domain
        KID                        = module.jwt.jwt_kid
        JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
      })
    },
    {
      operation_id = "getRelationships"
      xml_content = templatefile("./api/party_management/v1/party_op_policy.xml.tpl", {
        CDN_STORAGE_URL            = "https://${module.checkout_cdn.storage_primary_web_host}"
        API_DOMAIN                 = local.api_domain
        KID                        = module.jwt.jwt_kid
        JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
      })
    },
    {
      operation_id = "getRelationshipById"
      xml_content = templatefile("./api/party_management/v1/party_op_policy.xml.tpl", {
        CDN_STORAGE_URL            = "https://${module.checkout_cdn.storage_primary_web_host}"
        API_DOMAIN                 = local.api_domain
        KID                        = module.jwt.jwt_kid
        JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
      })
    },
    {
      operation_id = "bulkInstitutions"
      xml_content = templatefile("./api/party_management/v1/party_op_policy.xml.tpl", {
        CDN_STORAGE_URL            = "https://${module.checkout_cdn.storage_primary_web_host}"
        API_DOMAIN                 = local.api_domain
        KID                        = module.jwt.jwt_kid
        JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
      })
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
  source              = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v7.3.0"
  name                = format("%s-ms-user-group-api", local.project)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
  version_set_id      = azurerm_api_management_api_version_set.apim_user_group_ms.id


  description  = "This service is the user group micro service"
  display_name = "User Group Micro Service"
  path         = "external/user-groups"
  api_version  = "v1"
  protocols = [
    "https"
  ]

  service_url = format("http://%s/ms-user-group/user-groups/v1/", var.private_dns_name)

  content_format = "openapi"
  content_value = templatefile("./api/ms_user_group/v1/open-api.yml.tpl", {
    host     = azurerm_api_management_custom_domain.api_custom_domain.gateway[0].host_name
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
  source              = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v7.3.0"
  name                = format("%s-ms-external-api", local.project)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
  version_set_id      = azurerm_api_management_api_version_set.apim_external_api_ms.id

  description  = "This service is the proxy for external services"
  display_name = "External API service"
  path         = "external"
  api_version  = "v1"
  protocols = [
    "https"
  ]

  service_url = format("http://%s/external-api/v1/", var.private_dns_name)

  content_format = "openapi"
  content_value = templatefile("./api/ms_external_api/v1/open-api.yml.tpl", {
    host     = azurerm_api_management_custom_domain.api_custom_domain.gateway[0].host_name
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
      operation_id = "getInstitutionGeographicTaxonomiesUsingGET"
      xml_content  = file("./api/jwt_auth_op_policy.xml")
    },
    {
      operation_id = "getInstitutionsByGeoTaxonomiesUsingGET"
      xml_content  = file("./api/jwt_auth_op_policy.xml")
    },
    {
      operation_id = "getUserGroupsUsingGET"
      xml_content = templatefile("./api/ms_external_api/v1/jwt_auth_op_policy_user_group.xml.tpl", {
        USER_GROUP_BACKEND_BASE_URL = "http://${var.private_dns_name}/ms-user-group/user-groups/v1/"
      })
    },
    {
      operation_id = "getInstitution"
      xml_content = templatefile("./api/ms_external_api/v1/getInstitution_op_policy.xml.tpl", {
        CDN_STORAGE_URL                = "https://${module.checkout_cdn.storage_primary_web_host}"
        PARTY_PROCESS_BACKEND_BASE_URL = "http://${var.private_dns_name}/ms-core/v1/"
      })
    },
    {
      operation_id = "getProductUsingGET"
      xml_content = templatefile("./api/ms_external_api/v1/getProduct_op_policy.xml.tpl", {
        MS_PRODUCT_BACKEND_BASE_URL = "http://${var.private_dns_name}/ms-product/v1/"
      })
    },
    {
      operation_id = "getInstitutionProductUsersUsingGET"
      xml_content  = file("./api/jwt_auth_op_policy.xml")
    }
  ]
}

module "apim_external_api_ms_v2" {
  source              = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v7.3.0"
  name                = format("%s-ms-external-api", local.project)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
  version_set_id      = azurerm_api_management_api_version_set.apim_external_api_ms.id

  description  = "This service is the proxy for external services"
  display_name = "External API service"
  path         = "external"
  api_version  = "v2"
  protocols = [
    "https"
  ]

  service_url = format("http://%s/external-api/v1/", var.private_dns_name)

  content_format = "openapi"
  content_value = templatefile("./api/ms_external_api/v2/open-api.yml.tpl", {
    host     = azurerm_api_management_custom_domain.api_custom_domain.gateway[0].host_name
    basePath = "v2"
  })

  xml_content = file("./api/ms_external_api/v2/base_policy.xml")

  subscription_required = true
  product_ids = [
    module.apim_product_support_io.product_id,
    module.apim_product_interop.product_id,
    module.apim_product_interop_coll.product_id,
    module.apim_product_pn.product_id,
    module.apim_product_pn_svil.product_id,
    module.apim_product_pn_dev.product_id,
    module.apim_product_pn_coll.product_id,
    module.apim_product_pn_cert.product_id,
    module.apim_product_pn_hotfix.product_id,
    module.apim_product_pn_prod.product_id,
    module.apim_product_pn_test.product_id,
    module.apim_product_pagopa.product_id,
    module.apim_product_idpay.product_id,
    module.apim_product_io_sign.product_id,
    module.apim_product_io.product_id,
    module.apim_product_io_premium.product_id,
    module.apim_product_fd.product_id,
    module.apim_product_fd_garantito.product_id
  ]

  api_operation_policies = [
    {
      operation_id = "getInstitutionsUsingGET"
      xml_content = templatefile("./api/ms_external_api/v2/getInstitutions_op_policy.xml.tpl", {
        LOGO_URL                   = "https://${local.logo_api_domain}"
        API_DOMAIN                 = local.api_domain
        KID                        = module.jwt.jwt_kid
        JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
        TENANT_ID                  = data.azurerm_client_config.current.tenant_id
        EXTERNAL-OAUTH2-ISSUER     = data.azurerm_key_vault_secret.external-oauth2-issuer.value
      })
    },
    {
      operation_id = "getInstitutionUserProductsUsingGET"
      xml_content = templatefile("./api/ms_external_api/v2/getInstitutionUserProductsUsingGET_op_policy.xml.tpl", {
        API_DOMAIN                 = local.api_domain
        KID                        = module.jwt.jwt_kid
        JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
        TENANT_ID                  = data.azurerm_client_config.current.tenant_id
        EXTERNAL-OAUTH2-ISSUER     = data.azurerm_key_vault_secret.external-oauth2-issuer.value
      })
    },
    {
      operation_id = "getInstitutionGeographicTaxonomiesUsingGET"
      xml_content = templatefile("./api/ms_external_api/v2/getInstitutionGeographicTaxonomiesUsingGET_op_policy.xml.tpl", {
        API_DOMAIN                 = local.api_domain
        KID                        = module.jwt.jwt_kid
        JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
        TENANT_ID                  = data.azurerm_client_config.current.tenant_id
        EXTERNAL-OAUTH2-ISSUER     = data.azurerm_key_vault_secret.external-oauth2-issuer.value
      })
    },
    {
      operation_id = "getInstitutionsByGeoTaxonomiesUsingGET"
      xml_content = templatefile("./api/ms_external_api/v2/getInstitutionsByGeoTaxonomiesUsingGET_op_policy.xml.tpl", {
        API_DOMAIN                 = local.api_domain
        KID                        = module.jwt.jwt_kid
        JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
        TENANT_ID                  = data.azurerm_client_config.current.tenant_id
        EXTERNAL-OAUTH2-ISSUER     = data.azurerm_key_vault_secret.external-oauth2-issuer.value
      })
    },
    {
      operation_id = "getUserGroupsUsingGET"
      xml_content = templatefile("./api/ms_external_api/v2/jwt_auth_op_policy_user_group.xml.tpl", {
        USER_GROUP_BACKEND_BASE_URL = "http://${var.private_dns_name}/ms-user-group/user-groups/v1/"
        TENANT_ID                   = data.azurerm_client_config.current.tenant_id
        EXTERNAL-OAUTH2-ISSUER      = data.azurerm_key_vault_secret.external-oauth2-issuer.value
      })
    },
    {
      operation_id = "getUserInfoUsingPOST"
      xml_content = templatefile("./api/ms_external_api/v2/jwt_auth_op_policy_v2.xml.tpl", {
        API_DOMAIN                 = local.api_domain
        KID                        = module.jwt.jwt_kid
        JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
      })
    },
    {
      operation_id = "getInstitution"
      xml_content = templatefile("./api/ms_external_api/v2/getInstitution_op_policy.xml.tpl", {
        LOGO_URL                       = "https://${local.logo_api_domain}"
        PARTY_PROCESS_BACKEND_BASE_URL = "http://${var.private_dns_name}/ms-core/v1/"
        API_DOMAIN                     = local.api_domain
        KID                            = module.jwt.jwt_kid
        JWT_CERTIFICATE_THUMBPRINT     = azurerm_api_management_certificate.jwt_certificate.thumbprint
        TENANT_ID                      = data.azurerm_client_config.current.tenant_id
        EXTERNAL-OAUTH2-ISSUER         = data.azurerm_key_vault_secret.external-oauth2-issuer.value
      })
    },
    {
      operation_id = "getProductUsingGET"
      xml_content = templatefile("./api/ms_external_api/v2/getProduct_op_policy.xml.tpl", {
        MS_PRODUCT_BACKEND_BASE_URL = "http://${var.private_dns_name}/ms-product/v1/"
        TENANT_ID                   = data.azurerm_client_config.current.tenant_id
        EXTERNAL-OAUTH2-ISSUER      = data.azurerm_key_vault_secret.external-oauth2-issuer.value
      })
    },
    {
      operation_id = "getInstitutionProductUsersUsingGET"
      xml_content = templatefile("./api/ms_external_api/v2/getInstitutionProductUsersUsingGET_op_policy.xml.tpl", {
        API_DOMAIN                 = local.api_domain
        KID                        = module.jwt.jwt_kid
        JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
        TENANT_ID                  = data.azurerm_client_config.current.tenant_id
        EXTERNAL-OAUTH2-ISSUER     = data.azurerm_key_vault_secret.external-oauth2-issuer.value
      })
    },
    {
      operation_id = "getContractUsingGET"
      xml_content = templatefile("./api/ms_external_api/v2/getContractUsingGet_op_policy.xml.tpl", {
        API_DOMAIN                 = local.api_domain
        KID                        = module.jwt.jwt_kid
        JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
        TENANT_ID                  = data.azurerm_client_config.current.tenant_id
        EXTERNAL-OAUTH2-ISSUER     = data.azurerm_key_vault_secret.external-oauth2-issuer.value
      })
    },
    {
      operation_id = "messageAcknowledgmentUsingPOST"
      xml_content = templatefile("./api/ms_external_api/v2/messageAcknowledgment_op_policy.xml.tpl", {
        MS_EXTERNAL_INTERCEPTOR_BACKEND_BASE_URL = "http://${var.private_dns_name}/ms-external-interceptor/v1"
        TENANT_ID                                = data.azurerm_client_config.current.tenant_id
        EXTERNAL-OAUTH2-ISSUER                   = data.azurerm_key_vault_secret.external-oauth2-issuer.value
      })
    },
    {
      operation_id = "getDelegationsUsingGET"
      xml_content = templatefile("./api/ms_external_api/v2/getDelegationsUsingGET_op_policy.xml.tpl", {
        PARTY_PROCESS_BACKEND_BASE_URL = "http://${var.private_dns_name}/ms-core/v1/"
        API_DOMAIN                     = local.api_domain
        KID                            = module.jwt.jwt_kid
        JWT_CERTIFICATE_THUMBPRINT     = azurerm_api_management_certificate.jwt_certificate.thumbprint
        TENANT_ID                      = data.azurerm_client_config.current.tenant_id
        EXTERNAL-OAUTH2-ISSUER         = data.azurerm_key_vault_secret.external-oauth2-issuer.value
      })
    },
    {
      operation_id = "getOnboardingsInstitutionUsingGET"
      xml_content = templatefile("./api/ms_external_api/v2/getOnboardingsInstitutionUsingGET_op_policy.xml.tpl", {
        MS_CORE_BACKEND_BASE_URL   = "http://${var.private_dns_name}/ms-core/v1/"
        API_DOMAIN                 = local.api_domain
        KID                        = module.jwt.jwt_kid
        JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
        TENANT_ID                  = data.azurerm_client_config.current.tenant_id
        EXTERNAL-OAUTH2-ISSUER     = data.azurerm_key_vault_secret.external-oauth2-issuer.value
      })
    },
    {
      operation_id = "getInstitutionsByTaxCodeUsingGET"
      xml_content = templatefile("./api/ms_external_api/v2/getInstitutionsByTaxCodeUsingGET_op_policy.xml.tpl", {
        MS_CORE_BACKEND_BASE_URL   = "http://${var.private_dns_name}/ms-core/v1/"
        API_DOMAIN                 = local.api_domain
        KID                        = module.jwt.jwt_kid
        JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
        TENANT_ID                  = data.azurerm_client_config.current.tenant_id
        EXTERNAL-OAUTH2-ISSUER     = data.azurerm_key_vault_secret.external-oauth2-issuer.value
      })
    },
    {
      operation_id = "getUserInfoUsingGET"
      xml_content = templatefile("./api/ms_external_api/v2/getUserInfoUsingGet_op_policy.xml.tpl", {
        MS_CORE_BACKEND_BASE_URL   = "http://${var.private_dns_name}/ms-core/v1/"
        API_DOMAIN                 = local.api_domain
        KID                        = module.jwt.jwt_kid
        JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
        TENANT_ID                  = data.azurerm_client_config.current.tenant_id
        EXTERNAL-OAUTH2-ISSUER     = data.azurerm_key_vault_secret.external-oauth2-issuer.value
      })
    },
    {
      operation_id = "sendSupportRequestUsingPOST"
      xml_content = templatefile("./api/ms_external_api/v2/sendSupportRequest_op_policy.xml.tpl", {
        API_DOMAIN                 = local.api_domain
        KID                        = module.jwt.jwt_kid
        JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
        BACKEND_BASE_URL           = "http://${var.private_dns_name}/dashboard/v1/"
        TENANT_ID                  = data.azurerm_client_config.current.tenant_id
        EXTERNAL-OAUTH2-ISSUER     = data.azurerm_key_vault_secret.external-oauth2-issuer.value
      })
    },
    {
      operation_id = "getTokensFromProductUsingGET"
      xml_content = templatefile("./api/ms_external_api/v2/getTokensFromProductUsingGET_op_policy.xml.tpl", {
        MS_CORE_BACKEND_BASE_URL   = "http://${var.private_dns_name}/ms-core/v1/"
        API_DOMAIN                 = local.api_domain
        KID                        = module.jwt.jwt_kid
        JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
      })
    },
  ]
}

resource "azurerm_api_management_api_version_set" "apim_internal_api_ms" {
  name                = format("%s-ms-internal-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = "Internal API Service"
  versioning_scheme   = "Segment"
}

module "apim_internal_api_ms_v1" {
  source              = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v7.3.0"
  name                = format("%s-ms-internal-api", local.project)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
  version_set_id      = azurerm_api_management_api_version_set.apim_internal_api_ms.id

  description  = "This service is the proxy for internal services"
  display_name = "Internal API service"
  path         = "external/internal"
  api_version  = "v1"
  protocols = [
    "https"
  ]

  service_url = format("http://%s/external-api/v1/", var.private_dns_name)

  content_format = "openapi"
  content_value = templatefile("./api/ms_internal_api/v1/open-api.yml.tpl", {
    host     = azurerm_api_management_custom_domain.api_custom_domain.gateway[0].host_name
    basePath = "v1"
  })

  xml_content = templatefile("./api/ms_internal_api/v1/internal_jwt_base_policy.xml.tpl", {
    API_DOMAIN                 = local.api_domain
    KID                        = module.jwt.jwt_kid
    JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
  })

  subscription_required = true

  api_operation_policies = [
    {
      operation_id = "getInstitutionProductUsersUsingGET"
      xml_content  = file("./api/ms_internal_api/v1/getInstitutionProductUsers_op_policy.xml")
    },
    {
      operation_id = "getInstitution"
      xml_content = templatefile("./api/ms_internal_api/v1/getInstitution_op_policy.xml.tpl", {
        CDN_STORAGE_URL             = "https://${module.checkout_cdn.storage_primary_web_host}"
        MS_PRODUCT_BACKEND_BASE_URL = "http://${var.private_dns_name}/ms-core/v1/"
      })
    },
    {
      operation_id = "autoApprovalOnboardingUsingPOST"
      xml_content  = file("./api/jwt_auth_op_policy.xml")
    },
    {
      operation_id = "onboardingUsingPOST"
      xml_content  = file("./api/jwt_auth_op_policy.xml")
    },
    {
      operation_id = "getProductUsingGET"
      xml_content = templatefile("./api/ms_internal_api/v1/getProduct_op_policy.xml.tpl", {
        MS_PRODUCT_BACKEND_BASE_URL = "http://${var.private_dns_name}/ms-product/v1/"
      })
    },
    {
      operation_id = "createDelegationUsingPOST"
      xml_content = templatefile("./api/ms_internal_api/v1/core_op_policy.xml.tpl", {
        MS_CORE_BACKEND_BASE_URL = "http://${var.private_dns_name}/ms-core/v1/"
      })
    },
    {
      operation_id = "updateUserStatusUsingPUT"
      xml_content = templatefile("./api/ms_internal_api/v1/core_op_policy.xml.tpl", {
        MS_CORE_BACKEND_BASE_URL = "http://${var.private_dns_name}/ms-core/v1/"
      })
    },
    {
      operation_id = "autoApprovalOnboardingFromPdaUsingPOST"
      xml_content  = file("./api/jwt_auth_op_policy.xml")
    },
    {
      operation_id = "onboardingInstitutionUsersUsingPOST"
      xml_content = templatefile("./api/ms_internal_api/v1/postOnboardingInstitutionUsers_op_policy.xml.tpl", {
        MS_CORE_BACKEND_BASE_URL = "http://${var.private_dns_name}/ms-core/v1/"
        }
      )
    },
    {
      operation_id = "completeOnboardingTokenConsume"
      xml_content = templatefile("./api/ms_internal_api/v1/core_op_policy.xml.tpl", {
        MS_CORE_BACKEND_BASE_URL = "http://${var.private_dns_name}/ms-core/v1/"
        }
      )
    }
  ]
}

resource "azurerm_api_management_api_version_set" "apim_selfcare_support_service" {
  name                = format("%s-support-service", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = "SelfCare Support API Service"
  versioning_scheme   = "Segment"
}

module "apim_selfcare_support_service_v1" {
  source              = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.20.0"
  name                = format("%s-selfcare-support-api-service", local.project)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
  version_set_id      = azurerm_api_management_api_version_set.apim_selfcare_support_service.id

  description  = "This service collects the APIs for Support use"
  display_name = "SelfCare Support API service"
  path         = "external/support"
  api_version  = "v1"
  protocols = [
    "https"
  ]

  service_url = format("http://%s/external-api/v1/", var.private_dns_name)

  content_format = "openapi"
  content_value = templatefile("./api/selfcare_support_service/v1/open-api.yml.tpl", {
    host     = azurerm_api_management_custom_domain.api_custom_domain.gateway[0].host_name
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
      operation_id = "getContractUsingGET"
      xml_content = templatefile("./api/selfcare_support_service/v1/jwt_auth_op_policy.xml.tpl", {
        API_DOMAIN                 = local.api_domain
        KID                        = module.jwt.jwt_kid
        JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
      })
    },
    {
      operation_id = "getInstitutionsByTaxCodeUsingGET"
      xml_content = templatefile("./api/selfcare_support_service/v1/getInstitutionsByTaxCodeUsingGET_op_policy.xml.tpl", {
        BACKEND_BASE_URL   = "http://${var.private_dns_name}/ms-core/v1/"
        API_DOMAIN                 = local.api_domain
        KID                        = module.jwt.jwt_kid
        JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
      })
    },
    {
      operation_id = "getUserGroupsUsingGET"
      xml_content = templatefile("./api/selfcare_support_service/v1/jwt_auth_op_policy_user_group.xml.tpl", {
        USER_GROUP_BACKEND_BASE_URL = "http://${var.private_dns_name}/ms-user-group/user-groups/v1/"
        API_DOMAIN                  = local.api_domain
        KID                         = module.jwt.jwt_kid
        JWT_CERTIFICATE_THUMBPRINT  = azurerm_api_management_certificate.jwt_certificate.thumbprint
      })
    },
    {
      operation_id = "getUserInfoUsingPOST"
      xml_content = templatefile("./api/selfcare_support_service/v1/jwt_auth_op_policy.xml.tpl", {
        API_DOMAIN                 = local.api_domain
        KID                        = module.jwt.jwt_kid
        JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
      })
    },
    {
      operation_id = "getUserInfoUsingGET"
      xml_content = templatefile("./api/selfcare_support_service/v1/support_op_policy.xml.tpl", {
        BACKEND_BASE_URL   = "http://${var.private_dns_name}/ms-core/v1/"
        API_DOMAIN                 = local.api_domain
        KID                        = module.jwt.jwt_kid
        JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
      })
    },
    {
      operation_id = "getInstitutionUsersUsingGET"
      xml_content = templatefile("./api/selfcare_support_service/v1/support_op_policy.xml.tpl", {
        BACKEND_BASE_URL   = "http://${var.private_dns_name}/ms-core/v1/"
        API_DOMAIN                 = local.api_domain
        KID                        = module.jwt.jwt_kid
        JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
      })
    },
    {
      operation_id = "getDelegationsUsingGET"
      xml_content = templatefile("./api/selfcare_support_service/v1/support_op_policy.xml.tpl", {
        BACKEND_BASE_URL = "http://${var.private_dns_name}/ms-core/v1/"
        API_DOMAIN                     = local.api_domain
        KID                            = module.jwt.jwt_kid
        JWT_CERTIFICATE_THUMBPRINT     = azurerm_api_management_certificate.jwt_certificate.thumbprint
      })
    },
    {
      operation_id = "onboardingInstitutionUsersUsingPOST"
      xml_content = templatefile("./api/selfcare_support_service/v1/support_op_policy.xml.tpl", {
        BACKEND_BASE_URL   = "http://${var.private_dns_name}/ms-core/v1/"
        API_DOMAIN                 = local.api_domain
        KID                        = module.jwt.jwt_kid
        JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
      })
    },
    {
      operation_id = "getUsersUsingGET"
      xml_content = templatefile("./api/selfcare_support_service/v1/support_op_policy.xml.tpl", {
        BACKEND_BASE_URL   = "http://${var.private_dns_name}/ms-core/v1/"
        API_DOMAIN                 = local.api_domain
        KID                        = module.jwt.jwt_kid
        JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
      })
    },
    {
      operation_id = "getAllTokensUsingGET"
      xml_content = templatefile("./api/selfcare_support_service/v1/support_op_policy.xml.tpl", {
        BACKEND_BASE_URL   = "http://${var.private_dns_name}/ms-core/v1/"
        API_DOMAIN                 = local.api_domain
        KID                        = module.jwt.jwt_kid
        JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
      })
    }
  ]
}


resource "azurerm_api_management_api_version_set" "apim_party_registry_proxy" {
  name                = format("%s-party-registry-proxy-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = "Party Registry Proxy"
  versioning_scheme   = "Segment"
}

module "apim_party_registry_proxy_v1" {
  source              = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v7.3.0"
  name                = format("%s-party-registry-proxy-api", local.project)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
  version_set_id      = azurerm_api_management_api_version_set.apim_party_registry_proxy.id


  description  = "This service is the party registry proxy"
  display_name = "Party Registry Proxy V1"
  path         = "external/party-registry-proxy"
  api_version  = "v1"
  protocols    = ["https"]

  service_url = "http://${var.private_dns_name}/party-registry-proxy"

  content_format = "openapi"
  content_value = templatefile("./api/party_registry_proxy/v1/open-api.yml.tpl", {
    host     = azurerm_api_management_custom_domain.api_custom_domain.gateway[0].host_name
    basePath = "party-registry-proxy/v1"
  })

  xml_content = templatefile("./api/jwt_base_policy.xml.tpl", {
    API_DOMAIN                 = local.api_domain
    KID                        = module.jwt.jwt_kid
    JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
  })

  subscription_required = true

  api_operation_policies = [
    {
      operation_id = "findCategoriesUsingGET"
      xml_content = templatefile("./api/party_registry_proxy/party_op_policy.xml.tpl", {
        API_DOMAIN                 = local.api_domain
        KID                        = module.jwt.jwt_kid
        JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
      })
    },
    {
      operation_id = "findCategoryUsingGET"
      xml_content = templatefile("./api/party_registry_proxy/party_op_policy.xml.tpl", {
        API_DOMAIN                 = local.api_domain
        KID                        = module.jwt.jwt_kid
        JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
      })
    },
    {
      operation_id = "searchUsingGET"
      xml_content = templatefile("./api/party_registry_proxy/party_op_policy.xml.tpl", {
        API_DOMAIN                 = local.api_domain
        KID                        = module.jwt.jwt_kid
        JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
      })
    },
    {
      operation_id = "findInstitutionUsingGET"
      xml_content = templatefile("./api/party_registry_proxy/party_op_policy.xml.tpl", {
        API_DOMAIN                 = local.api_domain
        KID                        = module.jwt.jwt_kid
        JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
      })
    },
    {
      operation_id = "legalAddressUsingGET"
      xml_content = templatefile("./api/party_registry_proxy/party_op_policy.xml.tpl", {
        API_DOMAIN                 = local.api_domain
        KID                        = module.jwt.jwt_kid
        JWT_CERTIFICATE_THUMBPRINT = azurerm_api_management_certificate.jwt_certificate.thumbprint
      })
    }
  ]
}

resource "azurerm_api_management_api_version_set" "apim_external_api_contract" {
  name                = format("%s-external-api-contract", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = "External API Contract"
  versioning_scheme   = "Segment"
}

module "apim_external_api_contract_v1" {
  source              = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v7.3.0"
  name                = format("%s-external-api-contract-service", local.project)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
  version_set_id      = azurerm_api_management_api_version_set.apim_external_api_contract.id

  description  = "This service is the proxy for external get contract"
  display_name = "External API service get contract"
  path         = "external/contract"
  api_version  = "v1"
  protocols = [
    "https"
  ]

  service_url = format("http://%s/external-api/v1/", var.private_dns_name)

  content_format = "openapi"
  content_value = templatefile("./api/external_api_contract/v1/open-api.yml.tpl", {
    host     = azurerm_api_management_custom_domain.api_custom_domain.gateway[0].host_name
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
      operation_id = "getContractUsingGET"
      xml_content = templatefile("./api/external_api_contract/v1/getContractUsingGet_op_policy.xml.tpl", {
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
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v7.3.0"

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

module "apim_product_interop_coll" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v7.3.0"

  product_id   = "interop-coll"
  display_name = "INTEROP COLLAUDO"
  description  = "Interoperabilità Collaudo"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/interop-coll/policy.xml")
}

module "apim_product_pn" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v7.3.0"

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

module "apim_product_pn_svil" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v7.3.0"

  product_id   = "pn-svil"
  display_name = "PN SVIL"
  description  = "Piattaforma Notifiche"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/pn_svil/policy.xml")
}

module "apim_product_pn_dev" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v7.3.0"

  product_id   = "pn-dev"
  display_name = "PN DEV"
  description  = "Piattaforma Notifiche"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/pn_dev/policy.xml")
}

module "apim_product_pn_uat" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v7.3.0"

  product_id   = "pn-uat"
  display_name = "PN UAT"
  description  = "Piattaforma Notifiche"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/pn_uat/policy.xml")
}

module "apim_product_pn_test" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v7.3.0"

  product_id   = "pn-test"
  display_name = "PN TEST"
  description  = "Piattaforma Notifiche"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/pn_test/policy.xml")
}

module "apim_product_pn_coll" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v7.3.0"

  product_id   = "pn-coll"
  display_name = "PN COLL"
  description  = "Piattaforma Notifiche"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/pn_coll/policy.xml")
}

module "apim_product_pn_hotfix" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v7.3.0"

  product_id   = "pn-hotfix"
  display_name = "PN HOTFIX"
  description  = "Piattaforma Notifiche"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/pn_hotfix/policy.xml")
}

module "apim_product_pn_cert" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v7.3.0"

  product_id   = "pn-cert"
  display_name = "PN CERT"
  description  = "Piattaforma Notifiche"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/pn_cert/policy.xml")
}

module "apim_product_pn_prod" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v7.3.0"

  product_id   = "pn-prod"
  display_name = "PN PROD"
  description  = "Piattaforma Notifiche"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/pn_prod/policy.xml")
}

module "apim_product_pagopa" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v7.3.0"

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
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v7.3.0"

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

module "apim_product_io_sign" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v7.3.0"

  product_id   = "io-sign"
  display_name = "io-sign"
  description  = "Firma con IO"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/io-sign/policy.xml")
}

module "apim_product_io" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v7.3.0"

  product_id   = "io"
  display_name = "IO"
  description  = "App IO"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/io/policy.xml")
}

module "apim_product_io_premium" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v7.3.0"

  product_id   = "io-premium"
  display_name = "IO Premium"
  description  = "App IO Premium"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/io-premium/policy.xml")
}

module "apim_product_test_io" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v6.20.0"

  product_id   = "test-io"
  display_name = "Test IO"
  description  = "Test App IO"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/test-io/policy.xml")
}

module "apim_product_test_io_premium" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v6.20.0"

  product_id   = "test-io-premium"
  display_name = "Test IO Premium"
  description  = "Test App IO Premium"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/test-io-premium/policy.xml")
}

module "apim_product_support_io" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v6.20.0"

  product_id   = "prod-io"
  display_name = "Support IO"
  description  = "Support for APP IO"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/support-io/policy.xml")
}

module "apim_product_fd" {
  # source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.16"
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v7.3.0"

  product_id   = "prod-fd"
  display_name = "Fideiussioni Digitali"
  description  = "Fideiussioni Digitali"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/prod-fd/policy.xml")
}
module "apim_product_fd_garantito" {
  # source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.16"
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v7.3.0"

  product_id   = "prod-fd-garantito"
  display_name = "Fideiussioni Digitali Garantito"
  description  = "Fideiussioni Digitali Garantito"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/prod-fd-garantito/policy.xml")
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

data "azurerm_key_vault_secret" "external-oauth2-issuer" {
  name         = "external-oauth2-issuer"
  key_vault_id = module.key_vault.id
}
