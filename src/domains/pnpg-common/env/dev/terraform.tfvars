prefix         = "selc"
env_short      = "d"
env            = "dev"
domain         = "pnpg"
location       = "westeurope"
location_short = "weu"
instance       = "dev"

dns_zone_prefix = "dev.selfcare"
external_domain = "pagopa.it"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "Selfcare"
  Source      = "https://github.com/pagopa/selfcare-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
  Application = "PNPG"
}

### External resources

monitor_resource_group_name                 = "selc-d-monitor-rg"
log_analytics_workspace_name                = "selc-d-law"
log_analytics_workspace_resource_group_name = "selc-d-monitor-rg"

# Vnet
cidr_subnet_pnpg_cosmosdb_mongodb = ["10.1.140.0/24"] #this is a place holder for pnpg mongo
cidr_subnet_redis                 = ["10.1.143.0/29"]
cidr_subnet_logs_storage          = ["10.1.143.8/29"]

# spid-testenv
enable_spid_test = true

# redis
redis_sku_name                 = "Basic"
redis_family                   = "C"
redis_capacity                 = 0
redis_private_endpoint_enabled = false

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
cosmosdb_mongodb_extra_capabilities               = ["EnableServerless"]
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
