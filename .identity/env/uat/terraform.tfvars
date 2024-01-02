# general
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
    repository = "hub-spid-login-ms"
    subject    = "uat-ci"
  },
  {
    repository = "selfcare-dashboard-backend"
    subject    = "uat-ci"
  },
  {
    repository = "selfcare-external-api-backend"
    subject    = "uat-ci"
  },
  {
    repository = "selfcare-hub-spid-login-ms"
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
    repository = "selfcare-ms-notification-manager"
    subject    = "uat-ci"
  },
  {
    repository = "selfcare-ms-onboarding-interceptor"
    subject    = "uat-ci"
  },
  {
    repository = "selfcare-ms-party-registry-proxy"
    subject    = "uat-ci"
  },
  {
    repository = "selfcare-ms-product"
    subject    = "uat-ci"
  },
  {
    repository = "selfcare-ms-user-group"
    subject    = "uat-ci"
  },
  {
    repository = "selfcare-onboarding"
    subject    = "uat-ci"
  },
  {
    repository = "selfcare-onboarding-backend"
    subject    = "uat-ci"
  }
]

cd_github_federations = [
  {
    repository = "hub-spid-login-ms"
    subject    = "uat-cd"
  },
  {
    repository = "selfcare-dashboard-backend"
    subject    = "uat-cd"
  },
  {
    repository = "selfcare-external-api-backend"
    subject    = "uat-cd"
  },
  {
    repository = "selfcare-hub-spid-login-ms"
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
    repository = "selfcare-ms-notification-manager"
    subject    = "uat-cd"
  },
  {
    repository = "selfcare-ms-onboarding-interceptor"
    subject    = "uat-cd"
  },
  {
    repository = "selfcare-ms-party-registry-proxy"
    subject    = "uat-cd"
  },
  {
    repository = "selfcare-ms-product"
    subject    = "uat-cd"
  },
  {
    repository = "selfcare-ms-user-group"
    subject    = "uat-cd"
  },
  {
    repository = "selfcare-onboarding"
    subject    = "uat-cd"
  },
  {
    repository = "selfcare-onboarding-backend"
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
    "Contributor",
    "Storage Account Contributor",
    "Storage Blob Data Contributor",
    "Storage File Data SMB Share Contributor",
    "Storage Queue Data Contributor",
    "Storage Table Data Contributor"
  ]
  resource_groups = {
    "selc-u-aks-rg" = [
      "Azure Kubernetes Service Cluster Admin Role"
    ]
  }
}
