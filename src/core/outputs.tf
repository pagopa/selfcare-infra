output "vnet_name" {
  value = module.vnet.name
}

output "vnet_address_space" {
  value = module.vnet.address_space
}

output "vnet_integration_name" {
  value = module.vnet_integration.name
}

output "vnet_integration_address_space" {
  value = module.vnet_integration.address_space
}

## Redis cache
output "redis_primary_access_key" {
  value     = module.redis.primary_access_key
  sensitive = true
}

output "redis_hostname" {
  value = module.redis.hostname
}

output "redis_port" {
  value = module.redis.port
}

output "redis_ssl_port" {
  value = module.redis.ssl_port
}
