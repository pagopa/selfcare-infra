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
  }
]

cd_github_federations = [
  {
    repository = "selfcare-infra"
    subject    = "dev-cd"
  }
]

ci_github_federations_ms = [
  {
    repository = "selfcare-dashboard-backend"
    subject    = "dev-ci"
  },
  {
    repository = "selfcare-external-api-backend"
    subject    = "dev-ci"
  },
  {
    repository = "selfcare-infra"
    subject    = "dev-ci"
  },
  {
    repository = "selfcare-ms-core"
    subject    = "dev-ci"
  },
  {
    repository = "selfcare-ms-external-interceptor"
    subject    = "dev-ci"
  },
  {
    repository = "selfcare-ms-party-registry-proxy"
    subject    = "dev-ci"
  },
  {
    repository = "selfcare-onboarding"
    subject    = "dev-ci"
  },
  {
    repository = "selfcare-onboarding-backend"
    subject    = "dev-ci"
  },
  {
    repository = "selfcare-user"
    subject    = "dev-ci"
  },
  {
    repository = "selfcare-institution"
    subject    = "dev-ci"
  },
  {
    repository = "selfcare-infra-private"
    subject    = "dev-ci"
  },
  {
    repository = "selfcare-login-frontend"
    subject    = "dev-ci"
  },
  {
    repository = "selfcare-token-exchange-frontend"
    subject    = "dev-ci"
  },
  {
    repository = "selfcare-dashboard-frontend"
    subject    = "dev-ci"
  },
  {
    repository = "selfcare-dashboard-admin-microfrontend"
    subject    = "dev-ci"
  },
  {
    repository = "selfcare-dashboard-groups-microfrontend"
    subject    = "dev-ci"
  },
  {
    repository = "selfcare-dashboard-users-microfrontend"
    subject    = "dev-ci"
  },
  {
    repository = "selfcare-onboarding-frontend"
    subject    = "dev-ci"
  },
  {
    repository = "selfcare-pnpg-dashboard-frontend"
    subject    = "dev-ci"
  }
]

cd_github_federations_ms = [
  {
    repository = "selfcare-dashboard-backend"
    subject    = "dev-cd"
  },
  {
    repository = "selfcare-external-api-backend"
    subject    = "dev-cd"
  },
  {
    repository = "selfcare-ms-core"
    subject    = "dev-cd"
  },
  {
    repository = "selfcare-ms-external-interceptor"
    subject    = "dev-cd"
  },
  {
    repository = "selfcare-ms-party-registry-proxy"
    subject    = "dev-cd"
  },
  {
    repository = "selfcare-onboarding"
    subject    = "dev-cd"
  },
  {
    repository = "selfcare-onboarding-backend"
    subject    = "dev-cd"
  },
  {
    repository = "selfcare-user"
    subject    = "dev-cd"
  },
  {
    repository = "selfcare-institution"
    subject    = "dev-cd"
  },
  {
    repository = "selfcare-infra-private"
    subject    = "dev-cd"
  },
  {
    repository = "selfcare-login-frontend"
    subject    = "dev-cd"
  },
  {
    repository = "selfcare-token-exchange-frontend"
    subject    = "dev-cd"
  },
  {
    repository = "selfcare-dashboard-frontend"
    subject    = "dev-cd"
  },
  {
    repository = "selfcare-dashboard-admin-microfrontend"
    subject    = "dev-cd"
  },
  {
    repository = "selfcare-dashboard-groups-microfrontend"
    subject    = "dev-cd"
  },
  {
    repository = "selfcare-dashboard-users-microfrontend"
    subject    = "dev-cd"
  },
  {
    repository = "selfcare-onboarding-frontend"
    subject    = "dev-cd"
  },
  {
    repository = "selfcare-pnpg-dashboard-frontend"
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
    "selc-d-aks-rg" = [
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
    "selc-d-contracts-storage-rg" = [
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
  protected_branches     = false
  custom_branch_policies = false
}

github_repository_environment_cd = {
  protected_branches     = false
  custom_branch_policies = false
}
