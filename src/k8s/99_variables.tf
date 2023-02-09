locals {
  project                         = format("%s-%s", var.prefix, var.env_short)

  key_vault_name                  = format("%s-kv", local.project)
  key_vault_resource_group        = format("%s-sec-rg", local.project)
  key_vault_id                    = "${data.azurerm_subscription.current.id}/resourceGroups/${local.key_vault_resource_group}/providers/Microsoft.KeyVault/vaults/${local.key_vault_name}"
  
  redis_url                       = "${format("%s-redis", local.project)}.redis.cache.windows.net"
  
  postgres_hostname               = "${format("%s-postgresql", local.project)}.postgres.database.azure.com"
  postgres_replica_hostname       = var.enable_postgres_replica ? "${format("%s-postgresql-rep", local.project)}.postgres.database.azure.com" : local.postgres_hostname
  
  mongodb_name_selc_product       = "selcProduct"
  mongodb_name_selc_user_group    = "selcUserGroup"
  
  contracts_storage_account_name  = replace(format("%s-contracts-storage", local.project), "-", "")
  contracts_storage_container     = format("%s-contracts-blob", local.project)
  
  appinsights_instrumentation_key = format("InstrumentationKey=%s", module.key_vault_secrets_query.values["appinsights-instrumentation-key"].value)

  # DOMAINS
  system_domain_namespace = kubernetes_namespace.system_domain_namespace.metadata[0].name
  domain_namespace        = kubernetes_namespace.domain_namespace.metadata[0].name
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


variable "aks_name" {
  type = string
  description = "AKS Name"
}

variable "aks_resource_group_name" {
  type = string
  description = "AKS resource group name"
}

variable "k8s_kube_config_path" {
  type    = string
  default = "~/.kube/config"
}

variable "k8s_kube_config_path_prefix" {
  type    = string
  default = "~/.kube"
}

# variable "k8s_apiserver_host" {
#   type = string
# }

variable "k8s_apiserver_port" {
  type    = number
  default = 443
}

variable "k8s_apiserver_insecure" {
  type    = bool
  default = false
}

variable "rbac_namespaces" {
  type    = list(string)
  default = ["selc"]
}

# ingress

variable "ingress_replica_count" {
  type = string
}

variable "ingress_load_balancer_ip" {
  type = string
}

variable "default_service_port" {
  type    = number
  default = 8080
}

# gateway
variable "api_gateway_url" {
  type = string
}
variable "cdn_frontend_url" {
  type = string
}
variable "cdn_storage_url" {
  type = string
}
variable "spid_testenv_url" {
  type    = string
  default = null
}

variable "enable_postgres_replica" {
  type        = bool
  default     = false
  description = "Enable connection to postgres replica"
}

# uservice versions
variable "api-version_uservice-party-management" {
  type = string
}

variable "api-version_uservice-party-process" {
  type = string
}

variable "api-version_uservice-party-registry-proxy" {
  type = string
}

#tfsec:ignore:general-secrets-no-plaintext-exposure
variable "jwt_token_exchange_duration" {
  type    = string
  default = "PT15S"
}

# configs/secrets
variable "jwt_audience" {
  type = string
}

variable "jwt_social_expire" {
  type = string
}

variable "token_expiration_minutes" {
  type    = number
  default = 540 # 9 hours
}

variable "configmaps_hub-spid-login-ms" {
  type = map(string)
}

variable "configmaps_common" {
  type = map(string)
}

variable "configmaps_ms_core" {
  type = map(string)
}

variable "aruba_sign_service" {
  type = map(string)
}

variable "geo-taxonomies" {
  type = map(string)
}
