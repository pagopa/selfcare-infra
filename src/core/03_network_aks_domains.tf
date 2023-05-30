resource "azurerm_resource_group" "rg_vnet_aks" {

  name     = "${local.project}-${var.location_short}-vnet-rg"
  location = var.location

  tags = var.tags
}

# vnet
module "vnet_aks_platform" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//virtual_network?ref=v6.14.0"

  name                = "${local.project}-${var.location_short}-aks-${var.aks_platform_env}-vnet"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_vnet_aks.name
  address_space       = var.cidr_aks_platform_vnet

  tags = var.tags
}

#
#  AKS public IP
#

resource "azurerm_public_ip" "outbound_ip_aks_platform" {

  name                = "${local.project}-${var.location_short}-aks-platform-outbound-pip"
  domain_name_label   = "${local.project}-${var.location_short}-aks-platform-outbound-pip"
  location            = azurerm_resource_group.rg_vnet_aks.location
  resource_group_name = azurerm_resource_group.rg_vnet_aks.name
  sku                 = "Standard"
  allocation_method   = "Static"

  tags = var.tags
}

#
# PEERINGS
#

module "vnet_peering_core_2_aks" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//virtual_network_peering?ref=v6.14.0"

  location = var.location

  source_resource_group_name       = azurerm_resource_group.rg_vnet.name
  source_virtual_network_name      = module.vnet.name
  source_remote_virtual_network_id = module.vnet.id
  source_allow_gateway_transit     = true # needed by vpn gateway for enabling routing from vnet to vnet_integration

  target_resource_group_name       = azurerm_resource_group.rg_vnet_aks.name
  target_virtual_network_name      = module.vnet_aks_platform.name
  target_remote_virtual_network_id = module.vnet_aks_platform.id
  target_use_remote_gateways       = true # needed by vpn gateway for enabling routing from vnet to vnet_integration
}


#
# DNS private integration
#

# INTERNAL
resource "azurerm_private_dns_zone_virtual_network_link" "internal_env_selfcare_pagopa_it_2_aks_vnet" {
  name                  = "${local.project}-integration-aks-platform-vnet"
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.internal_private_dns_zone.name
  virtual_network_id    = module.vnet_aks_platform.id
}

# STORAGE
resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_documents_azure_com_vnet_vs_aks_vnet" {
  name                  = "${local.project}-aks-platform-vnet"
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_documents_azure_com.name
  virtual_network_id    = module.vnet_aks_platform.id
  registration_enabled  = false

  tags = var.tags
}

# COSMOS-MONGO
resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_mongo_cosmos_azure_com_vnet_vs_aks_vnet" {
  name                  = "${local.project}-aks-platform-vnet"
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_mongo_cosmos_azure_com.name
  virtual_network_id    = module.vnet_aks_platform.id
  registration_enabled  = false

  tags = var.tags
}

# BLOB
resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_blob_core_windows_net_vnet_vs_aks_vnet" {
  name                  = "${local.project}-aks-platform-vnet"
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_blob_core_windows_net.name
  virtual_network_id    = module.vnet_aks_platform.id
  registration_enabled  = false

  tags = var.tags
}

# REDIS
resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_redis_cache_windows_net_vnet_vs_aks_vnet" {
  count                 = var.redis_private_endpoint_enabled ? 1 : 0
  name                  = "${local.project}-aks-platform-vnet"
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_redis_cache_windows_net[0].name
  virtual_network_id    = module.vnet_aks_platform.id
  registration_enabled  = false

  tags = var.tags
}

# SERVICE BUS
resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_servicebus_windows_net_vnet_vs_aks_vnet" {
  name                  = "${local.project}-aks-platform-vnet"
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_servicebus_windows_net.name
  virtual_network_id    = module.vnet_aks_platform.id
  registration_enabled  = false

  tags = var.tags
}

