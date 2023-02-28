# general
env                 = "prod"
env_short           = "p"
location            = "westeurope"
location_short      = "weu"
location_pair       = "northeurope"
location_pair_short = "neu"

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
cidr_subnet_eventhub         = ["10.1.138.0/24"]
cidr_subnet_logs_storage     = ["10.1.139.0/24"]
#
# AKS
#
cidr_aks_vnet                 = ["10.11.0.0/16"]
vnet_aks_ddos_protection_plan = false

# dns
external_domain = "pagopa.it"
dns_zone_prefix = "selfcare"

# azure devops
azdo_sp_tls_cert_enabled = true
enable_azdoa             = true
enable_iac_pipeline      = true

# apim
apim_publisher_name = "pagoPA SelfCare PROD"
apim_sku            = "Premium_1" # TODO

# app_gateway
app_gateway_api_certificate_name = "api-selfcare-pagopa-it"
app_gateway_min_capacity         = 0 # todo change to at least 1
app_gateway_max_capacity         = 2
app_gateway_sku_name             = "WAF_v2"
app_gateway_sku_tier             = "WAF_v2"
app_gateway_alerts_enabled       = true
app_gateway_waf_enabled          = true

# redis
redis_sku_name = "Standard"
redis_family   = "C"
redis_capacity = 0

# aks
# This is the k8s ingress controller ip. It must be in the aks subnet range.
reverse_proxy_ip                  = "10.1.1.250"
aks_kubernetes_version            = "1.23.12"
aks_system_node_pool_os_disk_type = "Ephemeral"
aks_upgrade_settings_max_surge    = "33%"
aks_sku_tier                      = "Paid"

aks_system_node_pool_vm_size                      = "Standard_D4ds_v5"
aks_system_node_pool_node_count_min               = 2
aks_system_node_pool_node_count_max               = 3
aks_system_node_pool_only_critical_addons_enabled = false

#
# Docker
#
docker_registry = {
  sku                     = "Premium"
  zone_redundancy_enabled = true
  geo_replication = {
    enabled                   = true
    regional_endpoint_enabled = true
    zone_redundancy_enabled   = true
  }
}

# CosmosDb MongoDb
cosmosdb_mongodb_extra_capabilities = []
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

dns_ns_interop_selfcare = [
  "ns-1355.awsdns-41.org",
  "ns-601.awsdns-11.net",
  "ns-2030.awsdns-61.co.uk",
  "ns-119.awsdns-14.com",
]

## Event hub
eventhub_sku_name                 = "Standard"
eventhub_capacity                 = 2
eventhub_auto_inflate_enabled     = true
eventhub_maximum_throughput_units = 4
eventhub_zone_redundant           = true
eventhub_alerts_enabled           = false

eventhub_ip_rules = [
  { // DATALAKE
    ip_mask = "18.192.147.151",
    action  = "Allow"
  }
]

eventhubs = [{
  name              = "SC-Contracts"
  partitions        = 30
  message_retention = 7
  consumers         = []
  keys = [
    {
      name   = "selfcare-wo"
      listen = false
      send   = true
      manage = false
    },
    {
      name   = "datalake"
      listen = true
      send   = false
      manage = false
    },
    {
      name   = "pn"
      listen = true
      send   = false
      manage = false
    },
    {
      name   = "interceptor"
      listen = true
      send   = false
      manage = false
    }
  ]
}]
##

# logs storage
logs_account_replication_type   = "RAGZRS"
logs_delete_retention_days      = 14
logs_enable_versioning          = false
logs_advanced_threat_protection = true
