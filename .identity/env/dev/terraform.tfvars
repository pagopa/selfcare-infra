# general
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

ci_github_federations = [
  {
    repository = "selfcare-infra"
    subject    = "DEV"
  },
  {
    repository = "selfcare-onboarding"
    subject    = "dev-ci"
  }
]

cd_github_federations = [
  {
    repository = "selfcare-infra"
    subject    = "DEV"
  },
  {
    repository = "selfcare-onboarding"
    subject    = "dev-cd"
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
    "API Management Service Contributor"
  ]
  resource_groups = {
    "terraform-state-rg" = [
      "Storage Blob Data Contributor"
    ]
  }
}

environment_cd_roles = {
  subscription = [
    "Contributor",
    "Storage Account Contributor",
    "Storage Blob Data Contributor",
    "Storage File Data SMB Share Contributor",
    "Storage Queue Data Contributor",
    "Storage Table Data Contributor"
  ]
  resource_groups = {
    "terraform-state-rg" = [
      "Storage Blob Data Owner"
    ]
  }
}
