# certificate api.selfcare.pagopa.it
data "azurerm_key_vault_certificate" "app_gw_platform" {
  name         = var.app_gateway_api_certificate_name
  key_vault_id = module.key_vault.id
}

# certificate api-pnpg.selfcare.pagopa.it
data "azurerm_key_vault_certificate" "api_pnpg_selfcare_certificate" {
  name         = var.app_gateway_api_pnpg_certificate_name
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

data "azurerm_key_vault_secret" "hub_docker_user" {
  name         = "hub-docker-user"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "hub_docker_pwd" {
  name         = "hub-docker-pwd"
  key_vault_id = module.key_vault.id
}