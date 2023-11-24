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
    repository = "hub-spid-login-ms"
    subject    = "dev-ci"
  },
  {
    repository = "selfcare-dashboard-backend"
    subject    = "dev-ci"
  },
  {
    repository = "selfcare-external-api-backend"
    subject    = "dev-ci"
  },
  {
    repository = "selfcare-hub-spid-login-ms"
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
    repository = "selfcare-ms-notification-manager"
    subject    = "dev-ci"
  },
  {
    repository = "selfcare-ms-onboarding-interceptor"
    subject    = "dev-ci"
  },
  {
    repository = "selfcare-ms-party-registry-proxy"
    subject    = "dev-ci"
  },
  {
    repository = "selfcare-ms-product"
    subject    = "dev-ci"
  },
  {
    repository = "selfcare-ms-user-group"
    subject    = "dev-ci"
  },
  {
    repository = "selfcare-onboarding"
    subject    = "dev-ci"
  },
  {
    repository = "selfcare-onboarding-backend"
    subject    = "dev-ci"
  }
]

cd_github_federations = [
  {
    repository = "hub-spid-login-ms"
    subject    = "dev-cd"
  },
  {
    repository = "selfcare-dashboard-backend"
    subject    = "dev-cd"
  },
  {
    repository = "selfcare-external-api-backend"
    subject    = "dev-cd"
  },
  {
    repository = "selfcare-hub-spid-login-ms"
    subject    = "dev-cd"
  },
  {
    repository = "selfcare-infra"
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
    repository = "selfcare-ms-notification-manager"
    subject    = "dev-cd"
  },
  {
    repository = "selfcare-ms-onboarding-interceptor"
    subject    = "dev-cd"
  },
  {
    repository = "selfcare-ms-party-registry-proxy"
    subject    = "dev-cd"
  },
  {
    repository = "selfcare-ms-product"
    subject    = "dev-cd"
  },
  {
    repository = "selfcare-ms-user-group"
    subject    = "dev-cd"
  },
  {
    repository = "selfcare-onboarding"
    subject    = "dev-cd"
  },
  {
    repository = "selfcare-onboarding-backend"
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
    "selc-d-aks-rg" = [
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
    "selc-d-aks-rg" = [
      "Azure Kubernetes Service Cluster Admin Role"
    ]
  }
}
