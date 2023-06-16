resource "random_uuid" "scope_id" {}

resource "azuread_application" "selfcare_fd" {
  display_name = "${local.project}-selfcare-fd"

  api {
    oauth2_permission_scope {
      admin_consent_description  = "adminApi"
      admin_consent_display_name = "adminApi"
      enabled                    = true
      id                         = random_uuid.scope_id.result
      type                       = "User"
      user_consent_description   = "userConsent"
      user_consent_display_name  = "userConsent"
      value                      = "userConsent"
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
