# resource "azurerm_resource_group" "mongodb_bk_rg" {
#   name     = format("%s-cosmosdb-bk-mongodb-rg", local.project)
#   location = var.location

#   tags = var.tags
# }

# locals {
#   base_capabilities = [
#     "EnableMongo"
#   ]
#   cosmosdb_mongodb_enable_serverless = contains(var.cosmosdb_mongodb_extra_capabilities, "EnableServerless")
# }

# cosmosdb-Mongo subnet
# module "cosmosdb_bk_mongodb_snet" {
#   source               = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v7.3.0"
#   name                 = format("%s-cosmosdb-bk-mongodb-snet", local.project)
#   resource_group_name  = azurerm_resource_group.rg_vnet.name
#   virtual_network_name = module.vnet.name
#   address_prefixes     = var.cidr_subnet_cosmosdb_bk_mongodb

#   private_endpoint_network_policies_enabled = true
#   service_endpoints                         = ["Microsoft.Web"]
# }

###???
# module "cosmosdb_bk_account_mongodb" {
#   source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_account?ref=v7.3.0"

#   name                 = format("%s-cosmosdb-bk-mongodb-account", local.project)
#   location             = azurerm_resource_group.mongodb_bk_rg.location
#   domain               = var.external_domain
#   resource_group_name  = azurerm_resource_group.mongodb_bk_rg.name
#   offer_type           = var.cosmosdb_mongodb_offer_type
#   kind                 = "MongoDB"
#   capabilities         = concat(["EnableMongo"], var.cosmosdb_mongodb_extra_capabilities)
#   mongo_server_version = "4.0"
#   enable_free_tier     = false

#   public_network_access_enabled     = var.env_short == "p" ? false : var.cosmosdb_mongodb_public_network_access_enabled
#   private_endpoint_enabled          = var.cosmosdb_mongodb_private_endpoint_enabled
#   private_endpoint_mongo_name       = "${local.project}-cosmosdb-bk-mongodb-account"
#   subnet_id                         = module.cosmosdb_bk_mongodb_snet.id
#   private_dns_zone_mongo_ids        = var.cosmosdb_mongodb_private_endpoint_enabled ? [azurerm_private_dns_zone.privatelink_mongo_cosmos_azure_com.id] : []
#   is_virtual_network_filter_enabled = true

#   consistency_policy = var.cosmosdb_mongodb_consistency_policy

#   main_geo_location_location       = azurerm_resource_group.mongodb_bk_rg.location
#   main_geo_location_zone_redundant = var.cosmosdb_mongodb_main_geo_location_zone_redundant

#   additional_geo_locations = var.cosmosdb_mongodb_additional_geo_locations

#   backup_continuous_enabled = true

#   tags = var.tags
# }


#


