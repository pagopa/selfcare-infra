resource "azurerm_resource_group" "rg_pair_vnet" {
  name     = "${local.project_pair}-vnet-rg"
  location = var.location_pair

  tags = var.tags
}

module "vnet_pair" {
  source              = "github.com/pagopa/terraform-azurerm-v3.git//virtual_network?ref=v7.50.1"
  name                = "${local.project_pair}-vnet"
  location            = azurerm_resource_group.rg_pair_vnet.location
  resource_group_name = azurerm_resource_group.rg_pair_vnet.name
  address_space       = var.cidr_pair_vnet

  tags = var.tags
}

## Peering between the vnet(main) and integration vnet
module "vnet_peering_pair_vs_core" {
  source = "github.com/pagopa/terraform-azurerm-v3.git//virtual_network_peering?ref=v7.50.1"

  source_resource_group_name       = azurerm_resource_group.rg_pair_vnet.name
  source_virtual_network_name      = module.vnet_pair.name
  source_remote_virtual_network_id = module.vnet_pair.id
  source_allow_gateway_transit     = false
  source_use_remote_gateways       = true
  # needed by vpn gateway for enabling routing from vnet to vnet_integration
  source_allow_forwarded_traffic = true

  target_resource_group_name       = azurerm_resource_group.rg_vnet.name
  target_virtual_network_name      = module.vnet.name
  target_remote_virtual_network_id = module.vnet.id
  target_allow_gateway_transit     = true
  target_use_remote_gateways       = false

  target_allow_forwarded_traffic = true
}

## Peering between the vnet(pair) and aks
module "vnet_peering_pair_vs_aks" {
  source = "github.com/pagopa/terraform-azurerm-v3.git//virtual_network_peering?ref=v7.50.1"

  source_resource_group_name       = azurerm_resource_group.rg_pair_vnet.name
  source_virtual_network_name      = module.vnet_pair.name
  source_remote_virtual_network_id = module.vnet_pair.id
  source_allow_gateway_transit     = false
  source_use_remote_gateways       = false
  # needed by vpn gateway for enabling routing from vnet to vnet_integration
  source_allow_forwarded_traffic = true

  target_resource_group_name       = azurerm_resource_group.rg_vnet_aks.name
  target_virtual_network_name      = module.vnet_aks_platform.name
  target_remote_virtual_network_id = module.vnet_aks_platform.id
  target_allow_gateway_transit     = true
  target_use_remote_gateways       = false
  target_allow_forwarded_traffic   = true
}
