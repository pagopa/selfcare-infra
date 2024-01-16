data "azurerm_key_vault" "key_vault_common" {
  name                = var.key_vault.name
  resource_group_name = var.key_vault.resource_group_name
}

data "azurerm_log_analytics_workspace" "law" {
  name                = var.law.name
  resource_group_name = var.law.resource_group_name
}
