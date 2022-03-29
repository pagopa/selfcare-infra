resource "azurerm_resource_group" "mongodb_rg" {
  name     = format("%s-cosmosdb-mongodb-rg", local.project)
  location = var.location

  tags = var.tags
}

locals {
  base_capabilities = [
    "EnableMongo"
  ]
  cosmosdb_mongodb_enable_serverless = contains(var.cosmosdb_mongodb_extra_capabilities, "EnableServerless")
}

# cosmosdb-Mongo subnet
module "cosmosdb_mongodb_snet" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.58"
  name                 = format("%s-cosmosb-mongodb-snet", local.project)
  resource_group_name  = azurerm_resource_group.rg_vnet.name
  virtual_network_name = module.vnet.name
  address_prefixes     = var.cidr_subnet_cosmosdb_mongodb

  enforce_private_link_endpoint_network_policies = true
  service_endpoints                              = ["Microsoft.Web"]
}

module "cosmosdb_account_mongodb" {
  source = "git::https://github.com/pagopa/azurerm.git//cosmosdb?ref=v2.0.19"

  name                 = format("%s-cosmosdb-mongodb-account", local.project)
  location             = azurerm_resource_group.mongodb_rg.location
  resource_group_name  = azurerm_resource_group.mongodb_rg.name
  offer_type           = var.cosmosdb_mongodb_offer_type
  kind                 = "MongoDB"
  capabilities         = concat(["EnableMongo"], var.cosmosdb_mongodb_extra_capabilities)
  mongo_server_version = "4.0"

  public_network_access_enabled     = var.env_short == "p" ? false : var.cosmosdb_mongodb_public_network_access_enabled
  private_endpoint_enabled          = var.cosmosdb_mongodb_private_endpoint_enabled
  subnet_id                         = module.cosmosdb_mongodb_snet.id
  private_dns_zone_ids              = var.cosmosdb_mongodb_private_endpoint_enabled ? [azurerm_private_dns_zone.privatelink_mongo_cosmos_azure_com.id] : []
  is_virtual_network_filter_enabled = true

  consistency_policy = var.cosmosdb_mongodb_consistency_policy

  main_geo_location_location       = azurerm_resource_group.mongodb_rg.location
  main_geo_location_zone_redundant = var.cosmosdb_mongodb_main_geo_location_zone_redundant

  additional_geo_locations = var.cosmosdb_mongodb_additional_geo_locations

  backup_continuous_enabled = true

  lock_enable = true

  tags = var.tags
}

resource "azurerm_cosmosdb_mongo_database" "selc_product" {
  name                = "selcProduct"
  resource_group_name = azurerm_resource_group.mongodb_rg.name
  account_name        = module.cosmosdb_account_mongodb.name

  throughput = var.cosmosdb_mongodb_enable_autoscaling || local.cosmosdb_mongodb_enable_serverless ? null : var.cosmosdb_mongodb_throughput

  dynamic "autoscale_settings" {
    for_each = var.cosmosdb_mongodb_enable_autoscaling && !local.cosmosdb_mongodb_enable_serverless ? [""] : []
    content {
      max_throughput = var.cosmosdb_mongodb_max_throughput
    }
  }
}

resource "azurerm_management_lock" "mongodb_selc_product" {
  name       = "mongodb-selc-product-lock"
  scope      = azurerm_cosmosdb_mongo_database.selc_product.id
  lock_level = "CanNotDelete"
  notes      = "This items can't be deleted in this subscription!"
}

resource "azurerm_cosmosdb_mongo_database" "selc_user_group" {
  name                = "selcUserGroup"
  resource_group_name = azurerm_resource_group.mongodb_rg.name
  account_name        = module.cosmosdb_account_mongodb.name

  throughput = var.cosmosdb_mongodb_enable_autoscaling || local.cosmosdb_mongodb_enable_serverless ? null : var.cosmosdb_mongodb_throughput

  dynamic "autoscale_settings" {
    for_each = var.cosmosdb_mongodb_enable_autoscaling && !local.cosmosdb_mongodb_enable_serverless ? [""] : []
    content {
      max_throughput = var.cosmosdb_mongodb_max_throughput
    }
  }
}

resource "azurerm_management_lock" "mongodb_selc_user_group" {
  name       = "mongodb-selc-user-group-lock"
  scope      = azurerm_cosmosdb_mongo_database.selc_user_group.id
  lock_level = "CanNotDelete"
  notes      = "This items can't be deleted in this subscription!"
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "cosmosdb_account_mongodb_connection_strings" {
  name         = "mongodb-connection-string"
  value        = module.cosmosdb_account_mongodb.connection_strings[0]
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

# Collections
resource "azurerm_cosmosdb_mongo_collection" "products" {
  name                = "products"
  resource_group_name = azurerm_resource_group.mongodb_rg.name
  account_name        = module.cosmosdb_account_mongodb.name
  database_name       = azurerm_cosmosdb_mongo_database.selc_product.name

  default_ttl_seconds = 0 # no TTL

  index {
    keys   = ["_id"]
    unique = true
  }
}

module "mongdb_collection_products" {
  source = "git::https://github.com/pagopa/azurerm.git//cosmosdb_mongodb_collection?ref=v2.3.0"

  name                = "products"
  resource_group_name = azurerm_resource_group.mongodb_rg.name

  cosmosdb_mongo_account_name  = module.cosmosdb_account_mongodb.name
  cosmosdb_mongo_database_name = azurerm_cosmosdb_mongo_database.selc_product.name

  indexes = [{
      keys   = ["_id"]
      unique = true
    },
    {
      keys   = ["parent"]
      unique = false
    }
  ]

  lock_enable = true
}

module "mongdb_collection_user-groups" {
  source = "git::https://github.com/pagopa/azurerm.git//cosmosdb_mongodb_collection?ref=v2.3.0"

  name                = "userGroups"
  resource_group_name = azurerm_resource_group.mongodb_rg.name

  cosmosdb_mongo_account_name  = module.cosmosdb_account_mongodb.name
  cosmosdb_mongo_database_name = azurerm_cosmosdb_mongo_database.selc_user_group.name

  indexes = [{
    keys   = ["_id"]
    unique = true
    },
    {
      keys   = ["institutionId", "productId", "name"]
      unique = true
    },
    {
      keys   = ["institutionId"]
      unique = false
    },
    {
      keys   = ["productId"]
      unique = false
    },
    {
      keys   = ["members"]
      unique = false
    }
  ]

  lock_enable = true
}
