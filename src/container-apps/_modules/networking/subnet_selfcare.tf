resource "azurerm_subnet" "selc_container_app_snet" {
  name                 = var.selc_container_app_name_snet
  resource_group_name  = data.azurerm_virtual_network.vnet_selc.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet_selc.name

  address_prefixes = [var.cidr_subnet_selc_cae]

  dynamic "delegation" {
    for_each = var.selc_delegation
    content {
      name = delegation.value.name
      service_delegation {
        name    = delegation.value.service_delegation_name
        actions = delegation.value.service_delegation_actions
      }
    }
  }
}

resource "azurerm_subnet_nat_gateway_association" "selc_subnet_gateway_association" {
  nat_gateway_id = data.azurerm_nat_gateway.nat_gateway.id
  subnet_id      = azurerm_subnet.selc_container_app_snet.id
}

resource "azurerm_nat_gateway_public_ip_association" "selc_subnet_pip_nat_gateway" {
  nat_gateway_id       = data.azurerm_nat_gateway.nat_gateway.id
  public_ip_address_id = data.azurerm_public_ip.pip_outbound.id
}
