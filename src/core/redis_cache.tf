## Database subnet
module "redis_snet" {
  source                                    = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v6.14.0"
  name                                      = format("%s-redis-snet", local.project)
  address_prefixes                          = var.cidr_subnet_redis
  resource_group_name                       = azurerm_resource_group.rg_vnet.name
  virtual_network_name                      = module.vnet.name
  private_endpoint_network_policies_enabled = true
}

module "redis" {
  source                        = "git::https://github.com/pagopa/terraform-azurerm-v3.git//redis_cache?ref=v6.14.0"
  name                          = format("%s-redis", local.project)
  resource_group_name           = azurerm_resource_group.data.name
  location                      = azurerm_resource_group.data.location
  capacity                      = var.redis_capacity
  redis_version                 = var.redis_version
  family                        = var.redis_family
  sku_name                      = var.redis_sku_name
  public_network_access_enabled = !var.redis_private_endpoint_enabled

  private_endpoint = {
    enabled              = var.redis_private_endpoint_enabled
    virtual_network_id   = azurerm_resource_group.rg_vnet.id
    subnet_id            = module.redis_snet.id
    private_dns_zone_ids = var.redis_private_endpoint_enabled ? [azurerm_private_dns_zone.privatelink_redis_cache_windows_net[0].id] : []
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

  key_vault_id = module.key_vault.id
}
