# general
env                 = "uat"
env_short           = "u"
location            = "westeurope"
location_pair       = "northeurope"
location_short      = "weu"
location_pair_short = "neu"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Uat"
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
dns_zone_prefix = "uat.selfcare"

# azure devops
azdo_sp_tls_cert_enabled = true
enable_azdoa             = true
enable_iac_pipeline      = true

# apim
apim_publisher_name = "pagoPA SelfCare UAT"
apim_sku            = "Developer_1"

# app_gateway
app_gateway_api_certificate_name = "api-uat-selfcare-pagopa-it"

# redis
redis_sku_name = "Standard"
redis_family   = "C"
redis_capacity = 0

# aks
aks_alerts_enabled = false
# This is the k8s ingress controller ip. It must be in the aks subnet range.
reverse_proxy_ip       = "10.1.1.250"
aks_kubernetes_version = "1.23.12"

aks_system_node_pool_os_disk_type                 = "Managed"
aks_system_node_pool_vm_size                      = "Standard_B4ms"
aks_system_node_pool_only_critical_addons_enabled = false

#
# Docker
#
docker_registry = {
  sku                     = "Basic"
  zone_redundancy_enabled = false
  geo_replication = {
    enabled                   = false
    regional_endpoint_enabled = false
    zone_redundancy_enabled   = false
  }
}

# CosmosDb MongoDb
cosmosdb_mongodb_extra_capabilities               = ["EnableServerless"]
cosmosdb_mongodb_main_geo_location_zone_redundant = false

# postgres
postgres_sku_name       = "GP_Gen5_2"
postgres_enable_replica = false
# postgres_storage_mb     = 204800 # 200 GB TODO to define
postgres_configuration = {
  autovacuum_work_mem         = "-1"
  effective_cache_size        = "2621440"
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
postgres_alerts_enabled = false

# spid-testenv
enable_spid_test = true

robots_indexed_paths = []

dns_ns_interop_selfcare = [
  "ns-875.awsdns-45.net",
  "ns-1323.awsdns-37.org",
  "ns-387.awsdns-48.com",
  "ns-2032.awsdns-62.co.uk",
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
  },
  { // PN - DEV
    ip_mask = "15.160.101.29",
    action  = "Allow"
  },
  { // PN - DEV
    ip_mask = "15.161.210.71",
    action  = "Allow"
  },
  { // PN - DEV
    ip_mask = "35.152.45.223",
    action  = "Allow"
  },
  { // PN - SVIL
    ip_mask = "35.152.100.243",
    action  = "Allow"
  },
  { // PN - SVIL
    ip_mask = "15.160.72.148",
    action  = "Allow"
  },
  { // PN - SVIL
    ip_mask = "15.160.13.35",
    action  = "Allow"
  },
  { // PN - COLL
    ip_mask = "18.102.20.123",
    action  = "Allow"
  },
  { // PN - COLL
    ip_mask = "18.102.29.57",
    action  = "Allow"
  },
  { // PN - COLL
    ip_mask = "15.161.109.164",
    action  = "Allow"
  },
  { // PN - HOTFIX
    ip_mask = "15.160.107.164",
    action  = "Allow"
  },
  { // PN - HOTFIX
    ip_mask = "15.161.191.7",
    action  = "Allow"
  },
  { // PN - HOTFIX
    ip_mask = "18.102.83.181",
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
    }
  ]
}]
##
