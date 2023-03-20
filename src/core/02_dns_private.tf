#
# internal.selfcare.pagopa.it
#
resource "azurerm_private_dns_zone" "internal_private_dns_zone" {
  name                = local.internal_selfcare_private_domain
  resource_group_name = azurerm_resource_group.rg_vnet.name
}

#
# DNS private Link
#
resource "azurerm_private_dns_zone_virtual_network_link" "internal_env_selfcare_pagopa_it_2_vnet_core" {

  name                  = "${local.project}-link-vnet-core"
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.internal_private_dns_zone.name
  virtual_network_id    = module.vnet.id
}

#
# COSMOS
#
resource "azurerm_private_dns_zone" "privatelink_documents_azure_com" {
  name                = "privatelink.documents.azure.com"
  resource_group_name = azurerm_resource_group.rg_vnet.name

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_documents_azure_com_vnet" {
  name                  = module.vnet.name
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_documents_azure_com.name
  virtual_network_id    = module.vnet.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone" "privatelink_mongo_cosmos_azure_com" {
  name                = "privatelink.mongo.cosmos.azure.com"
  resource_group_name = azurerm_resource_group.rg_vnet.name

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_mongo_cosmos_azure_com_vnet" {
  name                  = module.vnet.name
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_mongo_cosmos_azure_com.name
  virtual_network_id    = module.vnet.id
  registration_enabled  = false

  tags = var.tags
}

# STORAGE ACCOUNT/CONTRACTS STORAGE
resource "azurerm_private_dns_zone" "privatelink_blob_core_windows_net" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.rg_vnet.name

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_blob_core_windows_net_vnet" {
  name                  = module.vnet.name
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_blob_core_windows_net.name
  virtual_network_id    = module.vnet.id
  registration_enabled  = false

  tags = var.tags
}

# REDIS
resource "azurerm_private_dns_zone" "privatelink_redis_cache_windows_net" {
  count               = var.redis_private_endpoint_enabled ? 1 : 0
  name                = "privatelink.redis.cache.windows.net"
  resource_group_name = azurerm_resource_group.rg_vnet.name

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_redis_cache_windows_net_vnet" {
  count                 = var.redis_private_endpoint_enabled ? 1 : 0
  name                  = module.vnet.name
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_redis_cache_windows_net[0].name
  virtual_network_id    = module.vnet.id
  registration_enabled  = false

  tags = var.tags
}

# SERVICE BUS
resource "azurerm_private_dns_zone" "privatelink_servicebus_windows_net" {
  name                = "privatelink.servicebus.windows.net"
  resource_group_name = azurerm_resource_group.rg_vnet.name

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_servicebus_windows_net_vnet" {
  name                  = module.vnet.name
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_servicebus_windows_net.name
  virtual_network_id    = module.vnet.id
  registration_enabled  = false

  tags = var.tags
}

# LOAD TESTS DB
resource "azurerm_private_dns_zone" "privatelink_loadtestsdb_net" {
  name                = "privatelink.loadtestsdb.com"
  resource_group_name = azurerm_resource_group.rg_vnet.name

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_loadtestsdb_net_vnet" {
  name                  = module.vnet.name
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_loadtestsdb_net.name
  virtual_network_id    = module.vnet.id
  registration_enabled  = false

  tags = var.tags
}
