data "azurerm_key_vault" "key_vault" {
  name                = local.key_vault_name
  resource_group_name = local.key_vault_resource_group
}

data "azurerm_key_vault_certificate_data" "values" {
  for_each     = var.secrets_tls_certificates
  name         = each.value
  key_vault_id = data.azurerm_key_vault.key_vault.id
}
