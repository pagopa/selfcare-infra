data "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = "${var.project}-law"
  resource_group_name = "${var.project}-monitor-rg"
}
