output "container_app_environment_selfcare" {
  value = {
    id                  = azurerm_container_app_environment.cae_selc.id
    name                = azurerm_container_app_environment.cae_selc.name
    resource_group_name = azurerm_container_app_environment.cae_selc.resource_group_name
  }
}

output "container_app_environment_pnpg" {
  value = {
    id                  = azurerm_container_app_environment.cae_pnpg.id
    name                = azurerm_container_app_environment.cae_pnpg.name
    resource_group_name = azurerm_container_app_environment.cae_pnpg.resource_group_name
  }
}

output "user_assigned_identity_selfcare" {
  value = {
    id           = azurerm_user_assigned_identity.cae_identity_selc.id
    name         = azurerm_user_assigned_identity.cae_identity_selc.name
    client_id    = azurerm_user_assigned_identity.cae_identity_selc.client_id
    principal_id = azurerm_user_assigned_identity.cae_identity_selc.principal_id
  }

  description = "Details about the user-assigned managed identity created to manage roles of the Container Apps of Selfcare Environment"
}

output "user_assigned_identity_pnpg" {
  value = {
    id           = azurerm_user_assigned_identity.cae_identity_pnpg.id
    name         = azurerm_user_assigned_identity.cae_identity_pnpg.name
    client_id    = azurerm_user_assigned_identity.cae_identity_pnpg.client_id
    principal_id = azurerm_user_assigned_identity.cae_identity_pnpg.principal_id
  }

  description = "Details about the user-assigned managed identity created to manage roles of the Container Apps of PNPG Environment"
}