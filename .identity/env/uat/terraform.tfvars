prefix         = "selc"
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
    subject    = "uat-ci"
  }
]

cd_github_federations = [
  {
    repository = "selfcare-infra"
    subject    = "uat-cd"
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
    "selc-u-aks-rg" = [
      "Azure Kubernetes Service Cluster Admin Role"
    ],
    "selc-u-contracts-storage-rg" = [
      "Storage Blob Data Contributor"
    ],
    "selc-u-logs-storage-rg" = [
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
    "selc-u-aks-rg" = [
      "Azure Kubernetes Service Cluster Admin Role"
    ]
  }
}

github_repository_environment_ci = {
  protected_branches     = true
  custom_branch_policies = false
}

github_repository_environment_cd = {
  protected_branches     = true
  custom_branch_policies = false
}
