# general
env_short           = "d"
env                 = "dev"
location            = "westeurope"
location_short      = "weu"
location_pair       = "northeurope"
location_pair_short = "neu"

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
cidr_vnet                         = ["10.1.0.0/16"]
cidr_subnet_k8s                   = ["10.1.0.0/17"]
cidr_subnet_appgateway            = ["10.1.128.0/24"]
cidr_subnet_postgres              = ["10.1.129.0/24"]
cidr_subnet_azdoa                 = ["10.1.130.0/24"]
cidr_subnet_redis                 = ["10.1.132.0/24"]
cidr_subnet_vpn                   = ["10.1.133.0/24"]
cidr_subnet_dns_forwarder         = ["10.1.134.0/29"]
cidr_subnet_cosmosdb_mongodb      = ["10.1.135.0/24"]
cidr_subnet_contract_storage      = ["10.1.137.0/24"]
cidr_subnet_eventhub              = ["10.1.138.0/24"]
cidr_subnet_logs_storage          = ["10.1.139.0/24"]
cidr_subnet_pnpg_cosmosdb_mongodb = ["10.1.140.0/24"] #this is a place holder for pnpg mongo
cidr_subnet_private_endpoints     = ["10.1.141.0/24"]
cidr_subnet_load_tests            = ["10.1.142.0/24"]
cidr_subnet_eventhub_rds          = ["10.1.153.0/26"]

cidr_subnet_selc      = ["10.1.148.0/23"]
cidr_subnet_selc_pnpg = ["10.1.150.0/23"]

#
# Pair VNET
#
cidr_pair_vnet                = ["10.101.0.0/16"]
cidr_subnet_pair_dnsforwarder = ["10.101.134.0/29"]

#
# AKS Platform
#
aks_platform_env              = "dev01"
vnet_aks_ddos_protection_plan = false
cidr_aks_platform_vnet        = ["10.11.0.0/16"]

# dns
dns_zone_prefix    = "dev.selfcare"
dns_zone_prefix_ar = "dev.areariservata"
external_domain    = "pagopa.it"

# storage account
public_network_access_enabled = false

# azure devops
azdo_sp_tls_cert_enabled     = true
enable_azdoa                 = true
enable_iac_pipeline          = true
enable_app_projects_pipeline = true

# app_gateway
app_gateway_api_certificate_name      = "api-dev-selfcare-pagopa-it"
app_gateway_api_pnpg_certificate_name = "api-pnpg-dev-selfcare-pagopa-it"

# redis
redis_sku_name                 = "Basic"
redis_family                   = "C"
redis_capacity                 = 0
redis_private_endpoint_enabled = false
redis_version                  = 6

# aks
aks_alerts_enabled                  = false
aks_kubernetes_version              = "1.27.7"
aks_system_node_pool_os_disk_type   = "Managed"
aks_system_node_pool_node_count_min = 1
aks_system_node_pool_node_count_max = 1

# This is the k8s ingress controller ip. It must be in the aks subnet range.
reverse_proxy_ip                = "10.1.1.250"
private_dns_name                = "selc.internal.dev.selfcare.pagopa.it"
ca_suffix_dns_private_name      = "whitemoss-eb7ef327.westeurope.azurecontainerapps.io"
ca_pnpg_suffix_dns_private_name = "victoriousfield-e39534b8.westeurope.azurecontainerapps.io"
spid_selc_path_prefix           = "/spid-login/v1"


aks_system_node_pool_vm_size                      = "Standard_B4ms"
aks_system_node_pool_only_critical_addons_enabled = true

aks_user_node_pool_enabled        = true
aks_user_node_pool_os_disk_type   = "Managed"
aks_user_node_pool_node_count_min = 1
aks_user_node_pool_node_count_max = 3
user_node_pool_node_labels = {
  "node_type" = "user"
}

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
  network_rule_set = {
    default_action  = "Deny"
    ip_rule         = []
    virtual_network = []
  }
}

# monitoring
law_sku               = "PerGB2018"
law_retention_in_days = 30
law_daily_quota_gb    = 2

# CosmosDb MongoDb
cosmosdb_mongodb_extra_capabilities               = ["EnableServerless"]
cosmosdb_mongodb_main_geo_location_zone_redundant = false

# spid-testenv
enable_spid_test = true

robots_indexed_paths = []

dns_ns_interop_selfcare = [
  "ns-774.awsdns-32.net",
  "ns-394.awsdns-49.com",
  "ns-1704.awsdns-21.co.uk",
  "ns-1091.awsdns-08.org",
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
  { // DATALAKE
    ip_mask = "18.159.227.69",
    action  = "Allow"
  },
  { // DATALAKE
    ip_mask = "3.126.198.129",
    action  = "Allow"
  },
  { // SAP
    ip_mask = "18.197.134.65",
    action  = "Allow"
  },
  { // SAP
    ip_mask = "52.29.190.137",
    action  = "Allow"
  },
  { // SAP
    ip_mask = "3.67.255.232",
    action  = "Allow"
  },
  { // SAP
    ip_mask = "3.67.182.154",
    action  = "Allow"
  },
  { // SAP
    ip_mask = "3.68.44.236",
    action  = "Allow"
  },
  { // SAP
    ip_mask = "3.66.249.150",
    action  = "Allow"
  },
  { // SAP
    ip_mask = "18.198.196.89",
    action  = "Allow"
  },
  { // SAP
    ip_mask = "18.193.21.232",
    action  = "Allow"
  },
  { // SAP
    ip_mask = "3.65.9.91",
    action  = "Allow"
  },
  { // FD
    ip_mask = "91.218.226.5",
    action  = "Allow"
  },
  { // FD
    ip_mask = "91.218.226.15",
    action  = "Allow"
  },
  { // FD
    ip_mask = "91.218.224.5",
    action  = "Allow"
  },
  { // FD
    ip_mask = "91.218.224.15",
    action  = "Allow"
  },
  { // FD
    ip_mask = "2.228.86.218",
    action  = "Allow"
  },
  # { // FD
  #   ip_mask = "193.203.230.25",
  #   action  = "Allow"
  # },
  # { // PROD-FD
  #   ip_mask = "91.218.226.15/32",
  #   action = "Allow"
  # },
  # { // PROD-FD
  #   ip_mask = "91.218.224.5/32",
  #   action = "Allow"
  # },
  # { // PROD-FD
  #   ip_mask = "91.218.224.15/32",
  #   action = "Allow"
  # },
  # { // PROD-FD
  #   ip_mask = "2.228.86.218/32",
  #   action = "Allow"
  # },
  { // KONECTA
    ip_mask = "185.170.36.80",
    action  = "Allow"
  }
]

eventhub_rds_vm = {
  size = "Standard_B1ls"
  allowed_ipaddresses = [
    "*"
  ]
}

eventhubs = [{
  name              = "SC-Contracts"
  partitions        = 30
  message_retention = 7
  consumers         = []
  iam_roles = {
    "ee71d0ec-0023-44ae-93dd-871d25ab7003" = "Azure Event Hubs Data Receiver" # io-p-sign-backoffice-func
  }
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
    },
    {
      name   = "io-sign"
      listen = true
      send   = false
      manage = false
    },
    {
      name   = "external-interceptor"
      listen = true
      send   = false
      manage = false
    },
    {
      name   = "interop"
      listen = true
      send   = false
      manage = false
    },
    {
      name   = "sma"
      listen = true
      send   = false
      manage = false
    },
    {
      name   = "conservazione"
      listen = true
      send   = false
      manage = false
    }
  ]
  }, {
  name              = "Selfcare-FD"
  partitions        = 5
  message_retention = 7
  consumers         = []
  keys = [
    {
      name   = "external-interceptor-wo"
      listen = false
      send   = true
      manage = false
    },
    {
      name   = "fd"
      listen = true
      send   = false
      manage = false
    }
  ]
  }, {
  name              = "SC-Contracts-sap"
  partitions        = 5
  message_retention = 7
  consumers         = []
  keys = [
    {
      name   = "sap"
      listen = true
      send   = false
      manage = false
      }, {
      name   = "external-interceptor-wo"
      listen = false
      send   = true
      manage = false
    }
  ]
  }, {
  name              = "SC-Users"
  partitions        = 10
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
      name   = "external-interceptor"
      listen = true
      send   = false
      manage = false
    },
    {
      name   = "sma"
      listen = true
      send   = false
      manage = false
    }
  ]
  },
  {
    name              = "SC-UserGroups"
    partitions        = 10
    message_retention = 7
    consumers         = ["io-cms-sync"]
    keys = [
      {
        name   = "selfcare-wo"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "io"
        listen = true
        send   = false
        manage = false
      }
    ]
}]
##

enable_load_tests_db = true

cae_zone_redundant      = false
cae_zone_redundant_pnpg = false
