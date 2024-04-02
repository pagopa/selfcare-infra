resource "azurerm_resource_group" "selc_container_app_rg" {
  name     = "${local.project}-container-app-rg"
  location = var.location

  tags = var.tags
}
