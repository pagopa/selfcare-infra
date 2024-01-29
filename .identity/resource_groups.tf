resource "azurerm_resource_group" "identity_rg" {
  name     = "${local.project}-identity-rg"
  location = var.location
}
