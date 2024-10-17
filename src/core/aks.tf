resource "azurerm_resource_group" "rg_aks" {
  name     = "${local.project}-aks-rg"
  location = var.location
  tags     = var.tags
}

resource "azurerm_public_ip" "aks_outbound" {
  count = var.aks_num_outbound_ips

  name                = format("%s-aksoutbound-pip-%02d", local.project, count.index + 1)
  resource_group_name = azurerm_resource_group.rg_vnet.name
  location            = azurerm_resource_group.rg_vnet.location
  sku                 = "Standard"
  allocation_method   = "Static"

  zones = [
    "1",
    "2",
    "3",
  ]

  tags = var.tags
}

resource "azurerm_public_ip" "aks_outbound_temp" {
  count = var.aks_num_outbound_ips

  name                = format("%s-aksoutbound-pip-temp-%02d", local.project, count.index + 1)
  resource_group_name = azurerm_resource_group.rg_vnet.name
  location            = azurerm_resource_group.rg_vnet.location
  sku                 = "Standard"
  allocation_method   = "Static"

  zones = [
    "1",
    "2",
    "3",
  ]

  tags = var.tags
}

