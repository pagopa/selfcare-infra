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
    repository = "hub-spid-login-ms"
    subject    = "prod-ci"
  },
  {
    repository = "selfcare-dashboard-backend"
    subject    = "prod-ci"
  },
  {
    repository = "selfcare-external-api-backend"
    subject    = "prod-ci"
  },
  {
    repository = "selfcare-hub-spid-login-ms"
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
    repository = "selfcare-ms-notification-manager"
    subject    = "prod-ci"
  },
  {
    repository = "selfcare-ms-onboarding-interceptor"
    subject    = "prod-ci"
  },
  {
    repository = "selfcare-ms-party-registry-proxy"
    subject    = "prod-ci"
  },
  {
    repository = "selfcare-ms-product"
    subject    = "prod-ci"
  },
  {
    repository = "selfcare-ms-user-group"
    subject    = "prod-ci"
  },
  {
    repository = "selfcare-onboarding"
    subject    = "prod-ci"
  },
  {
    repository = "selfcare-onboarding-backend"
    subject    = "prod-ci"
  }
]

cd_github_federations = [
  {
    repository = "hub-spid-login-ms"
    subject    = "prod-cd"
  },
  {
    repository = "selfcare-dashboard-backend"
    subject    = "prod-cd"
  },
  {
    repository = "selfcare-external-api-backend"
    subject    = "prod-cd"
  },
  {
    repository = "selfcare-hub-spid-login-ms"
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
    repository = "selfcare-ms-notification-manager"
    subject    = "prod-cd"
  },
  {
    repository = "selfcare-ms-onboarding-interceptor"
    subject    = "prod-cd"
  },
  {
    repository = "selfcare-ms-party-registry-proxy"
    subject    = "prod-cd"
  },
  {
    repository = "selfcare-ms-product"
    subject    = "prod-cd"
  },
  {
    repository = "selfcare-ms-user-group"
    subject    = "prod-cd"
  },
  {
    repository = "selfcare-onboarding"
    subject    = "prod-cd"
  },
  {
    repository = "selfcare-onboarding-backend"
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
    ],
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
    "Contributor",
    "Storage Account Contributor",
    "Storage Blob Data Contributor",
    "Storage File Data SMB Share Contributor",
    "Storage Queue Data Contributor",
    "Storage Table Data Contributor"
  ]
  resource_groups = {
    "selc-p-aks-rg" = [
      "Azure Kubernetes Service Cluster Admin Role"
    ]
  }
}
