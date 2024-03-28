resource "azurerm_container_app_environment" "cae_pnpg" {
  name                = "${var.project}-pnpg-cae"
  location            = var.location
  resource_group_name = var.resource_group_name

  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics_workspace.id

  infrastructure_subnet_id       = var.subnet_id
  zone_redundancy_enabled        = var.subnet_id == null ? null : var.zone_redundant
  internal_load_balancer_enabled = true

  workload_profile {
    name                  = "Consumption"
    workload_profile_type = "Consumption"
    minimum_count         = 0
    maximum_count         = 1
  }
}

resource "azurerm_management_lock" "lock_pnpg_cae" {
  lock_level = "CanNotDelete"
  name       = "${var.project}-cae"
  notes      = "This Container App Environment cannot be deleted"
  scope      = azurerm_container_app_environment.cae_pnpg.id
}
