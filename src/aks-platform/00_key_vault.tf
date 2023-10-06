data "azurerm_key_vault" "kv_domain" {
  name                = "${local.product}-${local.namespace}-kv"
  resource_group_name = "${local.product}-${local.namespace}-sec-rg"
}
# data "azurerm_key_vault" "kv_core" {
#   name                = "${local.product}-kv"
#   resource_group_name = "${local.product}-sec-rg"
# }
