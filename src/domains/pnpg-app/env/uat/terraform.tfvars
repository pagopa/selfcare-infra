prefix          = "selc"
env_short       = "u"
env             = "uat"
domain          = "pnpg"
location        = "westeurope"
location_string = "West Europe"
location_short  = "weu"
instance        = "uat01"

tags = {
  CreatedBy   = "Terraform"
  Environment = "UAT"
  Owner       = "CSTAR"
  Source      = "https://github.com/pagopa/selfcare-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources

monitor_resource_group_name                 = "selfcare-u-monitor-rg"
log_analytics_workspace_name                = "selfcare-u-law"
log_analytics_workspace_resource_group_name = "selfcare-u-monitor-rg"

### Aks

aks_name                = "selfcare-u-weu-uat01-aks"
aks_resource_group_name = "selfcare-u-weu-uat01-aks-rg"

ingress_load_balancer_ip       = "10.11.100.250"
ingress_load_balancer_hostname = "uat01.pnpg.internal.uat.selfcare.pagopa.it"
reverse_proxy_be_io            = "10.1.0.250"

#
# Dns
#
dns_zone_internal_prefix = "internal.uat.selfcare"
external_domain          = "pagopa.it"

#
# Enable components
#
enable = {
  pnpg = {
    eventhub = true
  }
}

# Enrolled payment instrument event hub
eventhub_pim = {
  enrolled_pi_eventhub  = "rtd-enrolled-pi"
  revoked_pi_eventhub   = "rtd-revoked-pi"
  namespace_enrolled_pi = "selfcare-u-evh-ns"
  namespace_revoked_pi  = "selfcare-u-evh-ns"
  resource_group_name   = "selfcare-u-msg-rg"
}

#
# PDV
#
pdv_tokenizer_url = "https://api.uat.tokenizer.pdv.pagopa.it/tokenizer/v1"
pdv_timeout_sec   = 5
#
# PM
#
pm_service_base_url = "https://api-io.uat.selfcare.pagopa.it"
pm_backend_url      = "https://api.uat.platform.pagopa.it"

#
# Check IBAN
#
checkiban_base_url = "https://bankingservices-sandbox.pagopa.it"

#
# SelfCare API
#
selc_base_url = "https://api.uat.selfcare.pagopa.it"

#
# BE IO API
#
io_backend_base_url = "https://api-io.uat.selfcare.pagopa.it/pnpg/mock"

#
# TLS Checker
#
# chart releases: https://github.com/pagopa/aks-microservice-chart-blueprint/releases
# image tags: https://github.com/pagopa/infra-ssl-check/releases
tls_cert_check_helm = {
  chart_version = "1.21.0"
  image_name    = "ghcr.io/pagopa/infra-ssl-check"
  image_tag     = "v1.2.2@sha256:22f4b53177cc8891bf10cbd0deb39f60e1cd12877021c3048a01e7738f63e0f9"
}

# Storage
storage_delete_retention_days = 5
storage_enable_versioning     = true

#
# RTD reverse proxy
#
reverse_proxy_rtd = "10.1.0.250"

#
# SMTP Server
#
mail_server_host = "smtp.ethereal.email"
