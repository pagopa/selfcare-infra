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

## CosmosDb - MongoDB ##
output "cosmosdb_account_mongodb_id" {
  value = module.cosmosdb_account_mongodb.id
}

output "cosmosdb_account_mongodb_endpoint" {
  value = module.cosmosdb_account_mongodb.endpoint
}

output "cosmosdb_account_mongodb_primary_key" {
  value = module.cosmosdb_account_mongodb.primary_key
}

output "cosmosdb_account_mongodb_primary_readonly_key" {
  value = module.cosmosdb_account_mongodb.primary_readonly_master_key
}

output "cosmosdb_account_mongodb_connection_strings" {
  value = module.cosmosdb_account_mongodb.connection_strings
}

output "cosmosdb_mongodb_id" {
  value = azurerm_cosmosdb_mongo_database.mongodb.id
}
