resource "azurerm_resource_group" "rg_vnet" {
  name     = format("%s-vnet-rg", local.project)
  location = var.location

  tags = var.tags
}

# vnet
module "vnet" {
  source               = "git::https://github.com/pagopa/terraform-azurerm-v3.git//virtual_network?ref=v7.3.0"
  name                 = format("%s-vnet", local.project)
  location             = azurerm_resource_group.rg_vnet.location
  resource_group_name  = azurerm_resource_group.rg_vnet.name
  address_space        = var.cidr_vnet
  ddos_protection_plan = var.ddos_protection_plan
  tags                 = var.tags
}

module "private_endpoints_subnet" {
  source                                    = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v7.3.0"
  name                                      = "${local.project}-private-endpoints-snet"
  address_prefixes                          = var.cidr_subnet_private_endpoints
  resource_group_name                       = azurerm_resource_group.rg_vnet.name
  virtual_network_name                      = module.vnet.name
  private_endpoint_network_policies_enabled = true

  service_endpoints = [
    "Microsoft.Storage",
  ]
}
