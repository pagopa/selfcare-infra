resource "random_uuid" "prova_scope_id" {}

resource "azuread_application" "selfcare_fd" {
  display_name = "${local.project}-selfcare-fd"

  api {
    oauth2_permission_scope {
      admin_consent_description  = "prova"
      admin_consent_display_name = "provaAdmin"
      enabled                    = true
      id                         = random_uuid.prova_scope_id.result
      type                       = "User"
      user_consent_description   = ""
      user_consent_display_name  = "provaUser"
      value                      = "prova"
    }
  }
}

resource "azuread_service_principal" "selfcare_fd" {
  application_id = azuread_application.selfcare_fd.application_id
}

resource "azurerm_role_assignment" "selfcare_fd_apim_contributor" {
  scope                = module.apim.id
  role_definition_name = "API Management Service Contributor"
  principal_id         = azuread_service_principal.selfcare_fd.object_id
}
