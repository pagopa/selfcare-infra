# general
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

ci_github_federations = [
  {
    repository = "selfcare-infra"
    subject    = "PROD"
  },
  {
    repository = "selfcare-infra"
    subject    = "prod-ci"
  },
  {
    repository = "selfcare-onboarding"
    subject    = "prod-ci"
  }
]

cd_github_federations = [
  {
    repository = "selfcare-infra"
    subject    = "PROD"
  },
  {
    repository = "selfcare-infra"
    subject    = "prod-cd"
  },
  {
    repository = "selfcare-onboarding"
    subject    = "prod-cd"
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
    "Key Vault Secrets User",
    "DocumentDB Account Contributor",
    "API Management Service Contributor",
    "PagoPA Export Deployments Template",
    "PagoPA IaC Reader"
  ]
  resource_groups = {
    "terraform-state-rg" = [
      "Storage Blob Data Contributor"
    ],
    "io-infra-rg" = [
      "Storage Blob Data Contributor"
    ],
    "selc-p-aks-rg" = [
      "Azure Kubernetes Service Cluster Admin Role"
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
      "Storage Blob Data Contributor"
    ],
    "io-infra-rg" = [
      "Storage Blob Data Contributor"
    ],
    "selc-p-aks-rg" = [
      "Azure Kubernetes Service Cluster Admin Role"
    ]
  }
}
  