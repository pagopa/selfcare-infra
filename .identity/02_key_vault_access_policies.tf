data "azurerm_key_vault" "key_vault" {
  resource_group_name = local.security_rg
  name                = local.key_vault_name
}

resource "azurerm_key_vault_access_policy" "github_identity_ci_key_vault_policy" {
  key_vault_id = data.azurerm_key_vault.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_user_assigned_identity.this_ci.principal_id

  secret_permissions = [
    "Get",
  ]

  certificate_permissions = [
    "Get"
  ]
}

resource "azurerm_key_vault_access_policy" "github_identity_cd_key_vault_policy" {
  key_vault_id = data.azurerm_key_vault.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_user_assigned_identity.this_cd.principal_id

  secret_permissions = [
    "Get",
  ]

  certificate_permissions = [
    "Get"
  ]
}
