locals {
  product = "${var.prefix}-${var.env_short}"
  project = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"

  vnet_core_name                = "${local.product}-vnet"
  vnet_core_resource_group_name = "${local.product}-vnet-rg"
  private_endpoint_subnet_name  = "${local.product}-private-endpoints-snet"

  container_registry_common_name    = "${local.project}-common-acr"
  rg_container_registry_common_name = "${local.project}-docker-rg"
}

variable "prefix" {
  type = string
  validation {
    condition = (
      length(var.prefix) <= 6
    )
    error_message = "Max length is 6 chars."
  }
}

variable "env" {
  type = string
}

variable "env_short" {
  type = string
  validation {
    condition = (
      length(var.env_short) == 1
    )
    error_message = "Length must be 1 chars."
  }
}

variable "domain" {
  type = string
  validation {
    condition = (
      length(var.domain) <= 12
    )
    error_message = "Max length is 12 chars."
  }
}

variable "location" {
  type        = string
  description = "One of westeurope, northeurope"
}

variable "location_short" {
  type = string
  validation {
    condition = (
      length(var.location_short) == 3
    )
    error_message = "Length must be 3 chars."
  }
  description = "One of wue, neu"
}

variable "instance" {
  type        = string
  description = "One of beta, prod01, prod02"
}

variable "tags" {
  type = map(any)
  default = {
    CreatedBy = "Terraform"
  }
}

# DNS
variable "external_domain" {
  type        = string
  description = "Domain for delegation. E.g pagopa.it"
}

variable "dns_zone_prefix" {
  type        = string
  description = "The dns subdomain. E.g: selfcare"
}


variable "monitor_resource_group_name" {
  type        = string
  description = "Monitor resource group name"
}
variable "log_analytics_workspace_name" {
  type        = string
  description = "Specifies the name of the Log Analytics Workspace."
}
variable "log_analytics_workspace_resource_group_name" {
  type        = string
  description = "The name of the resource group in which the Log Analytics workspace is located in."
}

variable "cidr_subnet_pnpg_cosmosdb_mongodb" {
  type        = list(string)
  description = "Cosmosdb pnpg address space."
}

# CosmosDb Mongo
variable "cosmosdb_mongodb_offer_type" {
  type        = string
  description = "Specifies the Offer Type to use for this CosmosDB Account - currently this can only be set to Standard"
}

variable "cosmosdb_mongodb_enable_free_tier" {
  type        = bool
  description = "Enable Free Tier pricing option for this Cosmos DB account"
  default     = false
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

#
# CDN
#
variable "spa" {
  type        = list(string)
  description = "spa root dirs"
  default = [
    "auth",
    "onboarding-pnpg",
    "dashboard"
  ]
}

variable "robots_indexed_paths" {
  type        = list(string)
  description = "List of cdn paths to allow robots index"
}

#
# Storage logs
#
variable "logs_account_replication_type" {
  type        = string
  description = "logs replication type"
}

variable "logs_delete_retention_days" {
  type        = number
  description = "Number of days to retain deleted logs"
}

variable "logs_enable_versioning" {
  type        = bool
  description = "Enable logs versioning"
}

variable "logs_advanced_threat_protection" {
  type        = bool
  description = "Enable logs threat advanced protection"
  default     = false
}
