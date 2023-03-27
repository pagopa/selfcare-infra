##############
## Products ##
##############

module "apim_pnpg" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.92"

  product_id   = "pnpg-be"
  display_name = local.apim_pnpg_api.display_name
  description  = local.apim_pnpg_api.display_name

  api_management_name = local.apim_name
  resource_group_name = local.apim_rg

  published             = false
  subscription_required = false
  approval_required     = false
  # subscriptions_limit   = 1000

  policy_xml = file("./api/external_api_data_vault/v1/base_policy.xml")
}

locals {
  apim_pnpg_api = {
    display_name          = "PnPg Product"
    description           = "API to manage PNPG operations"
    path                  = "pnpg"
    subscription_required = false
    service_url           = null
  }
  apim_name        = "${local.product}-apim"
  apim_rg          = "${local.product}-api-rg"
  pnpg_hostname    = var.env == "prod" ? "api-pnpg.selfcare.pagopa.it" : "api-pnpg.${var.env}.selfcare.pagopa.it"
  pnpg_fe_hostname = var.env == "prod" ? "selfcare.platform.pagopa.it" : "selfcare.${var.env}.platform.pagopa.it"

  cdn_storage_hostname = "${var.prefix}${var.env_short}${var.location_short}${var.domain}checkoutsa"
}
#########
## API ##
#########

resource "azurerm_api_management_api_version_set" "apim_external_api_data_vault" {
  name                = format("%s-external-api-data-vault", var.env_short)
  resource_group_name = local.apim_rg
  api_management_name = local.apim_name
  display_name        = "Data Vault for PNPG"
  versioning_scheme   = "Segment"
}

module "apim_external_api_data_vault_v1" {
  source              = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.92"
  name                = format("%s-external-api-pnpg", local.project)
  api_management_name = local.apim_name
  resource_group_name = local.apim_rg
  version_set_id      = azurerm_api_management_api_version_set.apim_external_api_data_vault.id

  description  = "External API Data Vault"
  display_name = "External API Data Vault"
  path         = "external/data-vault"
  api_version  = "v1"
  protocols    = [
    "https"
  ]

  service_url = format("http://%s/external-api/v1/", var.reverse_proxy_ip)

  content_format = "openapi"
  content_value  = templatefile("./api/external_api_data_vault/v1/open-api.yml.tpl", {
    host     = local.pnpg_hostname
    basePath = "v1"
  })

  xml_content           = file("./api/external_api_data_vault/v1/base_policy.xml")
  subscription_required = true

  product_ids = [
  ]

  api_operation_policies = [
    {
      operation_id = "getInstitution"
      xml_content  = templatefile("./api/external_api_data_vault/v1/getInstitution_op_policy.xml.tpl", {
        CDN_STORAGE_URL                = "https://${local.cdn_storage_hostname}"
        PARTY_PROCESS_BACKEND_BASE_URL = "http://${var.reverse_proxy_ip}/ms-core/v1/"
      })
    }
  ]
}


resource "azurerm_api_management_named_value" "apim_named_value_backend_access_token" {

  name                = "backend-access-token-pnpg"
  api_management_name = local.apim_name
  resource_group_name = local.apim_rg

  display_name = "backend-access-token-pnpg"
  secret       = true
  value_from_key_vault {
    secret_id = data.azurerm_key_vault_secret.apim_backend_access_token.id
  }

}

data "azurerm_key_vault_secret" "apim_backend_access_token" {
  name         = "apim-backend-access-token"
  key_vault_id = data.azurerm_key_vault.kv_domain.id
}

module "apim_data_vault_product_pn_pg" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.16"

  product_id   = "prod-pnpg"
  display_name = "PNPG"
  description  = "Piattaforma Notifiche Persone Giuridiche"

  api_management_name = local.apim_name
  resource_group_name = local.apim_rg

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/pnpg/policy.xml")
}
