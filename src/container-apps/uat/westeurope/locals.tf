locals {
  prefix    = "selc"
  env_short = "u"
  project   = "${local.prefix}-${local.env_short}"

  location = "westeurope"
  selc_container_app_name_snet = "${local.project}-container-app-snet"
  pnpg_container_app_name_snet = "${local.project}-pnpg-container-app-snet"

  tags = {
    CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
    CreatedBy   = "Terraform"
    Environment = "Uat"
    Owner       = "SelfCare"
    Source      = "https://github.com/pagopa/selfcare-infra/blob/main/src/container-apps/uat/westeurope"
  }
}
