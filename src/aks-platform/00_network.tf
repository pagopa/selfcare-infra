#
# Core
#

data "azurerm_resource_group" "vnet_core_rg" {
  name = local.vnet_core_resource_group_name
}

data "azurerm_virtual_network" "vnet_core" {
  name                = local.vnet_core_name
  resource_group_name = data.azurerm_resource_group.vnet_core_rg.name
}

#
# AKS Vnet
#

data "azurerm_resource_group" "vnet_aks_rg" {
  name = local.vnet_aks_resource_group_name
}

data "azurerm_virtual_network" "vnet_aks" {
  name                = local.vnet_aks_name
  resource_group_name = data.azurerm_resource_group.vnet_aks_rg.name
}

data "azurerm_kubernetes_cluster" "aks" {
  name                = local.aks_cluster_name
  resource_group_name = azurerm_resource_group.rg_aks.name
}

data "azurerm_private_dns_zone" "dns_zone_aks" {
  name                = "48b439b4-33dd-4d11-859a-d3db44f754b9.privatelink.westeurope.azmk8s.io"
  resource_group_name = data.azurerm_private_dns_zone.dns_zone_aks.name
}

#
# Public ip
#
data "azurerm_public_ip" "pip_aks_outboud" {
  name                = var.public_ip_aksoutbound_name
  resource_group_name = data.azurerm_resource_group.vnet_aks_rg.name
}

#
# Vnet pair
#
data "azurerm_resource_group" "vnet_pair_rg" {
  name = local.vnet_pair_resource_group_name
}

data "azurerm_virtual_network" "vnet_pair" {
  name                = local.vnet_pair_name
  resource_group_name = data.azurerm_resource_group.vnet_pair_rg.name
}