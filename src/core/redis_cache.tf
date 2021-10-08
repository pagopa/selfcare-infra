## Database subnet
module "redis_snet" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.58"
  count                = var.redis_sku_name == "Premium" && length(var.cidr_subnet_redis) > 0 ? 1 : 0
  name                 = format("%s-redis-snet", local.project)
  address_prefixes     = var.cidr_subnet_redis
  resource_group_name  = azurerm_resource_group.rg_vnet.name
  virtual_network_name = module.vnet.name
}

module "redis" {
  source                = "git::https://github.com/pagopa/azurerm.git//redis_cache?ref=v1.0.58"
  name                  = format("%s-redis", local.project)
  resource_group_name   = azurerm_resource_group.data.name
  location              = azurerm_resource_group.data.location
  capacity              = var.redis_capacity
  enable_non_ssl_port   = false
  family                = var.redis_family
  sku_name              = var.redis_sku_name
  enable_authentication = true
  subnet_id             = length(module.redis_snet.*.id) == 0 ? null : module.redis_snet[0].id

  tags = var.tags
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "redis_primary_access_key" {
  name         = "redis-primary-access-key"
  value        = module.redis.primary_access_key
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}
