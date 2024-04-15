resource "azurerm_network_security_group" "selc_pnpg_subnet_nsg" {
  name                = "${var.project}-pnpg-container-app-nsg"
  location            = data.azurerm_virtual_network.vnet_selc.location
  resource_group_name = data.azurerm_virtual_network.vnet_selc.resource_group_name
}

resource "azurerm_network_security_rule" "selc_pnpg_cae_subnet_outbound_rule" {
  name                        = "BlockAnyCidrCaeSubnetOutBound"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = var.cidr_subnet_selc_cae
  resource_group_name         = data.azurerm_virtual_network.vnet_selc.resource_group_name
  network_security_group_name = azurerm_network_security_group.selc_pnpg_subnet_nsg.name
}

resource "azurerm_network_security_rule" "selc_pnpg_cae_subnet_inbound_rule" {
  name                        = "BlockCidrCaeSubnetAnyInBound"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = var.cidr_subnet_selc_cae
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_virtual_network.vnet_selc.resource_group_name
  network_security_group_name = azurerm_network_security_group.selc_pnpg_subnet_nsg.name
}

resource "azurerm_subnet_network_security_group_association" "selc_pnpg_nsg_cae_subnet_association" {
  subnet_id                 = azurerm_subnet.pnpg_container_app_snet.id
  network_security_group_id = azurerm_network_security_group.selc_pnpg_subnet_nsg.id
}
