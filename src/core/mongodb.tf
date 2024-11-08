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
  source               = "github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v7.50.1"
  name                 = format("%s-cosmosb-mongodb-snet", local.project)
  resource_group_name  = azurerm_resource_group.rg_vnet.name
  virtual_network_name = module.vnet.name
  address_prefixes     = var.cidr_subnet_cosmosdb_mongodb

  private_endpoint_network_policies_enabled = true
  service_endpoints                         = ["Microsoft.Web"]
}

###???
module "cosmosdb_account_mongodb" {
  source = "github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_account?ref=v7.50.1"

  name                = format("%s-cosmosdb-mongodb-account", local.project)
  location            = azurerm_resource_group.mongodb_rg.location
  domain              = var.external_domain
  resource_group_name = azurerm_resource_group.mongodb_rg.name
  offer_type          = var.cosmosdb_mongodb_offer_type
  kind                = "MongoDB"
  capabilities = concat([
    "EnableMongo"
  ], var.cosmosdb_mongodb_extra_capabilities)
  mongo_server_version = "4.2"

  public_network_access_enabled         = var.env_short == "p" ? false : var.cosmosdb_mongodb_public_network_access_enabled
  private_endpoint_enabled              = var.cosmosdb_mongodb_private_endpoint_enabled
  private_endpoint_mongo_name           = "${local.project}-cosmosdb-mongodb-account"
  private_service_connection_mongo_name = "${local.project}-cosmosdb-mongodb-account-private-endpoint-mongo"
  subnet_id                             = module.cosmosdb_mongodb_snet.id
  private_dns_zone_mongo_ids = var.cosmosdb_mongodb_private_endpoint_enabled ? [
    azurerm_private_dns_zone.privatelink_mongo_cosmos_azure_com.id
  ] : []
  is_virtual_network_filter_enabled = true

  consistency_policy = var.cosmosdb_mongodb_consistency_policy

  main_geo_location_location       = azurerm_resource_group.mongodb_rg.location
  main_geo_location_zone_redundant = var.cosmosdb_mongodb_main_geo_location_zone_redundant

  additional_geo_locations = var.cosmosdb_mongodb_additional_geo_locations

  backup_continuous_enabled = true

  tags = var.tags
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "cosmosdb_account_mongodb_connection_strings" {
  name         = "mongodb-connection-string"
  value        = module.cosmosdb_account_mongodb.connection_strings[0]
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

# selcMsCore
resource "azurerm_cosmosdb_mongo_database" "selc_ms_core" {
  name                = "selcMsCore"
  resource_group_name = azurerm_resource_group.mongodb_rg.name
  account_name        = module.cosmosdb_account_mongodb.name

  throughput = var.cosmosdb_mongodb_enable_autoscaling || local.cosmosdb_mongodb_enable_serverless ? null : var.cosmosdb_mongodb_throughput

  dynamic "autoscale_settings" {
    for_each = var.cosmosdb_mongodb_enable_autoscaling && !local.cosmosdb_mongodb_enable_serverless ? [
      ""
    ] : []
    content {
      max_throughput = var.cosmosdb_mongodb_max_throughput
    }
  }

  lifecycle {
    ignore_changes = [
      autoscale_settings
    ]
  }
}

resource "azurerm_management_lock" "mongodb_selc_ms_core" {
  name       = "mongodb-selc-ms-core-lock"
  scope      = azurerm_cosmosdb_mongo_database.selc_ms_core.id
  lock_level = "CanNotDelete"
  notes      = "This items can't be deleted in this subscription!"
}

locals {
  mongo = {
    selcMsCore = {
      collections = [
        {
          name = "Institution"
          indexes = [
            {
              keys   = ["_id"]
              unique = true
            },
            {
              keys   = ["externalId"]
              unique = true
            },
            {
              keys   = ["geographicTaxonomies.code"]
              unique = false
            },
            {
              keys   = ["onboarding.productId"]
              unique = false
            },
            {
              keys   = ["taxCode"]
              unique = false
            }
          ]
        },
        {
          name = "Delegations"
          indexes = [
            {
              keys   = ["_id"]
              unique = true
            },
            {
              keys   = ["institutionFromName"]
              unique = false
            },
            {
              keys   = ["from"]
              unique = false
            },
            {
              keys   = ["to"]
              unique = false
            },
            {
              keys   = ["toTaxCode"]
              unique = false
            }
          ]
        },
      ]
    }
  }
}

module "selc_ms_core_collections" {
  source = "github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_mongodb_collection?ref=v7.50.1"

  for_each = {
    for index, coll in local.mongo.selcMsCore.collections :
    coll.name => coll
  }

  name                = each.value.name
  resource_group_name = azurerm_resource_group.mongodb_rg.name

  cosmosdb_mongo_account_name  = module.cosmosdb_account_mongodb.name
  cosmosdb_mongo_database_name = azurerm_cosmosdb_mongo_database.selc_ms_core.name

  indexes = each.value.indexes

  lock_enable = true
}
