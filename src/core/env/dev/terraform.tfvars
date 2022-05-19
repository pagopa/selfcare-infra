# general
env       = "dev"
env_short = "d"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "SelfCare"
  Source      = "https://github.com/pagopa/selfcare-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

lock_enable = false

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
dns_zone_prefix = "dev.selfcare"

# azure devops
azdo_sp_tls_cert_enabled = true
enable_azdoa             = true
enable_iac_pipeline      = true

# apim
apim_publisher_name = "pagoPA SelfCare DEV"
apim_sku            = "Developer_1"

# app_gateway
app_gateway_api_certificate_name = "api-dev-selfcare-pagopa-it"

# redis
redis_sku_name                 = "Basic"
redis_family                   = "C"
redis_capacity                 = 0
redis_private_endpoint_enabled = false

# aks
aks_alerts_enabled = false
# This is the k8s ingress controller ip. It must be in the aks subnet range.
reverse_proxy_ip        = "10.1.0.250"
aks_max_pods            = 100
aks_enable_auto_scaling = false
aks_min_count           = null
aks_max_count           = null
aks_vm_size             = "Standard_B4ms"

# CosmosDb MongoDb
cosmosdb_mongodb_extra_capabilities               = ["EnableServerless"]
cosmosdb_mongodb_main_geo_location_zone_redundant = false

# postgres
postgres_sku_name       = "GP_Gen5_2"
postgres_enable_replica = false
postgres_configuration = {
  autovacuum_work_mem         = "-1"
  effective_cache_size        = "655360"
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
  "ns-415.awsdns-51.com",
  "ns-1446.awsdns-52.org",
  "ns-944.awsdns-54.net",
  "ns-1742.awsdns-25.co.uk",
]