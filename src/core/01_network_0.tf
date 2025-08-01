resource "azurerm_resource_group" "rg_vnet" {
  name     = format("%s-vnet-rg", local.project)
  location = var.location

  tags = var.tags
}

# vnet
module "vnet" {
  source               = "github.com/pagopa/terraform-azurerm-v4.git//virtual_network?ref=v6.6.0"
  name                 = format("%s-vnet", local.project)
  location             = azurerm_resource_group.rg_vnet.location
  resource_group_name  = azurerm_resource_group.rg_vnet.name
  address_space        = var.cidr_vnet
  ddos_protection_plan = var.ddos_protection_plan
  tags                 = var.tags
}

module "private_endpoints_subnet" {
  source                            = "github.com/pagopa/terraform-azurerm-v4.git//subnet?ref=v6.6.0"
  name                              = "${local.project}-private-endpoints-snet"
  address_prefixes                  = var.cidr_subnet_private_endpoints
  resource_group_name               = azurerm_resource_group.rg_vnet.name
  virtual_network_name              = module.vnet.name
  private_endpoint_network_policies = var.private_endpoint_network_policies

  service_endpoints = [
    "Microsoft.Storage",
  ]
}
