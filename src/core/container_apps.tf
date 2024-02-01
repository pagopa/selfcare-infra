resource "azurerm_resource_group" "selc_container_app_rg" {
  name     = "${local.project}-container-app-rg"
  location = var.location

  tags = var.tags
}

resource "azurerm_subnet" "selc_container_app_snet" {
  count                = var.cidr_subnet_selc != null ? 1 : 0
  name                 = "${local.project}-container-app-snet"
  resource_group_name  = azurerm_resource_group.rg_vnet.name
  virtual_network_name = module.vnet.name
  address_prefixes     = var.cidr_subnet_selc
}

module "selc_cae" {
  source = "github.com/pagopa/terraform-azurerm-v3.git//container_app_environment?ref=v7.50.1"

  name                      = "${local.project}-cae"
  resource_group_name       = azurerm_resource_group.selc_container_app_rg.name
  location                  = azurerm_resource_group.selc_container_app_rg.location
  vnet_internal             = true
  subnet_id                 = azurerm_subnet.selc_container_app_snet[0].id
  log_destination           = "log-analytics"
  log_analytics_customer_id = azurerm_log_analytics_workspace.log_analytics_workspace.workspace_id
  log_analytics_shared_key  = azurerm_log_analytics_workspace.log_analytics_workspace.primary_shared_key
  zone_redundant            = var.cae_zone_redundant

  tags = var.tags
}
