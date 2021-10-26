/**
 * Checkout resource group
 **/
resource "azurerm_resource_group" "checkout_fe_rg" {
  name     = format("%s-checkout-fe-rg", local.project)
  location = var.location

  tags = var.tags
}

locals {
  spa = [
    for i, spa in var.spa:
      {
        name                      = replace(format("SPA-%s", spa), "-", "")
        order                     = i+2 // +2 required because the order start from 1 and 1 is reserved for the https rewrite
        condition_type            = "url_file_extension_condition"
        operator                  = "LessThanOrEqual"
        match_values              = ["0"]
        url_rewrite_action        = {
          source_pattern          = format("/%s/", spa)
          destination             = format("/%s/index.html", spa)
          preserve_unmatched_path = false
        }
      }
  ]
}

/**
 * CDN
 */
// public storage used to serve FE
#tfsec:ignore:azure-storage-default-action-deny
module "checkout_cdn" {
  source                = "git::https://github.com/pagopa/azurerm.git//cdn?ref=v1.0.79"
  name                  = "checkout"
  prefix                = local.project
  resource_group_name   = azurerm_resource_group.checkout_fe_rg.name
  location              = var.location
  hostname              = format("%s.%s", var.dns_zone_prefix, var.external_domain)
  https_rewrite_enabled = true
  lock_enabled          = var.lock_enable

  index_document     = "index.html"
  error_404_document = "not_found.html"

  dns_zone_name                = azurerm_dns_zone.selfcare_public[0].name
  dns_zone_resource_group_name = azurerm_dns_zone.selfcare_public[0].resource_group_name

  keyvault_resource_group_name = module.key_vault.resource_group_name
  keyvault_subscription_id     = data.azurerm_subscription.current.subscription_id
  keyvault_vault_name          = module.key_vault.name

  querystring_caching_behaviour = "BypassCaching"

  global_delivery_rule = {
    cache_expiration_action       = []
    cache_key_query_string_action = []
    modify_request_header_action  = []

    # HSTS
    modify_response_header_action = [{
      action = "Overwrite"
      name   = "Strict-Transport-Security"
      value  = "max-age=31536000"
      },
      # Content-Security-Policy (in Report mode)
      {
        action = "Overwrite"
        name   = "Content-Security-Policy-Report-Only"
        value  = format("default-src 'self'; connect-src 'self' https://api.%s.%s/spid/v1/metadata; "
        , var.dns_zone_prefix, var.external_domain)
      },
      {
        action = "Append"
        name = "Content-Security-Policy-Report-Only"
        value = "script-src 'self' https://www.google.com https://www.gstatic.com; style-src 'self' 'unsafe-inline' https://fonts.googleapis.com; worker-src 'none'; font-src 'self' https://fonts.googleapis.com https://fonts.gstatic.com; "
      },
      {
        action = "Append"
        name   = "Content-Security-Policy-Report-Only"
        value  = "img-src 'self' https://assets.cdn.io.italia.it data:; "
      }
    ]
  }

  delivery_rule_rewrite = local.spa

  tags = var.tags
}
