resource "azurerm_resource_group" "rg_vnet" {
  name     = format("%s-vnet-rg", local.project)
  location = var.location

  tags = var.tags
}

# vnet
module "vnet" {
  source               = "git::https://github.com/pagopa/azurerm.git//virtual_network?ref=v4.3.2"
  name                 = format("%s-vnet", local.project)
  location             = azurerm_resource_group.rg_vnet.location
  resource_group_name  = azurerm_resource_group.rg_vnet.name
  address_space        = var.cidr_vnet
  ddos_protection_plan = var.ddos_protection_plan
  tags                 = var.tags
}

module "private_endpoints_subnet" {
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v4.8.0"
  name                                           = "${local.project}-private-endpoints-snet"
  address_prefixes                               = var.cidr_subnet_private_endpoints
  resource_group_name                            = azurerm_resource_group.rg_vnet.name
  virtual_network_name                           = module.vnet.name
  enforce_private_link_endpoint_network_policies = true

  service_endpoints = [
    "Microsoft.Storage",
  ]
}
