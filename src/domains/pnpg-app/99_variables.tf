locals {
  product = "${var.prefix}-${var.env_short}"
  project = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"

  app_name_fn = "${local.product}-pnpg-onboarding-fn"

  key_vault_name           = "${local.product}-${var.domain}-kv"
  key_vault_resource_group = "${local.product}-${var.domain}-sec-rg"

  redis_url = "selc-${var.env_short}-${var.location_short}-pnpg-redis.redis.cache.windows.net"

  mongodb_name_selc_core          = "selcMsCore"
  mongodb_name_selc_user_group    = "selcUserGroup"
  contracts_storage_account_name  = replace("${local.project}-contracts-storage", "-", "")
  contracts_storage_container     = "${local.project}-contracts-blob"
  appinsights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  monitor_appinsights_name           = "${local.product}-appinsights"
  monitor_action_group_slack_name    = "SlackPagoPA"
  monitor_action_group_email_name    = "PagoPA"
  monitor_action_group_opsgenie_name = "Opsgenie"
  alert_action_group_domain_name     = "${var.prefix}${var.env_short}${var.domain}"

  ingress_hostname_prefix               = "${var.instance}.${var.domain}"
  internal_dns_zone_name                = "${var.dns_zone_internal_prefix}.${var.external_domain}"
  internal_dns_zone_resource_group_name = "${local.product}-vnet-rg"

  acr_name                = replace("${local.product}commonacr", "-", "")
  acr_resource_group_name = "${local.product}-container-registry-rg"

  aks_cluster_name        = var.aks_name
  aks_name                = var.aks_name
  aks_resource_group_name = var.aks_resource_group_name
  domain_aks_hostname     = var.env == "prod" ? "${var.instance}.${var.domain}.internal.selfcare.pagopa.it" : "${var.instance}.${var.domain}.internal.${var.env}.selfcare.pagopa.it"

  vnet_core_name                = "${local.product}-vnet"
  vnet_core_resource_group_name = "${local.product}-vnet-rg"
  # DOMAINS
  system_domain_namespace = kubernetes_namespace.system_domain_namespace.metadata[0].name
  domain_namespace        = kubernetes_namespace.domain_namespace.metadata[0].name

  # Service account
  azure_devops_app_service_account_name        = "azure-devops"
  azure_devops_app_service_account_secret_name = "${local.azure_devops_app_service_account_name}-token"

  apim_service_account_name        = "apim"
  apim_service_account_secret_name = "${local.apim_service_account_name}-token"

  cdn_name        = "${local.project}-checkout-cdn-endpoint"
  cdn_rg_name     = "${local.project}-checkout-fe-rg"
  cdn_fqdn_url    = "https://${module.key_vault_secrets_query.values["cdn-fqdn"].value}"
  cdn_storage_url = "https://${module.key_vault_secrets_query.values["cdn-storage-blob-primary-web-host"].value}"


  # Monitor
  alert_functions_exceptions_name       = "pnpg-functions-exception"
  alert_functions_exceptions_role_names = ["selc-${var.env_short}-pnpg-onboarding-fn"]
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

variable "ca_suffix_dns_private_name" {
  type        = string
  description = "CA suffix private DNS record"
}

variable "reverse_proxy_ip" {
  type        = string
  default     = "127.0.0.1"
  description = "AKS external ip. Also the ingress-nginx-controller external ip. Value known after installing the ingress controller."
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
variable "configmaps_interop-be-party-process" {
  type = map(string)
}

variable "configmaps_national_registries" {
  type = map(string)
}

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

variable "anac-ftp" {
  type = map(string)
}

variable "api_gateway_url" {
  type = string
}

variable "default_service_port" {
  type    = number
  default = 8080
}

variable "spid_testenv_url" {
  type    = string
  default = null
}

variable "configmaps_hub-spid-login-ms" {
  type = map(string)
}

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

# Network
# variable "cidr_vnet" {
#   type        = list(string)
#   description = "Virtual network address space."
# }

# variable "cidr_subnet_apim" {
#   type        = list(string)
#   description = "Address prefixes subnet api management."
#   default     = null
# }

# variable "cidr_subnet_private_endpoints" {
#   type        = list(string)
#   description = "private endpoints address space."
# }

# variable "app_gateway_api_pnpg_certificate_name" {
#   type        = string
#   description = "Application gateway: api-pnpg certificate name on Key Vault"
# }

# variable "app_gateway_api_certificate_name" {
#   type        = string
#   description = "Application gateway: api certificate name on Key Vault"
# }

variable "jwt_issuer" {
  type        = string
  description = "SPID"
  default     = "SPID"
}

variable "terraform_remote_state_core" {
  type = object({
    resource_group_name  = string,
    storage_account_name = string,
    container_name       = string,
    key                  = string
  })
}
