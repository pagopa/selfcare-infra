resource "azurerm_dns_zone" "selfcare_public" {
  count               = (var.dns_zone_prefix == null || var.external_domain == null) ? 0 : 1
  name                = join(".", [var.dns_zone_prefix, var.external_domain])
  resource_group_name = azurerm_resource_group.rg_vnet.name

  tags = var.tags
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
