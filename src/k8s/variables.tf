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
  type = list(string)
  default = ["selc"]
}

variable "event_hub_port" {
  type    = number
  default = 9093
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

# hub-spid-login-ms

variable "configmaps_hub-spid-login-ms" {
  type = map(string)
}