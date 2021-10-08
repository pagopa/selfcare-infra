# general
env_short = "u"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Uat"
  Owner       = "SelfCare"
  Source      = "https://github.com/pagopa/selfcare-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

lock_enable = true

# networking
# main vnet
cidr_vnet              = ["10.1.0.0/16"]
cidr_subnet_k8s        = ["10.1.0.0/17"]
cidr_subnet_appgateway = ["10.1.128.0/24"]
cidr_subnet_azdoa      = ["10.1.130.0/24"]

# integration vnet
# https://www.davidc.net/sites/default/subnets/subnets.html?network=10.230.7.0&mask=24&division=7.31
cidr_vnet_integration = ["10.230.7.0/24"] # todo ask to SIA
cidr_subnet_apim      = ["10.230.7.0/26"]

# dns
external_domain = "pagopa.it"
dns_zone_prefix = "uat.selfcare"

# azure devops
azdo_sp_tls_cert_enabled = true
enable_azdoa             = true
enable_iac_pipeline      = true

# apim
apim_publisher_name = "pagoPA SelfCare UAT"
apim_sku            = "Developer_1"

# app_gateway
app_gateway_api_certificate_name = "api-uat-selfcare-pagopa-it"

# aks
aks_alerts_enabled = false
# This is the k8s ingress controller ip. It must be in the aks subnet range.
reverse_proxy_ip = "10.1.0.250"
