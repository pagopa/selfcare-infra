data "azurerm_virtual_network" "vnet_selc" {
  name                = "${var.project}-vnet"
  resource_group_name = local.resource_group_name_vnet
}

data "azurerm_nat_gateway" "nat_gateway" {
  name                = "${var.project}-nat_gw"
  resource_group_name = local.resource_group_name_natgw
}

data "azurerm_public_ip" "pip_outbound" {
  name                = "${var.project}-aksoutbound-pip-01"
  resource_group_name = local.resource_group_name_vnet
}
