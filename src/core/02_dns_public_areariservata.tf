resource "azurerm_dns_zone" "areariservata_public" {
  count               = (var.dns_zone_prefix_ar == null || var.external_domain == null) ? 0 : 1
  name                = join(".", [var.dns_zone_prefix_ar, var.external_domain])
  resource_group_name = azurerm_resource_group.rg_vnet.name

  tags = var.tags
}



# Prod ONLY record to DEV public DNS delegation
resource "azurerm_dns_ns_record" "dev_areariservata" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "dev"
  zone_name           = azurerm_dns_zone.areariservata_public[0].name
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
resource "azurerm_dns_ns_record" "uat_areariservata" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "uat"
  zone_name           = azurerm_dns_zone.areariservata_public[0].name
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


#
# @Records
#

resource "azurerm_dns_caa_record" "caa_areariservata" {
  name                = "@"
  zone_name           = azurerm_dns_zone.areariservata_public[0].name
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

resource "azurerm_dns_mx_record" "dns-mx-email-areariservata-pagopa-it" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "email"
  zone_name           = azurerm_dns_zone.areariservata_public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec

  record {
    preference = 10
    exchange   = "feedback-smtp.eu-south-1.amazonses.com"
  }

  tags = var.tags
}

# spf record
resource "azurerm_dns_txt_record" "dns-txt-email-areariservata-pagopa-it-aws-ses" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "email"
  zone_name           = azurerm_dns_zone.areariservata_public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  record {
    value = "v=spf1 include:amazonses.com -all"
  }
  tags = var.tags
}

resource "azurerm_dns_txt_record" "dns-txt-areariservata-pagopa-it-aws-ses" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "_amazonses"
  zone_name           = azurerm_dns_zone.areariservata_public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  record {
    value = "XEJ0bY7Mn5vSie0iVucD85zkiinx8Ok3kkWaSqQAbBU="
  }
  tags = var.tags
}


locals {
  dkim_aws_ses_areariservata_pagopa_it = [
    {
      "name"  = "jhxmcfdewlxudlkkwf7zqmbcyh7gxfqi._domainkey"
      "value" = "jhxmcfdewlxudlkkwf7zqmbcyh7gxfqi.dkim.eu-south-1.amazonses.com"
    },
    {
      "name"  = "ziwig3w7kxrs22pp57pgva6gwgrrvsxt._domainkey"
      "value" = "ziwig3w7kxrs22pp57pgva6gwgrrvsxt.dkim.eu-south-1.amazonses.com"
    },
    {
      "name"  = "fpkweq37v2mlearalahfhfy4nwuzoiyv._domainkey"
      "value" = "fpkweq37v2mlearalahfhfy4nwuzoiyv.dkim.eu-south-1.amazonses.com"
    }
  ]
}

resource "azurerm_dns_cname_record" "dkim-aws-ses-areariservata-pagopa-it" {
  for_each            = var.env_short == "p" ? { for d in local.dkim_aws_ses_areariservata_pagopa_it : d.name => d } : {}
  name                = each.value.name
  zone_name           = azurerm_dns_zone.areariservata_public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  record              = each.value.value
  tags                = var.tags
}
