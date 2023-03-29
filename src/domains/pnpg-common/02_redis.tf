## Database subnet
module "redis_snet" {
  source                                         = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v5.3.0"
  name                                           = format("%s-redis-snet", local.project)
  address_prefixes                               = var.cidr_subnet_redis
  resource_group_name                            = local.vnet_core_resource_group_name
  virtual_network_name                           = local.vnet_core_name
  # enforce_private_link_endpoint_network_policies = true
}

module "redis" {
  source                        = "git::https://github.com/pagopa/terraform-azurerm-v3.git//redis_cache?ref=v5.3.0"

  name                          = format("%s-redis", local.project)
  resource_group_name           = local.vnet_core_resource_group_name
  location                      = var.location
  capacity                      = var.redis_capacity
  family                        = var.redis_family
  sku_name                      = var.redis_sku_name
  public_network_access_enabled = !var.redis_private_endpoint_enabled

  private_endpoint = {
    enabled              = var.redis_private_endpoint_enabled
    virtual_network_id   = data.azurerm_virtual_network.vnet_core.id
    subnet_id            = module.redis_snet.id
    private_dns_zone_ids = var.redis_private_endpoint_enabled ? [data.azurerm_private_dns_zone.privatelink_redis_cache_windows_net_vnet[0].id] : []
  }

  // when azure can apply patch?
  patch_schedules = [
    {
      day_of_week    = "Sunday"
      start_hour_utc = 23
    },
    {
      day_of_week    = "Monday"
      start_hour_utc = 23
    },
    {
      day_of_week    = "Tuesday"
      start_hour_utc = 23
    },
    {
      day_of_week    = "Wednesday"
      start_hour_utc = 23
    },
    {
      day_of_week    = "Thursday"
      start_hour_utc = 23
    },
  ]

  tags = var.tags
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "redis_primary_access_key" {
  name         = "redis-primary-access-key"
  value        = module.redis.primary_access_key
  content_type = "text/plain"

  key_vault_id = module.key_vault_pnpg.id
}
