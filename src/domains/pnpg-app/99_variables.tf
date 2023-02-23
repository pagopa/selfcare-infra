locals {
  product = "${var.prefix}-${var.env_short}"
  project = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"

  key_vault_name                  = "${local.product}-${var.domain}-kv"
  key_vault_resource_group        = "${local.product}-${var.domain}-sec-rg"

  # redis_url                       = "${format("%s-redis", local.project)}.redis.cache.windows.net"
  # postgres_hostname               = "${format("%s-postgresql", local.project)}.postgres.database.azure.com"
  # postgres_replica_hostname       = var.enable_postgres_replica ? "${format("%s-postgresql-rep", local.project)}.postgres.database.azure.com" : local.postgres_hostname
  mongodb_name_selc_product       = "selcProduct"
  mongodb_name_selc_user_group    = "selcUserGroup"
  # contracts_storage_account_name  = replace(format("%s-contracts-storage", local.project), "-", "")
  # contracts_storage_container     = format("%s-contracts-blob", local.project)
  appinsights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  aks_cluster_name = var.aks_name
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

variable "location_string" {
  type        = string
  description = "One of West Europe, North Europe"
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

### External resources

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

### Aks

variable "aks_name" {
  type        = string
  description = "AKS cluster name"
}

variable "aks_resource_group_name" {
  type        = string
  description = "AKS cluster resource name"

}

variable "k8s_kube_config_path_prefix" {
  type    = string
  default = "~/.kube"
}

variable "ingress_load_balancer_ip" {
  type = string
}

variable "ingress_load_balancer_hostname" {
  type = string
}

# DNS
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

variable "dns_zone_internal_prefix" {
  type        = string
  default     = null
  description = "The dns subdomain."
}

#
# Tls Checker
#
variable "tls_cert_check_helm" {
  type = object({
    chart_version = string,
    image_name    = string,
    image_tag     = string
  })
  description = "tls cert helm chart configuration"
}

variable "reloader_helm" {
  type = object({
    chart_version = string,
    image_name    = string,
    image_tag     = string
  })
  description = "reloader helm chart configuration"
}

#
# RTD reverse proxy
#
variable "reverse_proxy_rtd" {
  type        = string
  default     = "127.0.0.1"
  description = "AKS external ip. Also the ingress-nginx-controller external ip. Value known after installing the ingress controller."
}

#
# ConfigMaps & Secrets
#
variable "configmaps_ms_core" {
  type = map(string)
}

variable "configmaps_common" {
  type = map(string)
}

variable "aruba_sign_service" {
  type = map(string)
}

variable "geo-taxonomies" {
  type = map(string)
}

variable "api_gateway_url" {
  type = string
}

variable "default_service_port" {
  type    = number
  default = 8080
}
