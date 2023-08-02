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

# Prod ONLY record to Firma con IO public DNS delegation
resource "azurerm_dns_ns_record" "firmaconio_selfcare" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "firmaconio"
  zone_name           = azurerm_dns_zone.selfcare_public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  records = [
    "ns1-02.azure-dns.com.",
    "ns2-02.azure-dns.net.",
    "ns3-02.azure-dns.org.",
    "ns4-02.azure-dns.info."
  ]
  ttl  = var.dns_default_ttl_sec
  tags = var.tags
}

# INTEROP public DNS delegation
resource "azurerm_dns_ns_record" "interop_selfcare" {
  count               = var.dns_ns_interop_selfcare != null ? 1 : 0
  name                = "interop"
  zone_name           = azurerm_dns_zone.selfcare_public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  records             = var.dns_ns_interop_selfcare
  ttl                 = var.dns_default_ttl_sec
  tags                = var.tags
}

#
# @Records
#

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
    tag   = "issue"
    value = "amazon.com"
  }

  record {
    flags = 0
    tag   = "issue"
    value = "amazontrust.com"
  }

  record {
    flags = 0
    tag   = "issue"
    value = "awstrust.com"
  }

  record {
    flags = 0
    tag   = "issue"
    value = "amazonaws.com"
  }

  record {
    flags = 0
    tag   = "issue"
    value = "digicert.com"
  }

  record {
    flags = 0
    tag   = "iodef"
    value = "mailto:security+caa@pagopa.it"
  }

  tags = var.tags
}

#
# 🅰️ DNS A records
#

# application gateway records
resource "azurerm_dns_a_record" "dns_a_api" {
  name                = "api"
  zone_name           = azurerm_dns_zone.selfcare_public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  records             = [azurerm_public_ip.appgateway_public_ip.ip_address]
  tags                = var.tags
}

resource "azurerm_dns_a_record" "public_api_pnpg" {
  name                = "api-pnpg"
  zone_name           = azurerm_dns_zone.selfcare_public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  records             = [azurerm_public_ip.appgateway_public_ip.ip_address]
  tags                = var.tags
}

# MX record for sub domain email

resource "azurerm_dns_mx_record" "dns-mx-email-selfcare-pagopa-it" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "email"
  zone_name           = azurerm_dns_zone.selfcare_public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec

  record {
    preference = 10
    exchange   = "feedback-smtp.eu-south-1.amazonses.com"
  }

  tags = var.tags
}

# spf record 
resource "azurerm_dns_txt_record" "dns-txt-email-selfcare-pagopa-it-aws-ses" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "email"
  zone_name           = azurerm_dns_zone.selfcare_public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  record {
    value = "v=spf1 include:amazonses.com -all"
  }
  tags = var.tags
}

resource "azurerm_dns_txt_record" "dns-txt-selfcare-pagopa-it-aws-ses" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "_amazonses"
  zone_name           = azurerm_dns_zone.selfcare_public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  record {
    value = "XEJ0bY7Mn5vSie0iVucD85zkiinx8Ok3kkWaSqQAbBU="
  }
  tags = var.tags
}


locals {
  dkim_aws_ses_selfcare_pagopa_it = [
    {
      "name"  = "6h45kkrdd3vjdinlyiiidtxxsphoaubs._domainkey"
      "value" = "6h45kkrdd3vjdinlyiiidtxxsphoaubs.dkim.eu-south-1.amazonses.com"
    },
    {
      "name"  = "xzxgkpr57rtojhujy5pa7allv7mpoxs4._domainkey"
      "value" = "xzxgkpr57rtojhujy5pa7allv7mpoxs4.dkim.eu-south-1.amazonses.com"
    },
    {
      "name"  = "6ozapd6v5bdmceyr2ap246as3mvafyd2._domainkey"
      "value" = "6ozapd6v5bdmceyr2ap246as3mvafyd2.dkim.eu-south-1.amazonses.com"
    }
  ]
}

resource "azurerm_dns_cname_record" "dkim-aws-ses-selfcare-pagopa-it" {
  for_each            = var.env_short == "p" ? { for d in local.dkim_aws_ses_selfcare_pagopa_it : d.name => d } : {}
  name                = each.value.name
  zone_name           = azurerm_dns_zone.selfcare_public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  record              = each.value.value
  tags                = var.tags
}
