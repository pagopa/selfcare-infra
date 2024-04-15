data "azurerm_virtual_network" "vnet_selc" {
  name                = "${var.project}-vnet"
  resource_group_name = local.resource_group_name_vnet
}

data "azurerm_nat_gateway" "nat_gateway" {
  name                = "${var.project}-nat_gw"
  resource_group_name = local.resource_group_name_natgw
}
