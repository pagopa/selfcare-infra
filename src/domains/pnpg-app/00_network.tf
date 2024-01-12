data "azurerm_dns_zone" "public" {
  name                = var.env_short == "p" ? "${var.dns_zone_prefix}.${var.external_domain}" : "${var.env}.${var.dns_zone_prefix}.${var.external_domain}"
  resource_group_name = local.vnet_core_resource_group_name
}

data "azurerm_dns_zone" "areariservata_public" {
  name                = var.env_short == "p" ? "${var.dns_zone_prefix_ar}.${var.external_domain}" : "${var.env}.${var.dns_zone_prefix_ar}.${var.external_domain}"
  resource_group_name = local.vnet_core_resource_group_name
}
