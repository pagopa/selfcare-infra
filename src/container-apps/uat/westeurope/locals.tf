locals {
  prefix    = "selc"
  env_short = "u"
  project   = "${local.prefix}-${local.env_short}"

  location = "westeurope"

  tags = {
    CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
    CreatedBy   = "Terraform"
    Environment = "Uat"
    Owner       = "SelfCare"
    Source      = "https://github.com/pagopa/selfcare-infra/blob/main/src/container-apps/uat/westeurope"
  }
}
