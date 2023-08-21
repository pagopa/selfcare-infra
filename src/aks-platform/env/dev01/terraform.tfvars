# general
prefix              = "selc"
env_short           = "d"
env                 = "dev"
domain              = "dev01"
location            = "westeurope"
location_string     = "West Europe"
location_short      = "weu"
location_pair_short = "neu"
location_pair       = "northeurope"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "SelfCare"
  Source      = "https://github.com/pagopa/selfcare-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

# # 🔐 key vault
# key_vault_name    = "selc-d-xyz"
# key_vault_rg_name = "selc-d-xyz"

### Network

cidr_subnet_aks = ["10.11.0.0/17"]

### External resources

monitor_resource_group_name                 = "selc-d-monitor-rg"
log_analytics_workspace_name                = "selc-d-law"
log_analytics_workspace_resource_group_name = "selc-d-monitor-rg"

### Aks

#
# ⛴ AKS
#
public_ip_aksoutbound_name = "selc-d-weu-aks-platform-outbound-pip"

aks_enabled                 = true
aks_private_cluster_enabled = true
aks_alerts_enabled          = false
aks_kubernetes_version      = "1.26.3"
aks_system_node_pool = {
  name            = "selcdsys",
  vm_size         = "Standard_B4ms",
  os_disk_type    = "Managed",
  os_disk_size_gb = 75,
  node_count_min  = 2,
  node_count_max  = 3,
  node_labels     = { node_name : "aks-dev-sys", node_type : "system" },
  node_tags       = { node_tag_1 : "1" },
}
aks_user_node_pool = {
  enabled         = true,
  name            = "seldusr",
  vm_size         = "Standard_B4ms",
  os_disk_type    = "Managed",
  os_disk_size_gb = 128,
  node_count_min  = 2,
  node_count_max  = 3,
  node_labels     = { node_name : "aks-dev-user", node_type : "user", "pagopa.it/node-scope" : "app" },
  node_taints     = [],
  node_tags       = { node_tag_2 : "2" },
}

aks_addons = {
  azure_policy                     = true,
  azure_key_vault_secrets_provider = true,
  pod_identity_enabled             = true,
}

ingress_replica_count = "1"
# This is the k8s ingress controller ip. It must be in the aks subnet range.
ingress_load_balancer_ip = "10.11.100.250"
nginx_helm_version       = "4.7.1"
keda_helm_version        = "2.11.1"

# chart releases: https://github.com/stakater/Reloader/releases
# image tags: https://hub.docker.com/r/stakater/reloader/tags
reloader_helm = {
  chart_version = "v1.0.30"
  image_name    = "stakater/reloader"
  image_tag     = "v1.0.30"
}

# chart releases: https://github.com/prometheus-community/helm-charts/releases?q=tag%3Aprometheus-15&expanded=true
# quay.io/prometheus/alertmanager image tags: https://quay.io/repository/prometheus/alertmanager?tab=tags
# jimmidyson/configmap-reload image tags: https://hub.docker.com/r/jimmidyson/configmap-reload/tags
# quay.io/prometheus/node-exporter image tags: https://quay.io/repository/prometheus/node-exporter?tab=tags
# quay.io/prometheus/prometheus image tags: https://quay.io/repository/prometheus/prometheus?tab=tags
# prom/pushgateway image tags:https://hub.docker.com/r/prom/pushgateway/tags
prometheus_helm = {
  chart_version = "15.18.0"
  alertmanager = {
    image_name = "quay.io/prometheus/alertmanager"
    image_tag  = "v0.25.0"
  }
  configmap_reload_prometheus = {
    image_name = "jimmidyson/configmap-reload"
    image_tag  = "v0.9.0"
  }
  configmap_reload_alertmanager = {
    image_name = "jimmidyson/configmap-reload"
    image_tag  = "v0.9.0"
  }
  node_exporter = {
    image_name = "quay.io/prometheus/node-exporter"
    image_tag  = "v1.6.1"
  }
  server = {
    image_name = "quay.io/prometheus/prometheus"
    image_tag  = "v2.45.0"
  }
  pushgateway = {
    image_name = "prom/pushgateway"
    image_tag  = "v1.6.0"
  }
}

# chart releases: https://github.com/pagopa/aks-microservice-chart-blueprint/releases
# image tags: https://github.com/pagopa/infra-ssl-check/releases
tls_cert_check_helm = {
  chart_version = "1.21.0"
  image_name    = "ghcr.io/pagopa/infra-ssl-check"
  image_tag     = "v1.2.2@sha256:22f4b53177cc8891bf10cbd0deb39f60e1cd12877021c3048a01e7738f63e0f9"
}

tls_checker_https_endpoints_to_check = [
  {
    https_endpoint = "api.selfcare.pagopa.it",
    alert_name     = "api.selfcare.pagopa.it",
    alert_enabled  = true,
    helm_present   = true,
  },
]
