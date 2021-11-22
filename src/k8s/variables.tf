variable "location" {
  type    = string
  default = "westeurope"
}

variable "prefix" {
  type    = string
  default = "selc"
}

variable "env" {
  type = string
}

variable "env_short" {
  type = string
}

variable "k8s_kube_config_path" {
  type    = string
  default = "~/.kube/config"
}

variable "k8s_apiserver_host" {
  type = string
}

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
variable "api-version_uservice-attribute-registry-management" {
  type = string
}

variable "api-version_uservice-party-management" {
  type = string
}

variable "api-version_uservice-party-process" {
  type = string
}

variable "api-version_uservice-party-registry-proxy" {
  type = string
}

# configs/secrets

variable "configmaps_hub-spid-login-ms" {
  type = map(string)
}

variable "configmaps_ms-product" {
  type = map(string)
}

variable "configmaps_b4f-dashboard" {
  type = map(string)
}

variable "configmaps_uservice-attribute-registry-management" {
  type = map(string)
}

variable "configmaps_uservice-party-management" {
  type = map(string)
}

variable "configmaps_uservice-party-process" {
  type = map(string)
}

variable "configmaps_uservice-party-registry-proxy" {
  type = map(string)
}