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

resource "azurerm_subnet" "selc_pnpg_container_app_snet" {
  count                = var.cidr_subnet_selc_pnpg != null ? 1 : 0
  name                 = "${local.project}-pnpg-container-app-snet"
  resource_group_name  = azurerm_resource_group.rg_vnet.name
  virtual_network_name = module.vnet.name
  address_prefixes     = var.cidr_subnet_selc_pnpg
}

module "selc_cae" {
  source = "github.com/pagopa/terraform-azurerm-v3.git//container_app_environment_v2?ref=v7.50.1"

  resource_group_name = azurerm_resource_group.selc_container_app_rg.name
  location            = azurerm_resource_group.selc_container_app_rg.location
  name                = "${local.project}-cae"

  subnet_id              = azurerm_subnet.selc_container_app_snet[0].id
  internal_load_balancer = true
  zone_redundant         = var.cae_zone_redundant

  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id

  tags = var.tags
}

module "selc_pnpg_cae" {
  source = "github.com/pagopa/terraform-azurerm-v3.git//container_app_environment_v2?ref=v7.50.1"

  resource_group_name = azurerm_resource_group.selc_container_app_rg.name
  location            = azurerm_resource_group.selc_container_app_rg.location
  name                = "${local.project}-pnpg-cae"

  subnet_id              = azurerm_subnet.selc_pnpg_container_app_snet[0].id
  internal_load_balancer = true
  zone_redundant         = var.cae_zone_redundant_pnpg

  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id

  tags = var.tags
}
