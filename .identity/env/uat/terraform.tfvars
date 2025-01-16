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

ci_github_federations_ms = [
  {
    repository = "selfcare-dashboard-backend"
    subject    = "uat-ci"
  },
  {
    repository = "selfcare-external-api-backend"
    subject    = "uat-ci"
  },
  {
    repository = "selfcare-infra"
    subject    = "uat-ci"
  },
  {
    repository = "selfcare-ms-core"
    subject    = "uat-ci"
  },
  {
    repository = "selfcare-ms-external-interceptor"
    subject    = "uat-ci"
  },
  {
    repository = "selfcare-ms-party-registry-proxy"
    subject    = "uat-ci"
  },
  {
    repository = "selfcare-onboarding"
    subject    = "uat-ci"
  },
  {
    repository = "selfcare-onboarding-backend"
    subject    = "uat-ci"
  },
  {
    repository = "selfcare-user"
    subject    = "uat-ci"
  },
  {
    repository = "selfcare-institution"
    subject    = "uat-ci"
  },
  {
    repository = "selfcare-infra-private"
    subject    = "uat-ci"
  },
  {
    repository = "selfcare-login-frontend"
    subject    = "uat-ci"
  },
  {
    repository = "selfcare-token-exchange-frontend"
    subject    = "uat-ci"
  },
  {
    repository = "selfcare-dashboard-frontend"
    subject    = "uat-ci"
  },
  {
    repository = "selfcare-dashboard-admin-microfrontend"
    subject    = "uat-ci"
  },
  {
    repository = "selfcare-dashboard-groups-microfrontend"
    subject    = "uat-ci"
  },
  {
    repository = "selfcare-dashboard-users-microfrontend"
    subject    = "uat-ci"
  },
  {
    repository = "selfcare-onboarding-frontend"
    subject    = "uat-ci"
  },
  {
    repository = "selfcare-pnpg-dashboard-frontend"
    subject    = "uat-ci"
  }
]

cd_github_federations_ms = [
  {
    repository = "selfcare-dashboard-backend"
    subject    = "uat-cd"
  },
  {
    repository = "selfcare-external-api-backend"
    subject    = "uat-cd"
  },
  {
    repository = "selfcare-infra"
    subject    = "uat-cd"
  },
  {
    repository = "selfcare-ms-core"
    subject    = "uat-cd"
  },
  {
    repository = "selfcare-ms-external-interceptor"
    subject    = "uat-cd"
  },
  {
    repository = "selfcare-ms-party-registry-proxy"
    subject    = "uat-cd"
  },
  {
    repository = "selfcare-onboarding"
    subject    = "uat-cd"
  },
  {
    repository = "selfcare-onboarding-backend"
    subject    = "uat-cd"
  },
  {
    repository = "selfcare-user"
    subject    = "uat-cd"
  },
  {
    repository = "selfcare-institution"
    subject    = "uat-cd"
  },
  {
    repository = "selfcare-infra-private"
    subject    = "uat-cd"
  },
  {
    repository = "selfcare-login-frontend"
    subject    = "uat-cd"
  },
  {
    repository = "selfcare-token-exchange-frontend"
    subject    = "uat-cd"
  },
  {
    repository = "selfcare-dashboard-frontend"
    subject    = "uat-cd"
  },
  {
    repository = "selfcare-dashboard-admin-microfrontend"
    subject    = "uat-cd"
  },
  {
    repository = "selfcare-dashboard-groups-microfrontend"
    subject    = "uat-cd"
  },
  {
    repository = "selfcare-dashboard-users-microfrontend"
    subject    = "uat-cd"
  },
  {
    repository = "selfcare-onboarding-frontend"
    subject    = "uat-cd"
  },
  {
    repository = "selfcare-pnpg-dashboard-frontend"
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
    "selc-u-aks-rg" = [
      "Azure Kubernetes Service Cluster Admin Role"
    ]
  }
}

environment_ci_roles_ms = {
  subscription = [
    "Reader",
    "PagoPA IaC Reader",
    "ContainerApp Reader"
  ]
  resource_groups = {
    terraform-state-rg = [
      "Storage Blob Data Contributor"
    ],
    "selc-u-contracts-storage-rg" = [
      "Storage Blob Data Contributor"
    ]
  }
}

environment_cd_roles_ms = {
  subscription = [
    "Contributor"
  ]
  resource_groups = {
    terraform-state-rg = [
      "Storage Blob Data Contributor"
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
