resource "azurerm_subnet" "pnpg_container_app_snet" {
  name                 = "${var.pnpg_container_app_name_snet}"
  resource_group_name  = data.azurerm_virtual_network.vnet_selc.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet_selc.name

  address_prefixes = [var.cidr_subnet_pnpg_cae]

  delegation {
    name = "Microsoft.App/environments"
    service_delegation {
      name    = "Microsoft.App/environments"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}

resource "azurerm_subnet_nat_gateway_association" "pnpg_subnet_gateway_association" {
  count          = 0
  nat_gateway_id = data.azurerm_nat_gateway.nat_gateway.id
  subnet_id      = azurerm_subnet.pnpg_container_app_snet.id
}
