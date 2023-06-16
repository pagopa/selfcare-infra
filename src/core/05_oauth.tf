#
# Issuer
#

resource "random_uuid" "scope_id" {}

resource "random_uuid" "identifier_uri" {}

resource "azuread_application" "external_oauth2_issuer" {
  display_name    = "${local.project}-external-oauth2-issuer"
  identifier_uris = ["api://${local.project}-external-oauth2-issuer"]

  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000" # microsoft graph

    resource_access {
      id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d" # (Delegated) User.Read
      type = "Scope"
    }
  }

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

resource "azuread_service_principal" "external_oauth2_issuer" {
  application_id = azuread_application.external_oauth2_issuer.application_id
}

resource "azurerm_role_assignment" "external_oauth2_issuer_apim_contributor" {
  scope                = module.apim.id
  role_definition_name = "API Management Service Contributor"
  principal_id         = azuread_service_principal.external_oauth2_issuer.object_id
}

#
# Client
#
resource "azuread_application" "external_oauth2_client_fd" {
  display_name = "${local.project}-external-oauth2-client-fd"

  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000" # microsoft graph

    resource_access {
      id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d" # (Delegated) User.Read
      type = "Scope"
    }
  }

}

resource "time_rotating" "client" {
  rotation_days = 7
}

resource "azuread_application_password" "external_oauth2_client_fd_password" {
  application_object_id = azuread_application.external_oauth2_client_fd.object_id
  rotate_when_changed = {
    rotation = time_rotating.client.id
  }
}

resource "azuread_service_principal" "external_oauth2_client_fd_sp" {
  application_id = azuread_application.external_oauth2_client_fd.application_id
}
