resource "azurerm_resource_group" "onboarding_fn_rg" {
  name     = "${local.app_name_fn}-rg"
  location = var.location
  tags     = var.tags
}

resource "azurerm_public_ip" "functions_pip_outboud" {
  name                = "${local.app_name_fn}-pip-outbound"
  resource_group_name = azurerm_resource_group.onboarding_fn_rg.name
  location            = azurerm_resource_group.onboarding_fn_rg.location
  sku                 = "Standard"
  sku_tier            = "Regional"
  allocation_method   = "Static"
}

resource "azurerm_nat_gateway" "functions_nat_gateway" {
  name                    = "${local.app_name_fn}-nat_gw"
  resource_group_name     = azurerm_resource_group.onboarding_fn_rg.name
  location                = azurerm_resource_group.onboarding_fn_rg.location
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
}

# resource "azurerm_nat_gateway_public_ip_association" "functions_pip_nat_gateway" {
#   nat_gateway_id       = azurerm_nat_gateway.functions_nat_gateway.id
#   public_ip_address_id = azurerm_public_ip.functions_pip_outboud.id
# }

# resource "azurerm_subnet_nat_gateway_association" "functions_subnet_nat_gateway" {
#   subnet_id      = module.onboarding_fn_snet[0].id
#   nat_gateway_id = azurerm_nat_gateway.functions_nat_gateway.id
# }