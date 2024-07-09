resource "azurerm_resource_group" "nat_rg" {
  name     = "${local.project}-nat-rg"
  location = var.location
  tags     = var.tags
}

resource "azurerm_public_ip" "pip_outbound" {
  name                = "${local.project}-pip-outbound"
  resource_group_name = azurerm_resource_group.nat_rg.name
  location            = azurerm_resource_group.nat_rg.location
  sku                 = "Standard"
  sku_tier            = "Regional"
  allocation_method   = "Static"

  zones = [
    "1",
    "2",
    "3",
  ]

  tags = var.tags
}

resource "azurerm_public_ip" "functions_pip_outbound" {
  name                = "${local.app_name_fn}-pip-outbound"
  resource_group_name = azurerm_resource_group.nat_rg.name
  location            = azurerm_resource_group.nat_rg.location
  sku                 = "Standard"
  sku_tier            = "Regional"
  allocation_method   = "Static"

  tags = var.tags
}

resource "azurerm_nat_gateway" "nat_gateway" {
  name                    = "${local.project}-nat_gw"
  resource_group_name     = azurerm_resource_group.nat_rg.name
  location                = azurerm_resource_group.nat_rg.location
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
}

resource "azurerm_nat_gateway_public_ip_association" "pip_nat_gateway" {
  nat_gateway_id       = azurerm_nat_gateway.nat_gateway.id
  public_ip_address_id = azurerm_public_ip.aks_outbound_temp[0].id
}