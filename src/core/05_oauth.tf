resource "azuread_application" "selfcare_fd" {
  display_name = "${local.project}-selfcare-fd"
}

resource "azuread_service_principal" "selfcare_fd" {
  application_id = azuread_application.selfcare_fd.application_id
}

resource "azurerm_role_assignment" "selfcare_fd_apim_contributor" {
  scope                = module.apim.id
  role_definition_name = "API Management Service Contributor"
  principal_id         = azuread_service_principal.selfcare_fd.object_id
}

resource "time_rotating" "selfcare_fd_application" {
  rotation_days = 300
}

resource "azuread_application_password" "selfcare_fd" {
  application_object_id = azuread_application.selfcare_fd.object_id
  display_name          = "managed by terraform"
  end_date_relative     = "8640h" # 360 days
  rotate_when_changed = {
    rotation = time_rotating.selfcare_fd_application.id
  }
}

resource "azurerm_key_vault_secret" "selfcare_fd_service_principal_client_id" {
  name         = "${local.project}-selfcare-fd-client-id"
  value        = azuread_service_principal.selfcare_fd.application_id
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "selfcare_fd_service_principal_client_secret" {
  name         = "${local.project}-selfcare-fd-client-secret"
  value        = azuread_application_password.selfcare_fd.value
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}
