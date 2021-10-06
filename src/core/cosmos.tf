resource "azurerm_resource_group" "cosmosdb_rg" {
  name     = format("%s-cosmosdb-mongodb-rg", local.project)
  location = var.location

  tags = var.tags
}

locals {
  base_capabilities: [
    "EnableMongo"
  ]
}

module "cosmosdb_account_mongodb" {
  source = "git::https://github.com/pagopa/io-infrastructure-modules-new.git//azurerm_cosmosdb_account?ref=v3.0.15"

  name                = format("%s-cosmosdb-mongodb-account", local.project)
  location            = azurerm_resource_group.cosmosdb_rg.location
  resource_group_name = azurerm_resource_group.cosmosdb_rg.name
  offer_type          = var.cosmosdb_mongodb_offer_type
  kind                = "MongoDB"

  enable_free_tier = var.cosmosdb_mongodb_enable_free_tier

  public_network_access_enabled = var.cosmosdb_mongodb_public_network_access_enabled
  is_virtual_network_filter_enabled = false

  mongo_server_version="4.0"

  capabilities=var.cosmosdb_mongodb_enable_serverless? concat(local.base_capabilities, "EnableServerless") : local.base_capabilities

  consistency_policy=var.cosmosdb_mongodb_consistency_policy

  main_geo_location_location = azurerm_resource_group.cosmosdb_rg.location

  additional_geo_locations = var.cosmosdb_mongodb_additional_geo_locations

  tags = var.tags
}

resource "azurerm_cosmosdb_mongodb_database" "cosmosdb_mongodb" {
  name                = format("%s-cosmosdb-mongodb", local.project)
  resource_group_name = module.cosmosdb_account_mongodb.resource_group_name
  account_name        = module.cosmosdb_account_mongodb.name

  throughput         = !var.cosmosdb_mongodb_enable_autoscaling && !var.cosmosdb_mongodb_enable_serverless ? null : var.cosmosdb_mongodb_throughput
  autoscale_settings = var.cosmosdb_mongodb_enable_autoscaling && !var.cosmosdb_mongodb_enable_serverless? {max_throughput: var.cosmosdb_mongodb_max_throughput} : null

  tags = var.tags
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "cosmosdb_account_mongodb_connection_strings" {
  name         = "appinsights-instrumentation-key"
  value        = module.cosmosdb_account_mongodb.connection_strings
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}
