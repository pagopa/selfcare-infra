locals {
  prefix    = "selc"
  env_short = "p"
  project   = "${local.prefix}-${local.env_short}"

  location = "westeurope"

  tags = {
    CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
    CreatedBy   = "Terraform"
    Environment = "Prod"
    Owner       = "SelfCare"
    Source      = "https://github.com/pagopa/selfcare-infra/blob/main/src/container-apps/uat/westeurope"
  }
}
