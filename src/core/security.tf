resource "azurerm_resource_group" "sec_rg" {
  name     = format("%s-sec-rg", local.project)
  location = var.location

  tags = var.tags
}

module "key_vault" {
  source              = "git::https://github.com/pagopa/azurerm.git//key_vault?ref=v1.0.73"
  name                = format("%s-kv", local.project)
  location            = azurerm_resource_group.sec_rg.location
  resource_group_name = azurerm_resource_group.sec_rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  lock_enable         = var.lock_enable

  tags = var.tags
}

# ## api management policy ##
resource "azurerm_key_vault_access_policy" "api_management_policy" {
  key_vault_id = module.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = module.apim.principal_id

  key_permissions         = []
  secret_permissions      = ["Get", "List"]
  certificate_permissions = ["Get", "List"]
  storage_permissions     = []
}

## user assined identity: (application gateway) ##
resource "azurerm_key_vault_access_policy" "app_gateway_policy" {
  key_vault_id = module.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_user_assigned_identity.appgateway.principal_id

  key_permissions         = []
  secret_permissions      = ["Get", "List"]
  certificate_permissions = ["Get", "List"]
  storage_permissions     = []
}

# Azure AD
data "azuread_group" "adgroup_admin" {
  display_name = format("%s-adgroup-admin", local.project)
}

## ad group policy ##
resource "azurerm_key_vault_access_policy" "adgroup_admin_policy" {
  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.adgroup_admin.object_id

  key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", ]
  secret_permissions      = ["Get", "List", "Set", "Delete", ]
  storage_permissions     = []
  certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Restore", "Purge", "Recover", ]
}

data "azuread_group" "adgroup_developers" {
  display_name = format("%s-adgroup-developers", local.project)
}

## ad group policy ##
resource "azurerm_key_vault_access_policy" "adgroup_developers_policy" {
  count = var.env_short == "d" ? 1 : 0

  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.adgroup_developers.object_id

  key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", ]
  secret_permissions      = ["Get", "List", "Set", "Delete", ]
  storage_permissions     = []
  certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Restore", "Purge", "Recover", ]
}

data "azuread_group" "adgroup_externals" {
  display_name = format("%s-adgroup-externals", local.project)
}

## ad group policy ##
resource "azurerm_key_vault_access_policy" "adgroup_externals_policy" {
  count = var.env_short == "d" ? 1 : 0

  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.adgroup_externals.object_id

  key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", ]
  secret_permissions      = ["Get", "List", "Set", "Delete", ]
  storage_permissions     = []
  certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Restore", "Purge", "Recover", ]
}

data "azuread_group" "adgroup_security" {
  display_name = format("%s-adgroup-security", local.project)
}

## ad group policy ##
resource "azurerm_key_vault_access_policy" "adgroup_security_policy" {
  count = var.env_short == "d" ? 1 : 0

  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.adgroup_security.object_id

  key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", ]
  secret_permissions      = ["Get", "List", "Set", "Delete", ]
  storage_permissions     = []
  certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Restore", "Purge", "Recover", ]
}

## azure devops ##
data "azuread_service_principal" "azdo_sp_tls_cert" {
  count        = var.azdo_sp_tls_cert_enabled ? 1 : 0
  display_name = format("azdo-sp-%s-tls-cert", local.project)
}

resource "azurerm_key_vault_access_policy" "azdo_sp_tls_cert" {
  count        = var.azdo_sp_tls_cert_enabled ? 1 : 0
  key_vault_id = module.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azuread_service_principal.azdo_sp_tls_cert[0].object_id

  certificate_permissions = [
    "Get",
    "List",
    "Import",
  ]
}

resource "azurerm_key_vault_access_policy" "azure_cdn_frontdoor_policy" {
  key_vault_id = module.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = var.azuread_service_principal_azure_cdn_frontdoor_id

  secret_permissions = [
    "Get",
  ]

  certificate_permissions = [
    "Get",
  ]
}

resource "azurerm_user_assigned_identity" "appgateway" {
  resource_group_name = azurerm_resource_group.sec_rg.name
  location            = azurerm_resource_group.sec_rg.location
  name                = format("%s-appgateway-identity", local.project)

  tags = var.tags
}

data "azurerm_key_vault_certificate" "app_gw_platform" {
  name         = var.app_gateway_api_certificate_name
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "monitor_notification_slack_email" {
  name         = "monitor-notification-slack-email"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "monitor_notification_email" {
  name         = "monitor-notification-email"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "apim_publisher_email" {
  name         = "apim-publisher-email"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "sec_workspace_id" {
  count        = var.env_short == "p" ? 1 : 0
  name         = "sec-workspace-id"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "sec_storage_id" {
  count        = var.env_short == "p" ? 1 : 0
  name         = "sec-storage-id"
  key_vault_id = module.key_vault.id
}

# JWT
module "jwt" {
  source = "../modules/jwt"

  jwt_name         = "jwt"
  key_vault_id     = module.key_vault.id
  cert_common_name = "apim"
  cert_password    = ""
  tags             = var.tags
}

module "jwt_exchange" {
  source = "../modules/jwt"

  jwt_name         = "jwt-exchange"
  key_vault_id     = module.key_vault.id
  cert_common_name = "selfcare.pagopa.it"
  cert_password    = ""
  tags             = var.tags
}

module "agid_spid" {
  source = "../modules/jwt"

  jwt_name         = "agid-spid"
  key_vault_id     = module.key_vault.id
  cert_common_name = "selfcare.pagopa.it"
  cert_password    = ""
  tags             = var.tags
}

resource "null_resource" "upload_jwks" {
  triggers = {
    "changes-in-jwt" : module.jwt.certificate_data_pem
    "changes-in-jwt-exchange" : module.jwt_exchange.certificate_data_pem
  }
  provisioner "local-exec" {
    command = <<EOT
              mkdir -p "${path.module}/.terraform/tmp"
              pip install --require-hashes --requirement "${path.module}/utils/py/requirements.txt"
              az storage blob download \
                --container-name '$web' \
                --account-name ${replace(replace(module.checkout_cdn.name, "-cdn-endpoint", "-sa"), "-", "")} \
                --account-key ${module.checkout_cdn.storage_primary_access_key} \
                --file "${path.module}/.terraform/tmp/oldJwks.json" \
                --name '.well-known/jwks.json'
              python "${path.module}/utils/py/jwksFromPems.py" "${path.module}/.terraform/tmp/oldJwks.json" "${module.jwt.jwt_kid}" "${module.jwt.certificate_data_pem}" "${module.jwt_exchange.jwt_kid}" "${module.jwt_exchange.certificate_data_pem}" > "${path.module}/.terraform/tmp/jwks.json"
              if [ $? -eq 1 ]
              then
                exit 1
              fi
              az storage blob upload \
                --container-name '$web' \
                --account-name ${replace(replace(module.checkout_cdn.name, "-cdn-endpoint", "-sa"), "-", "")} \
                --account-key ${module.checkout_cdn.storage_primary_access_key} \
                --file "${path.module}/.terraform/tmp/jwks.json" \
                --name '.well-known/jwks.json'
              az cdn endpoint purge \
                -g ${azurerm_resource_group.checkout_fe_rg.name} \
                -n ${module.checkout_cdn.name} \
                --profile-name ${replace(module.checkout_cdn.name, "-cdn-endpoint", "-cdn-profile")} \
                --content-paths "/.well-known/jwks.json" \
                --no-wait
          EOT
  }
}
