resource "azuread_application" "selfcare_fd_client" {
  display_name = "${local.project}-fd-client"
}

resource "azuread_service_principal" "selfcare_fd_client" {
  application_id = azuread_application.selfcare_fd_client.application_id
}

resource "time_rotating" "selfcare_fd_client_application" {
  rotation_days = 300
}

resource "azuread_application_password" "selfcare_fd_client" {
  application_object_id = azuread_application.selfcare_fd_client.object_id
  display_name          = "managed by terraform"
  end_date_relative     = "8640h" # 360 days
  rotate_when_changed = {
    rotation = time_rotating.selfcare_fd_client_application.id
  }
}

resource "azurerm_key_vault_secret" "selfcare_fd_client_service_principal_client_id" {
  name         = "${local.project}-fd-client-id"
  value        = azuread_service_principal.selfcare_fd_client.application_id
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "selfcare_fd_service_principal_client_secret" {
  name         = "${local.project}-fd-client-secret"
  value        = azuread_application_password.selfcare_fd_client.value
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}
