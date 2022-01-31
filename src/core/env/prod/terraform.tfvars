# general
env_short = "p"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "SelfCare"
  Source      = "https://github.com/pagopa/selfcare-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

lock_enable = true

# networking
# main vnet
cidr_vnet                    = ["10.1.0.0/16"]
cidr_subnet_k8s              = ["10.1.0.0/17"]
cidr_subnet_appgateway       = ["10.1.128.0/24"]
cidr_subnet_postgres         = ["10.1.129.0/24"]
cidr_subnet_azdoa            = ["10.1.130.0/24"]
cidr_subnet_redis            = ["10.1.132.0/24"]
cidr_subnet_vpn              = ["10.1.133.0/24"]
cidr_subnet_dns_forwarder    = ["10.1.134.0/29"]
cidr_subnet_cosmosdb_mongodb = ["10.1.135.0/24"]
cidr_subnet_apim             = ["10.1.136.0/24"]
cidr_subnet_contract_storage = ["10.1.137.0/24"]

# dns
external_domain = "pagopa.it"
dns_zone_prefix = "selfcare"

# azure devops
azdo_sp_tls_cert_enabled = true
enable_azdoa             = true
enable_iac_pipeline      = true

# apim
apim_publisher_name = "pagoPA SelfCare PROD"
apim_sku            = "Developer_1"

# app_gateway
app_gateway_api_certificate_name = "api-selfcare-pagopa-it"
app_gateway_min_capacity         = 0 # todo change to at least 1
app_gateway_max_capacity         = 2
app_gateway_sku_name             = "Standard_v2" # TODO change to WAF_v2
app_gateway_sku_tier             = "Standard_v2" # TODO change to WAF_v2
app_gateway_alerts_enabled       = true          # TODO change to true
app_gateway_waf_enabled          = false         # TODO change to true

# redis
redis_sku_name = "Standard"
redis_family   = "C"
redis_capacity = 0

# aks
# This is the k8s ingress controller ip. It must be in the aks subnet range.
reverse_proxy_ip               = "10.1.0.250"
aks_availability_zones         = [1, 2, 3]
aks_node_count                 = 1
aks_max_pods                   = 100
aks_enable_auto_scaling        = true
aks_min_count                  = 1
aks_max_count                  = 3
aks_upgrade_settings_max_surge = "33%"
aks_vm_size                    = "Standard_D4s_v5"
aks_sku_tier                   = "Paid"

# CosmosDb MongoDb
cosmosdb_mongodb_enable_serverless  = false
cosmosdb_mongodb_enable_autoscaling = true
# cosmosdb_mongodb_max_throughput TODO define before launch
cosmosdb_mongodb_enable_free_tier                 = true
cosmosdb_mongodb_main_geo_location_zone_redundant = false
cosmosdb_mongodb_additional_geo_locations = [{
  location          = "northeurope"
  failover_priority = 1
  zone_redundant    = false
}]

#postgres
postgres_sku_name                     = "GP_Gen5_2"
postgres_geo_redundant_backup_enabled = true
postgres_enable_replica               = false
postgres_configuration = {
  autovacuum_work_mem         = "-1"
  effective_cache_size        = "5242880"
  log_autovacuum_min_duration = "5000"
  log_connections             = "off"
  log_line_prefix             = "%t [%p apps:%a host:%r]: [%l-1] db=%d,user=%u"
  log_temp_files              = "4096"
  maintenance_work_mem        = "524288"
  max_wal_size                = "4096"
  log_connections             = "on"
  log_checkpoints             = "on"
  connection_throttling       = "on"
}

# contracts storage
contracts_account_replication_type   = "RAGZRS"
contracts_delete_retention_days      = 14
contracts_enable_versioning          = true
contracts_advanced_threat_protection = true

robots_indexed_paths = ["/"]
