# general

locals {
  project      = "${var.prefix}-${var.env_short}"
  project_pair = "${var.prefix}-${var.env_short}-${var.location_pair_short}"

  aks_system_node_pool_node_name = replace("${local.project}sys", "-", "")
  aks_user_node_pool_node_name   = replace("${local.project}usr", "-", "")

  # NAT
  nat_rg_name = "${local.project}-nat-rg"

  internal_selfcare_private_domain = var.env_short == "p" ? "internal.selfcare.pagopa.it" : "internal.${var.env}.selfcare.pagopa.it"

  # Monitor
  action_group_selfcare_dev_name = "selcdev"
  action_group_selfcare_uat_name = "selcuat"

  aks_cluster_name = "${local.project}-aks"

  alert_functions_exceptions_name       = "functions-exception"
  alert_functions_exceptions_role_names = ["selc-${var.env_short}-onboarding-fn"]

  # Private DNS
  container_app_environment_dns_zone_name = "azurecontainerapps.io"
  container_app_resource_group_name       = "container-app-rg"

  app_name_fn = "${local.project}-onboarding-fn"
}


variable "cidr_pair_vnet" {
  type        = list(string)
  description = "Virtual network address space."
}

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

variable "location_pair" {
  type        = string
  description = "Pair (Secondary) location region (e.g. northeurope)"
}

variable "location_short" {
  type        = string
  description = "Primary location in short form (e.g. westeurope=weu)"
}

variable "location_pair_short" {
  type        = string
  description = "Pair (Secondary) location in short form (e.g. northeurope=neu)"
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

variable "cidr_aks_platform_vnet" {
  type        = list(string)
  description = "vnet for aks platform."
}

variable "cidr_subnet_pair_dnsforwarder" {
  type        = list(string)
  description = "DNS Forwarder network address space."
}

# Azure Distributed denial of service (DDoS) Protection plan
variable "ddos_protection_plan" {
  type = object({
    id     = string
    enable = bool
  })

  default = null
}

variable "vnet_aks_ddos_protection_plan" {
  type        = bool
  description = "vnet enable ddos protection plan"
}

variable "aks_system_node_pool_vm_size" {
  type        = string
  default     = "Standard_DS3_v2"
  description = "The size of the AKS Virtual Machine in the Node Pool."
}

variable "aks_system_node_pool_os_disk_type" {
  type        = string
  description = "(Required) The type of disk which should be used for the Operating System. Possible values are Ephemeral and Managed. Defaults to Managed."
}

variable "aks_system_node_pool_os_disk_size_gb" {
  type        = number
  default     = null
  description = "(Optional) The size of the OS Disk which should be used for each agent in the Node Pool. Changing this forces a new resource to be created."
}

variable "aks_system_node_pool_node_count_min" {
  type        = number
  description = "The minimum number of nodes which should exist in this Node Pool. Between 1 and 1000"
}

variable "aks_system_node_pool_node_count_max" {
  type        = number
  description = "The maximum number of nodes which should exist in this Node Pool. Between 1 and 1000"
}

variable "aks_system_node_pool_only_critical_addons_enabled" {
  type        = bool
  description = "(Optional) Enabling this option will taint default node pool with CriticalAddonsOnly=true:NoSchedule taint. Changing this forces a new resource to be created."
  default     = true
}

variable "system_node_pool_enable_host_encryption" {
  type        = bool
  description = "(Optional) Should the nodes in the Default Node Pool have host encryption enabled? Defaults to true."
  default     = true
}

#
# User Node Pool
#
variable "user_node_pool_node_labels" {
  type        = map(string)
  description = "(Optional) A map of Kubernetes labels which should be applied to nodes in the Default Node Pool. Changing this forces a new resource to be created."
  default     = {}
}

variable "aks_user_node_pool_enabled" {
  type        = bool
  default     = false
  description = "Is user node pool enabled?"
}

variable "aks_user_node_pool_os_disk_type" {
  type        = string
  description = "(Optional) The type of disk which should be used for the Operating System. Possible values are Ephemeral and Managed. Defaults to Managed."
  default     = "Managed"
}

variable "aks_user_node_pool_vm_size" {
  type        = string
  default     = "Standard_DS3_v2"
  description = "The size of the AKS Virtual Machine in the Node Pool."
}

variable "aks_user_node_pool_os_disk_size_gb" {
  type        = number
  default     = null
  description = "(Optional) The size of the OS Disk which should be used for each agent in the Node Pool. Changing this forces a new resource to be created."
}

variable "aks_user_node_pool_node_count_min" {
  type        = number
  description = "The minimum number of nodes which should exist in this Node Pool. Between 1 and 1000"
  default     = 1
}

variable "aks_user_node_pool_node_count_max" {
  type        = number
  description = "The maximum number of nodes which should exist in this Node Pool. Between 1 and 1000"
  default     = 1
}

variable "aks_upgrade_settings_max_surge" {
  type        = string
  description = "The maximum number or percentage of nodes which will be added to the Node Pool size during an upgrade."
  default     = "33%"
}

variable "aks_kubernetes_version" {
  type        = string
  description = "Kubernetes version for AKS"
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

variable "private_dns_name" {
  type        = string
  description = "AKS private DNS record"
}

variable "ca_suffix_dns_private_name" {
  type        = string
  description = "CA suffix private DNS record"
}

variable "ca_pnpg_suffix_dns_private_name" {
  type        = string
  description = "CA PNPG suffix private DNS record"
}

variable "spid_selc_path_prefix" {
  type        = string
  description = "Path prefix to hub spid login"
  default     = "/spid/v1"
}

variable "spid_pnpg_path_prefix" {
  type        = string
  description = "Path prefix to hub spid login"
  default     = "/spid/v1"
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

variable "cidr_subnet_eventhub" {
  type        = list(string)
  description = "EventHub address space."
}

variable "cidr_subnet_eventhub_rds" {
  type        = list(string)
  description = "EventHub rds vm address space."
}

variable "cidr_subnet_logs_storage" {
  type        = list(string)
  description = "Logs storage address space."
}

variable "cidr_subnet_private_endpoints" {
  type        = list(string)
  description = "private endpoints address space."
}

# DNS
variable "dns_default_ttl_sec" {
  type        = number
  description = "value"
  default     = 3600
}

variable "dns_ns_interop_selfcare" {
  type        = list(string)
  description = "value"
  default     = null
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

variable "dns_zone_prefix_ar" {
  type        = string
  default     = "areariservat"
  description = "The dns subdomain."
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

variable "redis_version" {
  type    = number
  default = 6
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
  description = "Application gateway: api certificate name on Key Vault"
}

variable "app_gateway_api_pnpg_certificate_name" {
  type        = string
  description = "Application gateway: api-pnpg certificate name on Key Vault"
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

variable "enable_app_projects_pipeline" {
  type        = bool
  description = "If true create the key vault policy to allow used by azure devops app projects pipelines."
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

variable "public_network_access_enabled" {
  description = "Enable or Disable public access. It should always set to false unless there are special needs"
  type        = bool
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
# logs storage
variable "logs_account_replication_type" {
  type        = string
  description = "logs replication type"
  default     = "LRS"
}

variable "logs_delete_retention_days" {
  type        = number
  description = "Number of days to retain deleted logs"
  default     = 1
}

variable "logs_enable_versioning" {
  type        = bool
  description = "Enable logs versioning"
  default     = false
}

variable "logs_advanced_threat_protection" {
  type        = bool
  description = "Enable logs threat advanced protection"
  default     = false
}

## Event hub
variable "eventhub_sku_name" {
  type        = string
  description = "Defines which tier to use."
  default     = "Basic"
}

variable "eventhub_capacity" {
  type        = number
  description = "Specifies the Capacity / Throughput Units for a Standard SKU namespace."
  default     = null
}

variable "eventhub_maximum_throughput_units" {
  type        = number
  description = "Specifies the maximum number of throughput units when Auto Inflate is Enabled"
  default     = null
}

variable "eventhub_auto_inflate_enabled" {
  type        = bool
  description = "Is Auto Inflate enabled for the EventHub Namespace?"
  default     = false
}

variable "eventhub_zone_redundant" {
  type        = bool
  description = "Specifies if the EventHub Namespace should be Zone Redundant (created across Availability Zones)."
  default     = false
}

variable "eventhub_ip_rules" {
  description = "eventhub network rules"
  type = list(object({
    ip_mask = string
    action  = string
  }))
  default = []
}

variable "eventhubs" {
  description = "A list of event hub topics to add to namespace."
  type = list(object({
    name              = string
    partitions        = number
    message_retention = number
    consumers         = list(string)
    keys = list(object({
      name   = string
      listen = bool
      send   = bool
      manage = bool
    }))
    iam_roles = optional(map(string), {})
  }))
  default = []
}

variable "eventhub_alerts_enabled" {
  type        = bool
  default     = false
  description = "Event hub alerts enabled?"
}

variable "eventhub_metric_alerts" {
  default = {}

  description = <<EOD
Map of name = criteria objects
EOD

  type = map(object({
    # criteria.*.aggregation to be one of [Average Count Minimum Maximum Total]
    aggregation = string
    metric_name = string
    description = string
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
}

variable "eventhub_rds_vm" {
  type = object({
    size                = string
    allowed_ipaddresses = list(string)
  })
}

##

variable "docker_registry" {
  description = "ACR docker registry configuration"
  type = object({
    sku                     = string
    zone_redundancy_enabled = bool
    geo_replication = object({
      enabled                   = bool
      regional_endpoint_enabled = bool
      zone_redundancy_enabled   = bool
    })
    network_rule_set = object({
      default_action  = string
      ip_rule         = list(any)
      virtual_network = list(any)
    })
  })
}

variable "aks_platform_env" {
  type        = string
  description = "The env name used into aks platform folder. E.g: dev01"
}

variable "enable_load_tests_db" {
  type        = bool
  description = "To provision load tests db"
}

variable "cidr_subnet_load_tests" {
  type        = list(string)
  description = "private endpoints address space."
}


variable "azdo_agent_vm_sku" {
  type        = string
  description = "sku of the azdo agent vm"
  default     = "Standard_B1s"
}


variable "checkout_advanced_threat_protection_enabled" {
  type        = string
  description = "Enable checkout threat advanced protection"
  default     = false
}

variable "k8s_kube_config_path_prefix" {
  type    = string
  default = "~/.kube"
}

variable "cidr_subnet_selc" {
  type        = list(string)
  description = "Address prefixes subnet selc ca and functions"
  default     = null
}

variable "cidr_subnet_selc_pnpg" {
  type        = list(string)
  description = "Address prefixes subnet selc ca and functions"
  default     = null
}

# Container App

variable "cae_zone_redundant" {
  type        = bool
  description = "Container App Environment zone redudancy"
}

variable "cae_zone_redundant_pnpg" {
  type        = bool
  description = "Container App Environment zone redudancy"
}
