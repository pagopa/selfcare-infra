# general

variable "prefix" {
  type    = string
  default = "selc"
  validation {
    condition = (
      length(var.prefix) <= 6
    )
    error_message = "Max length is 6 chars."
  }
}

variable "env" {
  type        = string
  description = "env directory name"
}

variable "env_short" {
  type = string
  validation {
    condition = (
      length(var.env_short) <= 1
    )
    error_message = "Max length is 1 chars."
  }
}

variable "location" {
  type    = string
  default = "westeurope"
}

variable "lock_enable" {
  type        = bool
  default     = false
  description = "Apply locks to block accedentaly deletions."
}

# Azure DevOps
variable "azdo_sp_tls_cert_enabled" {
  type        = string
  description = "Enable Azure DevOps connection for TLS cert management"
  default     = false
}

variable "tags" {
  type = map(any)
  default = {
    CreatedBy = "Terraform"
  }
}

## VPN ##
variable "vpn_sku" {
  type        = string
  default     = "VpnGw1"
  description = "VPN Gateway SKU"
}

variable "vpn_pip_sku" {
  type        = string
  default     = "Basic"
  description = "VPN GW PIP SKU"
}

## AKS ##
variable "cidr_subnet_k8s" {
  type        = list(string)
  description = "Subnet cluster kubernetes."
}

variable "aks_availability_zones" {
  type        = list(number)
  description = "A list of Availability Zones across which the Node Pool should be spread."
  default     = []
}

variable "aks_vm_size" {
  type        = string
  default     = "Standard_DS3_v2"
  description = "The size of the AKS Virtual Machine in the Node Pool."
}

variable "aks_node_count" {
  type        = number
  description = "The initial number of the AKS nodes which should exist in this Node Pool."
  default     = 1
}

variable "aks_max_pods" {
  type        = number
  description = "The maximum number of pods"
  default     = 100
}

variable "aks_enable_auto_scaling" {
  type        = bool
  description = "Should the Kubernetes Auto Scaler be enabled for this Node Pool? "
  default     = false
}

variable "aks_min_count" {
  type        = number
  description = "The minimum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000"
  default     = null
}

variable "aks_max_count" {
  type        = number
  description = "The maximum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000"
  default     = null
}

variable "aks_upgrade_settings_max_surge" {
  type        = string
  description = "The maximum number or percentage of nodes which will be added to the Node Pool size during an upgrade."
  default     = "33%"
}

variable "aks_kubernetes_version" {
  type    = string
  default = "1.21.2"
}

variable "aks_sku_tier" {
  type        = string
  description = "The SKU Tier that should be used for this Kubernetes Cluster."
  default     = "Free"
}

variable "reverse_proxy_ip" {
  type        = string
  default     = "127.0.0.1"
  description = "AKS external ip. Also the ingress-nginx-controller external ip. Value known after installing the ingress controller."
}

variable "aks_num_outbound_ips" {
  type        = number
  default     = 1
  description = "How many outbound ips allocate for AKS cluster"
}

variable "aks_metric_alerts" {
  description = <<EOD
Map of name = criteria objects
EOD

  type = map(object({
    # criteria.*.aggregation to be one of [Average Count Minimum Maximum Total]
    aggregation = string
    # "Insights.Container/pods" "Insights.Container/nodes"
    metric_namespace = string
    metric_name      = string
    # criteria.0.operator to be one of [Equals NotEquals GreaterThan GreaterThanOrEqual LessThan LessThanOrEqual]
    operator  = string
    threshold = number
    # Possible values are PT1M, PT5M, PT15M, PT30M and PT1H
    frequency = string
    # Possible values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D.
    window_size = string

    dimension = list(object(
      {
        name     = string
        operator = string
        values   = list(string)
      }
    ))
  }))

  default = {
    node_cpu = {
      aggregation      = "Average"
      metric_namespace = "Insights.Container/nodes"
      metric_name      = "cpuUsagePercentage"
      operator         = "GreaterThan"
      threshold        = 80
      frequency        = "PT1M"
      window_size      = "PT5M"
      dimension = [
        {
          name     = "host"
          operator = "Include"
          values   = ["*"]
        }
      ],
    }
    node_memory = {
      aggregation      = "Average"
      metric_namespace = "Insights.Container/nodes"
      metric_name      = "memoryWorkingSetPercentage"
      operator         = "GreaterThan"
      threshold        = 80
      frequency        = "PT1M"
      window_size      = "PT5M"
      dimension = [
        {
          name     = "host"
          operator = "Include"
          values   = ["*"]
        }
      ],
    }
    node_disk = {
      aggregation      = "Average"
      metric_namespace = "Insights.Container/nodes"
      metric_name      = "DiskUsedPercentage"
      operator         = "GreaterThan"
      threshold        = 80
      frequency        = "PT1M"
      window_size      = "PT5M"
      dimension = [
        {
          name     = "host"
          operator = "Include"
          values   = ["*"]
        },
        {
          name     = "device"
          operator = "Include"
          values   = ["*"]
        }
      ],
    }
    node_not_ready = {
      aggregation      = "Average"
      metric_namespace = "Insights.Container/nodes"
      metric_name      = "nodesCount"
      operator         = "GreaterThan"
      threshold        = 0
      frequency        = "PT1M"
      window_size      = "PT5M"
      dimension = [
        {
          name     = "status"
          operator = "Include"
          values   = ["NotReady"]
        }
      ],
    }
    pods_failed = {
      aggregation      = "Average"
      metric_namespace = "Insights.Container/pods"
      metric_name      = "podCount"
      operator         = "GreaterThan"
      threshold        = 0
      frequency        = "PT1M"
      window_size      = "PT5M"
      dimension = [
        {
          name     = "phase"
          operator = "Include"
          values   = ["Failed"]
        }
      ]
    }
    pods_ready = {
      aggregation      = "Average"
      metric_namespace = "Insights.Container/pods"
      metric_name      = "PodReadyPercentage"
      operator         = "LessThan"
      threshold        = 80
      frequency        = "PT1M"
      window_size      = "PT5M"
      dimension = [
        {
          name     = "kubernetes namespace"
          operator = "Include"
          values   = ["*"]
        },
        {
          name     = "controllerName"
          operator = "Include"
          values   = ["*"]
        }
      ]
    }
    container_cpu = {
      aggregation      = "Average"
      metric_namespace = "Insights.Container/containers"
      metric_name      = "cpuExceededPercentage"
      operator         = "GreaterThan"
      threshold        = 95
      frequency        = "PT1M"
      window_size      = "PT5M"
      dimension = [
        {
          name     = "kubernetes namespace"
          operator = "Include"
          values   = ["*"]
        },
        {
          name     = "controllerName"
          operator = "Include"
          values   = ["*"]
        }
      ]
    }
    container_memory = {
      aggregation      = "Average"
      metric_namespace = "Insights.Container/containers"
      metric_name      = "memoryWorkingSetExceededPercentage"
      operator         = "GreaterThan"
      threshold        = 95
      frequency        = "PT1M"
      window_size      = "PT5M"
      dimension = [
        {
          name     = "kubernetes namespace"
          operator = "Include"
          values   = ["*"]
        },
        {
          name     = "controllerName"
          operator = "Include"
          values   = ["*"]
        }
      ]
    }
    container_oom = {
      aggregation      = "Average"
      metric_namespace = "Insights.Container/pods"
      metric_name      = "oomKilledContainerCount"
      operator         = "GreaterThan"
      threshold        = 0
      frequency        = "PT1M"
      window_size      = "PT1M"
      dimension = [
        {
          name     = "kubernetes namespace"
          operator = "Include"
          values   = ["*"]
        },
        {
          name     = "controllerName"
          operator = "Include"
          values   = ["*"]
        }
      ]
    }
    container_restart = {
      aggregation      = "Average"
      metric_namespace = "Insights.Container/pods"
      metric_name      = "restartingContainerCount"
      operator         = "GreaterThan"
      threshold        = 0
      frequency        = "PT1M"
      window_size      = "PT1M"
      dimension = [
        {
          name     = "kubernetes namespace"
          operator = "Include"
          values   = ["*"]
        },
        {
          name     = "controllerName"
          operator = "Include"
          values   = ["*"]
        }
      ]
    }
  }
}

variable "aks_alerts_enabled" {
  type        = bool
  default     = true
  description = "Aks alert enabled?"
}

## Monitor
variable "law_sku" {
  type        = string
  description = "Sku of the Log Analytics Workspace"
  default     = "PerGB2018"
}

variable "law_retention_in_days" {
  type        = number
  description = "The workspace data retention in days"
  default     = 30
}

variable "law_daily_quota_gb" {
  type        = number
  description = "The workspace daily quota for ingestion in GB."
  default     = -1
}

# api_config

variable "api_config_enabled" {
  type        = bool
  description = "Api Config enabled"
  default     = false
}

variable "cidr_subnet_api_config" {
  type        = list(string)
  description = "Address prefixes subnet api config"
  default     = null
}

# Network
variable "cidr_vnet" {
  type        = list(string)
  description = "Virtual network address space."
}

variable "cidr_subnet_apim" {
  type        = list(string)
  description = "Address prefixes subnet api management."
  default     = null
}

variable "cidr_subnet_appgateway" {
  type        = list(string)
  description = "Application gateway address space."
}

variable "cidr_subnet_vpn" {
  type        = list(string)
  description = "VPN network address space."
}

variable "cidr_subnet_dns_forwarder" {
  type        = list(string)
  description = "DNS Forwarder network address space."
}

variable "cidr_subnet_cosmosdb_mongodb" {
  type        = list(string)
  description = "Application gateway address space."
}

variable "cidr_subnet_postgres" {
  type        = list(string)
  description = "Database network address space."
}

variable "cidr_subnet_contract_storage" {
  type        = list(string)
  description = "Contracts storage address space."
}

# DNS
variable "dns_default_ttl_sec" {
  type        = number
  description = "value"
  default     = 3600
}

variable "external_domain" {
  type        = string
  default     = "pagopa.it"
  description = "Domain for delegation"
}

variable "dns_zone_prefix" {
  type        = string
  default     = "selfcare"
  description = "The dns subdomain."
}

# apim
variable "apim_publisher_name" {
  type = string
}

variable "apim_sku" {
  type = string
}

# cdn
variable "azuread_service_principal_azure_cdn_frontdoor_id" {
  type        = string
  description = "Azure CDN Front Door Principal ID"
  # this is the deafult value for tenant pagopa.it
  default = "f3b3f72f-4770-47a5-8c1e-aa298003be12"
}

## Redis cache
variable "redis_capacity" {
  type    = number
  default = 1
}

variable "redis_sku_name" {
  type    = string
  default = "Standard"
}

variable "redis_family" {
  type    = string
  default = "C"
}

variable "redis_private_endpoint_enabled" {
  type    = bool
  default = true
}

variable "cidr_subnet_redis" {
  type        = list(string)
  description = "Redis network address space."
  default     = []
}

variable "app_gateway_api_certificate_name" {
  type        = string
  description = "Application gateway api certificate name on Key Vault"
}

variable "app_gateway_sku_name" {
  type        = string
  description = "SKU Name of the App GW"
  default     = "Standard_v2"
}

variable "app_gateway_sku_tier" {
  type        = string
  description = "SKU tier of the App GW"
  default     = "Standard_v2"
}

variable "app_gateway_alerts_enabled" {
  type        = bool
  description = "Enable alerts"
  default     = false
}

variable "app_gateway_waf_enabled" {
  type        = bool
  description = "Enable WAF"
  default     = false
}

# Scaling

variable "app_gateway_min_capacity" {
  type    = number
  default = 0
}

variable "app_gateway_max_capacity" {
  type    = number
  default = 2
}

# Azure DevOps Agent
variable "enable_azdoa" {
  type        = bool
  description = "Enable Azure DevOps agent."
}

variable "cidr_subnet_azdoa" {
  type        = list(string)
  description = "Azure DevOps agent network address space."
}

variable "enable_iac_pipeline" {
  type        = bool
  description = "If true create the key vault policy to allow used by azure devops iac pipelines."
  default     = false
}

# CosmosDb Mongo
variable "cosmosdb_mongodb_offer_type" {
  type        = string
  description = "Specifies the Offer Type to use for this CosmosDB Account - currently this can only be set to Standard"
  default     = "Standard"
}

variable "cosmosdb_mongodb_enable_free_tier" {
  type        = bool
  description = "Enable Free Tier pricing option for this Cosmos DB account"
  default     = true
}

variable "cosmosdb_mongodb_public_network_access_enabled" {
  type        = bool
  description = "Whether or not public network access is allowed for this CosmosDB account"
  default     = false
}

variable "cosmosdb_mongodb_consistency_policy" {
  type = object({
    consistency_level       = string
    max_interval_in_seconds = number
    max_staleness_prefix    = number
  })

  default = {
    consistency_level       = "Session"
    max_interval_in_seconds = null
    max_staleness_prefix    = null
  }
}

variable "cosmosdb_mongodb_main_geo_location_zone_redundant" {
  type        = bool
  description = "Enable zone redundant Comsmos DB"
}

variable "cosmosdb_mongodb_additional_geo_locations" {
  type = list(object({
    location          = string
    failover_priority = number
    zone_redundant    = bool
  }))
  description = "The name of the Azure region to host replicated data and the priority to apply starting from 1. Not used when cosmosdb_mongodb_enable_serverless"
  default     = []
}

variable "cosmosdb_mongodb_throughput" {
  type        = number
  description = "The throughput of the MongoDB database (RU/s). Must be set in increments of 100. The minimum value is 400. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply."
  default     = 400
}

variable "cosmosdb_mongodb_enable_autoscaling" {
  type        = bool
  description = "It will enable autoscaling mode. If true, cosmosdb_mongodb_throughput must be unset"
  default     = false
}

variable "cosmosdb_mongodb_max_throughput" {
  type        = number
  description = "The maximum throughput of the MongoDB database (RU/s). Must be between 4,000 and 1,000,000. Must be set in increments of 1,000. Conflicts with throughput"
  default     = 4000
}

variable "cosmosdb_mongodb_extra_capabilities" {
  type        = list(string)
  default     = []
  description = "Enable cosmosdb extra capabilities"
}

variable "cosmosdb_mongodb_private_endpoint_enabled" {
  type        = bool
  description = "Enable private endpoint for Comsmos DB"
  default     = true
}

## Database server postgresl
variable "postgres_sku_name" {
  type        = string
  description = "Specifies the SKU Name for this PostgreSQL Server."
}

variable "postgres_geo_redundant_backup_enabled" {
  type        = bool
  default     = false
  description = "Turn Geo-redundant server backups on/off."
}

variable "postgres_enable_replica" {
  type        = bool
  default     = false
  description = "Create a PostgreSQL Server Replica."
}

variable "postgres_storage_mb" {
  type        = number
  description = "Max storage allowed for a server"
  default     = 5120
}

variable "postgres_configuration" {
  type        = map(string)
  description = "PostgreSQL Server configuration"
  default     = {}
}

variable "postgres_alerts_enabled" {
  type        = bool
  default     = false
  description = "Database alerts enabled?"
}

variable "postgres_network_rules" {
  type = object({
    ip_rules                       = list(string)
    allow_access_to_azure_services = bool
  })
  default = {
    ip_rules = []
    # dblink
    allow_access_to_azure_services = true
  }
  description = "Database network rules"
}

variable "postgres_replica_network_rules" {
  type = object({
    ip_rules                       = list(string)
    allow_access_to_azure_services = bool
  })
  default = {
    ip_rules = []
    # dblink
    allow_access_to_azure_services = true
  }
  description = "Database network rules"
}

variable "postgres_metric_alerts" {
  description = <<EOD
Map of name = criteria objects, see these docs for options
https://docs.microsoft.com/en-us/azure/azure-monitor/platform/metrics-supported#microsoftdbforpostgresqlservers
https://docs.microsoft.com/en-us/azure/postgresql/concepts-limits#maximum-connections
EOD

  type = map(object({
    # criteria.*.aggregation to be one of [Average Count Minimum Maximum Total]
    aggregation = string
    metric_name = string
    # criteria.0.operator to be one of [Equals NotEquals GreaterThan GreaterThanOrEqual LessThan LessThanOrEqual]
    operator  = string
    threshold = number
    # Possible values are PT1M, PT5M, PT15M, PT30M and PT1H
    frequency = string
    # Possible values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D.
    window_size = string

    dimension = list(object(
      {
        name     = string
        operator = string
        values   = list(string)
      }
    ))
  }))

  default = {
    cpu = {
      aggregation = "Average"
      metric_name = "cpu_percent"
      operator    = "GreaterThan"
      threshold   = 70
      frequency   = "PT1M"
      window_size = "PT5M"
      dimension   = []
    }
    memory = {
      aggregation = "Average"
      metric_name = "memory_percent"
      operator    = "GreaterThan"
      threshold   = 75
      frequency   = "PT1M"
      window_size = "PT5M"
      dimension   = []
    }
    io = {
      aggregation = "Average"
      metric_name = "io_consumption_percent"
      operator    = "GreaterThan"
      threshold   = 55
      frequency   = "PT1M"
      window_size = "PT5M"
      dimension   = []
    }
    # https://docs.microsoft.com/it-it/azure/postgresql/concepts-limits
    # GP_Gen5_2 -| 145 / 100 * 80 = 116
    # GP_Gen5_32 -| 1495 / 100 * 80 = 1196
    max_active_connections = {
      aggregation = "Average"
      metric_name = "active_connections"
      operator    = "GreaterThan"
      threshold   = 1196
      frequency   = "PT5M"
      window_size = "PT5M"
      dimension   = []
    }
    min_active_connections = {
      aggregation = "Average"
      metric_name = "active_connections"
      operator    = "LessThanOrEqual"
      threshold   = 0
      frequency   = "PT5M"
      window_size = "PT15M"
      dimension   = []
    }
    failed_connections = {
      aggregation = "Total"
      metric_name = "connections_failed"
      operator    = "GreaterThan"
      threshold   = 10
      frequency   = "PT5M"
      window_size = "PT15M"
      dimension   = []
    }
    replica_lag = {
      aggregation = "Average"
      metric_name = "pg_replica_log_delay_in_seconds"
      operator    = "GreaterThan"
      threshold   = 60
      frequency   = "PT1M"
      window_size = "PT5M"
      dimension   = []
    }
  }
}

# spid-testenv
variable "enable_spid_test" {
  type        = bool
  description = "to provision italia/spid-testenv2:1.1.0"
  default     = false
}

# Single Page Applications
variable "spa" {
  type        = list(string)
  description = "spa root dirs"
  default = [
    "auth",
    "onboarding",
    "dashboard"
  ]
}
# contracts storage
variable "contracts_account_replication_type" {
  type        = string
  description = "Contracts replication type"
  default     = "LRS"
}

variable "contracts_delete_retention_days" {
  type        = number
  description = "Number of days to retain deleted contracts"
  default     = 1
}

variable "contracts_enable_versioning" {
  type        = bool
  description = "Enable contract versioning"
  default     = false
}

variable "contracts_advanced_threat_protection" {
  type        = bool
  description = "Enable contract threat advanced protection"
  default     = false
}

variable "robots_indexed_paths" {
  type        = list(string)
  description = "List of cdn paths to allow robots index"
}

variable "allowedOrigins" {
  type        = list(string)
  description = "List of origins allowed to access to CDN cors configured paths"
}
