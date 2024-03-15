prefix    = "selc"
env_short = "p"
location  = "westeurope"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "SelfCare"
  Source      = "https://github.com/pagopa/selfcare-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

key_vault = {
  name                = "selc-p-kv"
  resource_group_name = "selc-p-sec-rg"
  pat_secret_name     = "github-runner-pat"
}

networking = {
  vnet_resource_group_name = "selc-p-vnet-rg"
  vnet_name                = "selc-p-vnet"
  subnet_cidr_block        = "10.1.146.0/23"
}

law = {
  name                = "selc-p-law"
  resource_group_name = "selc-p-monitor-rg"
}
