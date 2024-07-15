resource "azurerm_container_app_environment" "cae_selc" {
  name                = var.selc_cae_name
  location            = var.location
  resource_group_name = var.selc_resource_group_name

  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics_workspace.id

  infrastructure_subnet_id       = var.selc_subnet_id
  zone_redundancy_enabled        = var.selc_subnet_id == null ? null : var.zone_redundant
  internal_load_balancer_enabled = true

  dynamic "workload_profile" {
    for_each = var.selc_workload_profiles
    content {
      name                  = workload_profile.value.name
      workload_profile_type = workload_profile.value.workload_profile_type
      minimum_count         = workload_profile.value.minimum_count
      maximum_count         = workload_profile.value.maximum_count
    }
  }
}

resource "azurerm_management_lock" "lock_selc_cae" {
  lock_level = "CanNotDelete"
  name       = "${var.project}-cae"
  notes      = "This Container App Environment cannot be deleted"
  scope      = azurerm_container_app_environment.cae_selc.id
}
