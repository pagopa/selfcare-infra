resource "azurerm_dns_zone" "selfcare_public" {
  count               = (var.dns_zone_prefix == null || var.external_domain == null) ? 0 : 1
  name                = join(".", [var.dns_zone_prefix, var.external_domain])
  resource_group_name = azurerm_resource_group.rg_vnet.name

  tags = var.tags
}

# Prod ONLY record to DEV public DNS delegation
resource "azurerm_dns_ns_record" "dev_selfcare" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "dev"
  zone_name           = azurerm_dns_zone.selfcare_public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  records = [
    "ns1-06.azure-dns.com.",
    "ns2-06.azure-dns.net.",
    "ns3-06.azure-dns.org.",
    "ns4-06.azure-dns.info.",
  ]
  ttl  = var.dns_default_ttl_sec
  tags = var.tags
}

# Prod ONLY record to UAT public DNS delegation
resource "azurerm_dns_ns_record" "uat_selfcare" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "uat"
  zone_name           = azurerm_dns_zone.selfcare_public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  records = [
    "ns1-07.azure-dns.com.",
    "ns2-07.azure-dns.net.",
    "ns3-07.azure-dns.org.",
    "ns4-07.azure-dns.info.",
  ]
  ttl  = var.dns_default_ttl_sec
  tags = var.tags
}

# Prod ONLY record to IO public DNS delegation
resource "azurerm_dns_ns_record" "io_selfcare" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "io"
  zone_name           = azurerm_dns_zone.selfcare_public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  records = [
    "ns1-03.azure-dns.com.",
    "ns2-03.azure-dns.net.",
    "ns3-03.azure-dns.org.",
    "ns4-03.azure-dns.info.",
  ]
  ttl  = var.dns_default_ttl_sec
  tags = var.tags
}

resource "azurerm_dns_caa_record" "caa_selfcare" {
  name                = "@"
  zone_name           = azurerm_dns_zone.selfcare_public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec

  record {
    flags = 0
    tag   = "issue"
    value = "letsencrypt.org"
  }

  record {
    flags = 0
    tag   = "iodef"
    value = "mailto:security+caa@pagopa.it"
  }

  tags = var.tags
}

# application gateway records
resource "azurerm_dns_a_record" "dns_a_api" {
  name                = "api"
  zone_name           = azurerm_dns_zone.selfcare_public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  records             = [azurerm_public_ip.appgateway_public_ip.ip_address]
  tags                = var.tags
}
