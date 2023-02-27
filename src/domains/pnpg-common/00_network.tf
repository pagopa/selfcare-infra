data "azurerm_virtual_network" "vnet_core" {
  name                = local.vnet_core_name
  resource_group_name = local.vnet_core_resource_group_name
}

data "azurerm_private_dns_zone" "privatelink_mongo_cosmos_azure_com" {
  name                = "privatelink.mongo.cosmos.azure.com"
  resource_group_name = local.vnet_core_resource_group_name
}

#
# Private Endpoints
#
data "azurerm_subnet" "private_endpoint_subnet" {
  name                 = local.private_endpoint_subnet_name
  virtual_network_name = local.vnet_core_name
  resource_group_name  = local.vnet_core_resource_group_name
}

#
# DNS
#
data "azurerm_private_dns_zone" "privatelink_blob_core_windows_net" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = local.vnet_core_resource_group_name
}
