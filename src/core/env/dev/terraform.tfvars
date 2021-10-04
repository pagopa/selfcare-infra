# general
env_short = "d"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

lock_enable = false

# networking
# main vnet
cidr_vnet              = ["10.1.0.0/16"]
cidr_subnet_appgateway = ["10.1.128.0/24"]
cidr_subnet_postgresql = ["10.1.129.0/24"]
cidr_subnet_azdoa      = ["10.1.130.0/24"]
# dev/uat only
cidr_subnet_mock_ec  = ["10.1.240.0/29"]
cidr_subnet_mock_psp = ["10.1.240.8/29"]

# integration vnet
# https://www.davidc.net/sites/default/subnets/subnets.html?network=10.230.7.0&mask=24&division=7.31
cidr_vnet_integration  = ["10.230.7.0/24"] # ask to SIA
cidr_subnet_apim       = ["10.230.7.0/26"]
cidr_subnet_api_config = ["10.230.7.128/29"]

# dns
external_domain = "pagopa.it"
dns_zone_prefix = "dev.platform"

# azure devops
azdo_sp_tls_cert_enabled = true
enable_azdoa             = true
enable_iac_pipeline      = true

# apim
apim_publisher_name = "pagoPA Platform DEV"
apim_sku            = "Developer_1"

# app_gateway
app_gateway_api_certificate_name        = "api-dev-platform-pagopa-it"
app_gateway_portal_certificate_name     = "portal-dev-platform-pagopa-it"
app_gateway_management_certificate_name = "management-dev-platform-pagopa-it"

# postgresql
prostgresql_enabled                      = true
postgresql_sku_name                      = "GP_Gen5_2" # todo fixme verify
postgresql_enable_replica                = false
postgresql_public_network_access_enabled = true
postgresql_network_rules = {
  ip_rules = [
    "0.0.0.0/0"
  ]
  # dblink
  allow_access_to_azure_services = false
}
prostgresql_db_mockpsp = "mock-psp"

# mock
mock_ec_enabled  = true
mock_psp_enabled = true

# api_config
api_config_enabled = true
