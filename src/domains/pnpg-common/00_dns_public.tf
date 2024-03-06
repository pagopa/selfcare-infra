data "azurerm_dns_zone" "selfcare_public" {
  name                = "${var.dns_zone_prefix}.${var.external_domain}"
  resource_group_name = "selc-${var.env_short}-vnet-rg"
}

