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
cidr_subnet_azdoa            = ["10.1.130.0/24"]
cidr_subnet_redis            = ["10.1.132.0/24"]
cidr_subnet_vpn              = ["10.1.133.0/24"]
cidr_subnet_dnsforwarder     = ["10.1.134.0/29"]
cidr_subnet_cosmosdb_mongodb = ["10.1.135.0/24"]
cidr_subnet_apim             = ["10.1.136.0/24"]

# dns
external_domain = "pagopa.it"
dns_zone_prefix = "selfcare"

# azure devops
azdo_sp_tls_cert_enabled = true
enable_azdoa             = true
enable_iac_pipeline      = true

# apim
apim_publisher_name = "pagoPA SelfCare PROD"
apim_sku            = "Developer_1" # todo change to Premium_1 before launch

# app_gateway
app_gateway_api_certificate_name = "api-selfcare-pagopa-it"
app_gateway_min_capacity         = 0 # todo change to at least 1
app_gateway_max_capacity         = 2

# todo change to Premium before launch
# redis_sku_name = "Premium"
# redis_family   = "P"

# aks
# This is the k8s ingress controller ip. It must be in the aks subnet range.
reverse_proxy_ip = "10.1.0.250"
# aks_availability_zones = [1, 2, 3]         # TODO to define and uncomment before release to prod
aks_node_count = 1 # TODO to define before release to prod
aks_max_pods   = 100
# aks_vm_size            = "Standard_D8S_v3" # TODO to define and uncomment before release to prod
# aks_sku_tier           = "Paid"            # TODO to define and uncomment before release to prod

# CosmosDb MongoDb
cosmosdb_mongodb_enable_serverless = true # TODO set to false before launch
# cosmosdb_mongodb_enable_autoscaling = true TODO uncomment befor launch
# cosmosdb_mongodb_max_throughput TODO define before launch
cosmosdb_mongodb_enable_free_tier = true # TODO change to false before launch
# cosmosdb_mongodb_additional_geo_locations TODO do we want replication?
