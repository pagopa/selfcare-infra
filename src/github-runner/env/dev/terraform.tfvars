prefix    = "selc"
env_short = "d"
location  = "westeurope"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "SelfCare"
  Source      = "https://github.com/pagopa/selfcare-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

key_vault = {
  name                = "selc-d-kv"
  resource_group_name = "selc-d-sec-rg"
  pat_secret_name     = "github-runner-pat"
}

networking = {
  vnet_resource_group_name = "selc-d-vnet-rg"
  vnet_name                = "selc-d-vnet"
  subnet_cidr_block        = "10.1.146.0/23"
}

law = {
  name                = "selc-d-law"
  resource_group_name = "selc-d-monitor-rg"
}
