# general
prefix         = "selfcare"
env_short      = "u"
env            = "uat"
location       = "westeurope"
location_short = "weu"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Uat"
  Owner       = "SelfCare"
  Source      = "https://github.com/pagopa/selfcare-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

ci_github_federations = [
  {
    repository = "selfcare-infra"
    subject    = "UAT"
  },
  {
    repository = "selfcare-infra"
    subject    = "uat-ci"
  },
  {
    repository = "selfcare-onboarding"
    subject    = "uat-ci"
  }
]

cd_github_federations = [
  {
    repository = "selfcare-infra"
    subject    = "UAT"
  },
  {
    repository = "selfcare-infra"
    subject    = "uat-cd"
  },
  {
    repository = "selfcare-onboarding"
    subject    = "uat-cd"
  }
]

environment_ci_roles = {
  subscription = [
    "Reader",
    "Reader and Data Access",
    "Storage Blob Data Reader",
    "Storage File Data SMB Share Reader",
    "Storage Queue Data Reader",
    "Storage Table Data Reader",
    "PagoPA Export Deployments Template",
    "Key Vault Secrets User",
    "DocumentDB Account Contributor",
    "API Management Service Contributor",
  ]
}

environment_cd_roles = {
  subscription = [
    "Contributor",
    "Storage Account Contributor",
    "Storage Blob Data Contributor",
    "Storage File Data SMB Share Contributor",
    "Storage Queue Data Contributor",
    "Storage Table Data Contributor",
  ]
}
