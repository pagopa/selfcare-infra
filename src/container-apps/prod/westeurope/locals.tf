locals {
  prefix    = "selc"
  env_short = "p"
  project   = "${local.prefix}-${local.env_short}"

  location = "westeurope"

  selc_container_app_name_snet = "${local.project}-ca-snet"
  pnpg_container_app_name_snet = "${local.project}-pnpg-ca-snet"

  tags = {
    CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
    CreatedBy   = "Terraform"
    Environment = "Prod"
    Owner       = "SelfCare"
    Source      = "https://github.com/pagopa/selfcare-infra/blob/main/src/container-apps/uat/westeurope"
  }
}
