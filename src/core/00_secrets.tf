module "secrets_selfcare_status_dev" {
  count = var.env_short == "d" ? 1 : 0

  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault_secrets_query?ref=v6.14.0"

  resource_group = azurerm_resource_group.sec_rg.name
  key_vault_name = module.key_vault.name

  secrets = [
    "alert-selfcare-status-dev-email",
    "alert-selfcare-status-dev-slack",
  ]
}

module "secrets_selfcare_status_uat" {
  count = var.env_short == "u" ? 1 : 0

  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault_secrets_query?ref=v6.14.0"

  resource_group = azurerm_resource_group.sec_rg.name
  key_vault_name = module.key_vault.name

  secrets = [
    "alert-selfcare-status-uat-email",
    "alert-selfcare-status-uat-slack",
  ]
}
