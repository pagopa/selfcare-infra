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
output "aks_cluster_name" {
  value = module.aks.name
}

output "aks_fqdn" {
  value = module.aks.fqdn
}

output "aks_private_fqdn" {
  value = module.aks.private_fqdn
}

output "aks_outbound_ips" {
  value = azurerm_public_ip.aks_outbound.*.ip_address
}

## key vault ##
output "key_vault_uri" {
  value = module.key_vault.vault_uri
}

output "key_vault_name" {
  value = module.key_vault.name
}

## Container registry ##
output "container_registry_login_server" {
  value = module.acr.login_server
}

output "container_registry_admin_username" {
  value = module.acr.admin_username
}

output "container_registry_admin_password" {
  value     = module.acr.admin_password
  sensitive = true
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

## Postgresql server
output "postgresql_fqdn" {
  value = module.postgresql.fqdn
}

output "postgresql_administrator_login" {
  value     = data.azurerm_key_vault_secret.postgres_administrator_login.value
  sensitive = true
}

output "postgresql_administrator_login_password" {
  value     = data.azurerm_key_vault_secret.postgres_administrator_login_password.value
  sensitive = true
}

output "postgresql_replica_fqdn" {
  value = module.postgresql.replica_fqdn
}
