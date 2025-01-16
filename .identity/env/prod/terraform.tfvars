prefix    = "selc"
env_short = "p"
env       = "prod"
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
    subject    = "prod-ci"
  }
]

cd_github_federations = [
  {
    repository = "selfcare-infra"
    subject    = "prod-cd"
  }
]

ci_github_federations_ms = [
  {
    repository = "selfcare-dashboard-backend"
    subject    = "prod-ci"
  },
  {
    repository = "selfcare-external-api-backend"
    subject    = "prod-ci"
  },
  {
    repository = "selfcare-infra"
    subject    = "prod-ci"
  },
  {
    repository = "selfcare-ms-core"
    subject    = "prod-ci"
  },
  {
    repository = "selfcare-ms-external-interceptor"
    subject    = "prod-ci"
  },
  {
    repository = "selfcare-ms-party-registry-proxy"
    subject    = "prod-ci"
  },
  {
    repository = "selfcare-onboarding"
    subject    = "prod-ci"
  },
  {
    repository = "selfcare-onboarding-backend"
    subject    = "prod-ci"
  },
  {
    repository = "selfcare-user"
    subject    = "prod-ci"
  },
  {
    repository = "selfcare-institution"
    subject    = "prod-ci"
  },
  {
    repository = "selfcare-infra-private"
    subject    = "prod-ci"
  },
  {
    repository = "selfcare-login-frontend"
    subject    = "prod-ci"
  },
  {
    repository = "selfcare-token-exchange-frontend"
    subject    = "prod-ci"
  },
  {
    repository = "selfcare-dashboard-frontend"
    subject    = "prod-ci"
  },
  {
    repository = "selfcare-dashboard-admin-microfrontend"
    subject    = "prod-ci"
  },
  {
    repository = "selfcare-dashboard-groups-microfrontend"
    subject    = "prod-ci"
  },
  {
    repository = "selfcare-dashboard-users-microfrontend"
    subject    = "prod-ci"
  },
  {
    repository = "selfcare-onboarding-frontend"
    subject    = "prod-ci"
  },
  {
    repository = "selfcare-pnpg-dashboard-frontend"
    subject    = "prod-ci"
  }
]

cd_github_federations_ms = [
  {
    repository = "selfcare-dashboard-backend"
    subject    = "prod-cd"
  },
  {
    repository = "selfcare-external-api-backend"
    subject    = "prod-cd"
  },
  {
    repository = "selfcare-infra"
    subject    = "prod-cd"
  },
  {
    repository = "selfcare-ms-core"
    subject    = "prod-cd"
  },
  {
    repository = "selfcare-ms-external-interceptor"
    subject    = "prod-cd"
  },
  {
    repository = "selfcare-ms-party-registry-proxy"
    subject    = "prod-cd"
  },
  {
    repository = "selfcare-onboarding"
    subject    = "prod-cd"
  },
  {
    repository = "selfcare-onboarding-backend"
    subject    = "prod-cd"
  },
  {
    repository = "selfcare-user"
    subject    = "prod-cd"
  },
  {
    repository = "selfcare-institution"
    subject    = "prod-cd"
  },
  {
    repository = "selfcare-infra-private"
    subject    = "prod-cd"
  },
  {
    repository = "selfcare-login-frontend"
    subject    = "prod-cd"
  },
  {
    repository = "selfcare-token-exchange-frontend"
    subject    = "prod-cd"
  },
  {
    repository = "selfcare-dashboard-frontend"
    subject    = "prod-cd"
  },
  {
    repository = "selfcare-dashboard-admin-microfrontend"
    subject    = "prod-cd"
  },
  {
    repository = "selfcare-dashboard-groups-microfrontend"
    subject    = "prod-cd"
  },
  {
    repository = "selfcare-dashboard-users-microfrontend"
    subject    = "prod-cd"
  },
  {
    repository = "selfcare-onboarding-frontend"
    subject    = "prod-cd"
  },
  {
    repository = "selfcare-pnpg-dashboard-frontend"
    subject    = "prod-cd"
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
    "selc-p-aks-rg" = [
      "Azure Kubernetes Service Cluster Admin Role"
    ]
    "selc-p-contracts-storage-rg" = [
      "Storage Blob Data Contributor"
    ],
    "selc-p-logs-storage-rg" = [
      "Storage Blob Data Contributor"
    ]
  }
}

environment_cd_roles = {
  subscription = [
    "Contributor"
  ]
  resource_groups = {
    "selc-p-aks-rg" = [
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
    "selc-p-contracts-storage-rg" = [
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
