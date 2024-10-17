data "azurerm_api_management" "api_management_core" {
  resource_group_name = "${local.product}-api-v2-rg"
  name                = "${local.product}-apim-v2"
}
