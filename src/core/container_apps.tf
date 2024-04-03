resource "azurerm_resource_group" "selc_container_app_rg" {
  name     = "${local.project}-container-app-rg"
  location = var.location

  tags = var.tags
}

resource "azurerm_subnet" "selc_container_app_snet" {
  name                 = "${local.project}-container-app-snet"
  resource_group_name  = azurerm_resource_group.rg_vnet.name
  virtual_network_name = module.vnet.name
  address_prefixes     = var.cidr_subnet_selc
}

resource "azurerm_subnet" "selc_pnpg_container_app_snet" {
  name                 = "${local.project}-pnpg-container-app-snet"
  resource_group_name  = azurerm_resource_group.rg_vnet.name
  virtual_network_name = module.vnet.name
  address_prefixes     = var.cidr_subnet_selc_pnpg
}

resource "azurerm_network_security_group" "selc_pnpg_subnet_nsg" {
  name                = "${local.project}-pnpg-container-app-nsg"
  location            = azurerm_resource_group.rg_vnet.location
  resource_group_name = azurerm_resource_group.rg_vnet.name
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
  destination_address_prefix  = var.cidr_subnet_selc[0]
  resource_group_name         = azurerm_resource_group.rg_vnet.name
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
  source_address_prefix       = var.cidr_subnet_selc[0]
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg_vnet.name
  network_security_group_name = azurerm_network_security_group.selc_pnpg_subnet_nsg.name
}

resource "azurerm_subnet_network_security_group_association" "selc_pnpg_nsg_cae_subnet_association" {
  subnet_id                 = azurerm_subnet.selc_pnpg_container_app_snet.id
  network_security_group_id = azurerm_network_security_group.selc_pnpg_subnet_nsg.id
}

module "selc_cae" {
  source = "github.com/pagopa/terraform-azurerm-v3.git//container_app_environment_v2?ref=v7.50.1"

  resource_group_name = azurerm_resource_group.selc_container_app_rg.name
  location            = azurerm_resource_group.selc_container_app_rg.location
  name                = "${local.project}-cae"

  subnet_id              = azurerm_subnet.selc_container_app_snet.id
  internal_load_balancer = true
  zone_redundant         = var.cae_zone_redundant

  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id

  tags = var.tags
}


# resource "azurerm_subnet_nat_gateway_association" "selc_cae_subnet_nat_gateway" {
#   subnet_id      = azurerm_subnet.selc_container_app_snet.id
#   nat_gateway_id = azurerm_nat_gateway.nat_gateway.id
# }

module "selc_pnpg_cae" {
  source = "github.com/pagopa/terraform-azurerm-v3.git//container_app_environment_v2?ref=v7.50.1"

  resource_group_name = azurerm_resource_group.selc_container_app_rg.name
  location            = azurerm_resource_group.selc_container_app_rg.location
  name                = "${local.project}-pnpg-cae"

  subnet_id              = azurerm_subnet.selc_pnpg_container_app_snet.id
  internal_load_balancer = true
  zone_redundant         = var.cae_zone_redundant_pnpg

  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id

  tags = var.tags
}

resource "azurerm_management_lock" "lock_selc_cae" {
  lock_level = "CanNotDelete"
  name       = "${local.project}-cae"
  notes      = "This Container App Environment cannot be deleted"
  scope      = module.selc_cae.id
}

resource "azurerm_management_lock" "lock_selc_pnpg_cae" {
  lock_level = "CanNotDelete"
  name       = "${local.project}-pnpg-cae"
  notes      = "This Container App Environment cannot be deleted"
  scope      = module.selc_pnpg_cae.id
}
