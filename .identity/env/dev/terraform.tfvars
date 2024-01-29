# general
prefix    = "selc"
env_short = "d"
env       = "dev"
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
    subject    = "dev-ci"
  },
]

cd_github_federations = [
  {
    repository = "selfcare-infra"
    subject    = "dev-cd"
  }
]

environment_ci_roles = {
  subscription = [
    "Reader",
    "PagoPA IaC Reader",
    "Reader and Data Access"
  ]
  resource_groups = {
    "terraform-state-rg" = [
      "Storage Blob Data Contributor"
    ],
    "io-infra-rg" = [
      "Storage Blob Data Contributor"
    ],
    "selc-d-aks-rg" = [
      "Azure Kubernetes Service Cluster Admin Role"
    ],
    "selc-d-contracts-storage-rg" = [
      "Storage Blob Data Contributor"
    ],
    "selc-d-logs-storage-rg" = [
      "Storage Blob Data Contributor"
    ]
  }
}

environment_cd_roles = {
  subscription = [
    "Contributor"
  ]
  resource_groups = {
    "terraform-state-rg" = [
      "Storage Blob Data Contributor"
    ],
    "io-infra-rg" = [
      "Storage Blob Data Contributor"
    ],
    "selc-d-aks-rg" = [
      "Azure Kubernetes Service Cluster Admin Role"
    ]
  }
}

github_repository_environment_ci = {
  protected_branches     = false
  custom_branch_policies = false
}

github_repository_environment_cd = {
  protected_branches     = false
  custom_branch_policies = false
}
