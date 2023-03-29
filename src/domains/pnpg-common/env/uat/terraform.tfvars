prefix         = "selc"
env_short      = "u"
env            = "uat"
domain         = "pnpg"
location       = "westeurope"
location_short = "weu"
instance       = "uat"

dns_zone_prefix = "uat.selfcare"
external_domain = "pagopa.it"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Uat"
  Owner       = "Selfcare"
  Source      = "https://github.com/pagopa/selfcare-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
  Application = "PNPG"
}

### External resources

monitor_resource_group_name                 = "selc-u-monitor-rg"
log_analytics_workspace_name                = "selc-u-law"
log_analytics_workspace_resource_group_name = "selc-u-monitor-rg"

# Vnet
cidr_subnet_redis                 = ["10.1.132.0/24"]
cidr_subnet_logs_storage          = ["10.1.139.0/24"]
cidr_subnet_pnpg_cosmosdb_mongodb = ["10.1.141.0/24"] #this is a place holder for pnpg mongo

# spid-testenv
enable_spid_test = true

# redis
redis_sku_name = "Standard"
redis_family   = "C"
redis_capacity = 0

#
# Mongo
#
# CosmosDb MongoDb
cosmosdb_mongodb_offer_type                    = "Standard"
cosmosdb_mongodb_public_network_access_enabled = false
cosmosdb_mongodb_consistency_policy = {
  consistency_level       = "Session"
  max_interval_in_seconds = null
  max_staleness_prefix    = null
}
# cosmosdb_mongodb_extra_capabilities               = ["EnableServerless"]
cosmosdb_mongodb_main_geo_location_zone_redundant = false
cosmosdb_mongodb_additional_geo_locations         = []
cosmosdb_mongodb_throughput                       = 1000
cosmosdb_mongodb_max_throughput                   = 1000
cosmosdb_mongodb_enable_autoscaling               = true
cosmosdb_mongodb_private_endpoint_enabled         = true

# CDN
robots_indexed_paths = []

# Storage Logs
# logs storage
logs_account_replication_type   = "LRS"
logs_delete_retention_days      = 14
logs_enable_versioning          = false
logs_advanced_threat_protection = true
