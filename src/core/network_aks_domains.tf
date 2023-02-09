resource "azurerm_resource_group" "rg_vnet_aks" {

  name     = "${local.project}-${var.location_short}-vnet-rg"
  location = var.location

  tags = var.tags
}

# vnet
module "vnet_aks" {
  source = "git::https://github.com/pagopa/azurerm.git//virtual_network?ref=v4.3.2"

  name                 = "${local.project}-${var.location_short}-vnet"
  location             = var.location
  resource_group_name  = azurerm_resource_group.rg_vnet_aks.name
  address_space        = var.cidr_aks_vnet

  tags = var.tags
}

#
#  AKS public IP
#

resource "azurerm_public_ip" "outbound_ip_aks_platform" {

  name                = "${local.project}-${var.location_short}-aksplatformoutbound-pip"
  domain_name_label   = "${local.project}-${var.location_short}-aksplatformoutbound-pip"
  location            = azurerm_resource_group.rg_vnet_aks.location
  resource_group_name = azurerm_resource_group.rg_vnet_aks.name
  sku                 = "Standard"
  allocation_method   = "Static"

  availability_zone = "Zone-Redundant"

  tags = var.tags
}

# #
# # PEERINGS
# #

# module "vnet_peering_core_2_aks" {
#   source = "git::https://github.com/pagopa/azurerm.git//virtual_network_peering?ref=v2.16.0"

#   for_each = { for n in var.aks_networks : n.domain_name => n }

#   location = var.location

#   source_resource_group_name       = azurerm_resource_group.rg_vnet.name
#   source_virtual_network_name      = module.vnet.name
#   source_remote_virtual_network_id = module.vnet.id
#   source_allow_gateway_transit     = true # needed by vpn gateway for enabling routing from vnet to vnet_integration

#   target_resource_group_name       = azurerm_resource_group.rg_vnet_aks[each.key].name
#   target_virtual_network_name      = module.vnet_aks[each.key].name
#   target_remote_virtual_network_id = module.vnet_aks[each.key].id
#   target_use_remote_gateways       = true # needed by vpn gateway for enabling routing from vnet to vnet_integration
# }

# module "vnet_integration_peering_2_aks" {
#   source = "git::https://github.com/pagopa/azurerm.git//virtual_network_peering?ref=v2.16.0"

#   for_each = { for n in var.aks_networks : n.domain_name => n }

#   location = var.location

#   source_resource_group_name       = azurerm_resource_group.rg_vnet.name
#   source_virtual_network_name      = module.vnet_integration.name
#   source_remote_virtual_network_id = module.vnet_integration.id
#   source_allow_gateway_transit     = true # needed by vpn gateway for enabling routing from vnet to vnet_integration

#   target_resource_group_name       = azurerm_resource_group.rg_vnet_aks[each.key].name
#   target_virtual_network_name      = module.vnet_aks[each.key].name
#   target_remote_virtual_network_id = module.vnet_aks[each.key].id
#   target_use_remote_gateways       = false # needed by vpn gateway for enabling routing from vnet to vnet_integration
# }

# #
# # DNS private integration
# #
# resource "azurerm_private_dns_zone_virtual_network_link" "integration_internal_env_cstar_pagopa_it_2_aks" {
#   for_each = { for n in var.aks_networks : n.domain_name => n }

#   name                  = "${local.project}-integration-aks-platform-vnet"
#   resource_group_name   = azurerm_resource_group.rg_vnet.name
#   private_dns_zone_name = azurerm_private_dns_zone.private_private_dns_zone.name
#   virtual_network_id    = module.vnet_aks[each.key].id
# }
