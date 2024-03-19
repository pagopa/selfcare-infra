resource "azurerm_resource_group" "nat_rg" {
  name     = "${local.project}-nat-rg"
  location = var.location
  tags     = var.tags
}

resource "azurerm_public_ip" "functions_pip_outboud" {
  name                = "${local.app_name_fn}-pip-outbound"
  resource_group_name = azurerm_resource_group.nat_rg.name
  location            = azurerm_resource_group.nat_rg.location
  sku                 = "Standard"
  sku_tier            = "Regional"
  allocation_method   = "Static"
}

resource "azurerm_nat_gateway" "nat_gateway" {
  name                    = "${local.project}-nat_gw"
  resource_group_name     = azurerm_resource_group.nat_rg.name
  location                = azurerm_resource_group.nat_rg.location
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
}
