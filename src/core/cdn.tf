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
    for i, spa in var.spa :
    {
      name  = replace(format("SPA-%s", spa), "-", "")
      order = i + 3 // +3 required because the order start from 1: 1 is reserved for default application redirect; 2 is reserved for the https rewrite;
      conditions = [
        {
          condition_type   = "url_path_condition"
          operator         = "BeginsWith"
          match_values     = [format("/%s/", spa)]
          negate_condition = false
          transforms       = null
        },
        {
          condition_type   = "url_file_extension_condition"
          operator         = "LessThanOrEqual"
          match_values     = ["0"]
          negate_condition = false
          transforms       = null
        },
      ]
      url_rewrite_action = {
        source_pattern          = format("/%s/", spa)
        destination             = format("/%s/index.html", spa)
        preserve_unmatched_path = false
      }
    }
  ]
  cors = {
    paths   = ["/assets/"]
    allowedOrigins = concat(["https://${var.dns_zone_prefix}.${var.external_domain}"], var.allowedOrigins)
    allowedMethods = ["GET"]
    allowedHeaders = ["*"]
  }
}

/**
 * CDN
 */
// public storage used to serve FE
#tfsec:ignore:azure-storage-default-action-deny
module "checkout_cdn" {
  source = "git::https://github.com/pagopa/azurerm.git//cdn?ref=v2.7.0"

  name                  = "checkout"
  prefix                = local.project
  resource_group_name   = azurerm_resource_group.checkout_fe_rg.name
  location              = var.location
  hostname              = format("%s.%s", var.dns_zone_prefix, var.external_domain)
  https_rewrite_enabled = true
  lock_enabled          = var.lock_enable

  index_document     = "index.html"
  error_404_document = "error.html"

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
        value = format("default-src 'self'; connect-src 'self' https://api.%s.%s/; "
        , var.dns_zone_prefix, var.external_domain)
      },
      {
        action = "Append"
        name   = "Content-Security-Policy-Report-Only"
        value  = "script-src 'self' https://www.google.com https://www.gstatic.com; style-src 'self' 'unsafe-inline' https://fonts.googleapis.com; worker-src 'none'; font-src 'self' https://fonts.googleapis.com https://fonts.gstatic.com; "
      },
      {
        action = "Append"
        name   = "Content-Security-Policy-Report-Only"
        value  = format("img-src 'self' https://assets.cdn.io.italia.it https://%s data:; ", module.checkout_cdn.storage_primary_web_host)
      }
    ]
  }

  delivery_rule_rewrite = concat([{
    name  = "defaultApplication"
    order = 2
    conditions = [
      {
        condition_type   = "url_path_condition"
        operator         = "Equal"
        match_values     = ["/"]
        negate_condition = false
        transforms       = null
      }
    ]
    url_rewrite_action = {
      source_pattern          = "/"
      destination             = "/dashboard/index.html"
      preserve_unmatched_path = false
    }
    }],
    local.spa
  )

  delivery_rule = [{
    name  = "robotsNoIndex"
    order = 3 + length(local.spa)

    // conditions
    url_path_conditions = [{
      operator         = "Equal"
      match_values     = length(var.robots_indexed_paths) > 0 ? var.robots_indexed_paths : ["dummy"]
      negate_condition = true
      transforms       = null
    }]
    cookies_conditions            = []
    device_conditions             = []
    http_version_conditions       = []
    post_arg_conditions           = []
    query_string_conditions       = []
    remote_address_conditions     = []
    request_body_conditions       = []
    request_header_conditions     = []
    request_method_conditions     = []
    request_scheme_conditions     = []
    request_uri_conditions        = []
    url_file_extension_conditions = []
    url_file_name_conditions      = []

    // actions
    modify_response_header_actions = [{
      action = "Overwrite"
      name   = "X-Robots-Tag"
      value  = "noindex, nofollow"
    }]
    cache_expiration_actions       = []
    cache_key_query_string_actions = []
    modify_request_header_actions  = []
    url_redirect_actions           = []
    url_rewrite_actions            = []
  },{
    name  = "cors"
    order = 4 + length(local.spa)

    // conditions
    url_path_conditions = [{
      operator         = "BeginsWith"
      match_values     = local.cors.paths
      negate_condition = false
      transforms       = null
    }]
    cookies_conditions            = []
    device_conditions             = []
    http_version_conditions       = []
    post_arg_conditions           = []
    query_string_conditions       = []
    remote_address_conditions     = []
    request_body_conditions       = []
    request_header_conditions     = []
    request_method_conditions     = []
    request_scheme_conditions     = []
    request_uri_conditions        = []
    url_file_extension_conditions = []
    url_file_name_conditions      = []

    // actions
    modify_response_header_actions = [{
      action = "Overwrite"
      name   = "Access-Control-Allow-Credentials"
      value  = "true"
    },{
      action = "Overwrite"
      name   = "Access-Control-Allow-Headers"
      value  = join(",", local.cors.allowedHeaders)
    },{
      action = "Overwrite"
      name   = "Access-Control-Allow-Methods"
      value  = join(",", local.cors.allowedMethods)
    },{
      action = "Overwrite"
      name   = "Access-Control-Allow-Origin"
      value  = join(",", local.cors.allowedOrigins)
    }]
    cache_expiration_actions       = []
    cache_key_query_string_actions = []
    modify_request_header_actions  = []
    url_redirect_actions           = []
    url_rewrite_actions            = []
  }]

  tags = var.tags
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry
resource "azurerm_key_vault_secret" "selc_web_storage_access_key" {
  name         = "web-storage-access-key"
  value        = module.checkout_cdn.storage_primary_access_key
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry
resource "azurerm_key_vault_secret" "selc_web_storage_connection_string" {
  name         = "web-storage-connection-string"
  value        = module.checkout_cdn.storage_primary_connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry
resource "azurerm_key_vault_secret" "selc_web_storage_blob_connection_string" {
  name         = "web-storage-blob-connection-string"
  value        = module.checkout_cdn.storage_primary_blob_connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}
