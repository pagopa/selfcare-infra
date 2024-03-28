output "container_app_environment_selfcare" {
  value = {
    id                  = azurerm_container_app_environment.cae_selc.id
    name                = azurerm_container_app_environment.cae_selc.name
    resource_group_name = azurerm_container_app_environment.cae_selc.resource_group_name
  }
}
