output "vnet_name" {
  value = module.vnet.name
}

output "vnet_address_space" {
  value = module.vnet.address_space
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

## AKS

output "aks_outbound_ips" {
  value = azurerm_public_ip.aks_outbound.*.ip_address
}

output "aks_outbound_temp_ips" {
  value = azurerm_public_ip.aks_outbound_temp.*.ip_address
}

## key vault ##
output "key_vault_uri" {
  value = module.key_vault.vault_uri
}

output "key_vault_name" {
  value = module.key_vault.name
}

## Application gateway.
output "app_gateway_public_ip" {
  value = azurerm_public_ip.appgateway_public_ip.ip_address
}

output "app_gateway_fqdn" {
  value = azurerm_public_ip.appgateway_public_ip.fqdn
}

output "api_fqdn" {
  value = azurerm_dns_a_record.dns_a_api.fqdn
}

output "reverse_proxy_ip" {
  value = var.reverse_proxy_ip
}

output "private_dns_name" {
  value = var.private_dns_name
}

output "ca_suffix_dns_private_name" {
  value = var.ca_suffix_dns_private_name
}

## CosmosDb - MongoDB ##
output "cosmosdb_account_mongodb_id" {
  value = module.cosmosdb_account_mongodb.id
}

output "cosmosdb_account_mongodb_endpoint" {
  value = module.cosmosdb_account_mongodb.endpoint
}

output "cosmosdb_account_mongodb_primary_key" {
  value     = module.cosmosdb_account_mongodb.primary_key
  sensitive = true
}

output "cosmosdb_account_mongodb_primary_readonly_key" {
  value     = module.cosmosdb_account_mongodb.primary_readonly_master_key
  sensitive = true
}

output "cosmosdb_account_mongodb_connection_strings" {
  value     = module.cosmosdb_account_mongodb.connection_strings
  sensitive = true
}

