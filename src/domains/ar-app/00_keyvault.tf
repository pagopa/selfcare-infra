data "azurerm_key_vault" "kv_core" {
  name                = local.key_vault_name
  resource_group_name = local.key_vault_resource_group
}
