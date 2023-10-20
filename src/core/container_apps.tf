resource "azurerm_resource_group" "selc_container_app_rg" {
  name     = "${local.project}-container-app-rg"
  location = var.location

  tags = var.tags
}

resource "azurerm_subnet" "selc_container_app_snet" {
  count                = var.cidr_subnet_selc != null ? 1 : 0
  name                 = "${local.project}-container-app-snet"
  resource_group_name  = azurerm_resource_group.rg_vnet.name
  virtual_network_name = module.vnet.name
  address_prefixes     = var.cidr_subnet_selc
}

module "selc_cae" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//container_app_environment?ref=v7.8.0"

  name                      = "${local.project}-cae"
  resource_group_name       = azurerm_resource_group.selc_container_app_rg.name
  location                  = azurerm_resource_group.selc_container_app_rg.location
  vnet_internal             = true
  subnet_id                 = azurerm_subnet.selc_container_app_snet[0].id
  log_destination           = "log-analytics"
  log_analytics_customer_id = azurerm_log_analytics_workspace.log_analytics_workspace.workspace_id
  log_analytics_shared_key  = azurerm_log_analytics_workspace.log_analytics_workspace.primary_shared_key
  zone_redundant            = var.cae_zone_redundant

  tags = var.tags
}

data "azurerm_key_vault_secrets" "key_vault_secrets" {
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "keyvault_secret" {
  for_each     = toset(data.azurerm_key_vault_secrets.key_vault_secrets.names)
  name         = each.key
  key_vault_id = module.key_vault.id
}

locals {
  secrets = [for secret in var.ca_onboarding_ms_secrets :
    {
      identity    = "system"
      name        = "${secret}"
      keyVaultUrl = data.azurerm_key_vault_secret.keyvault_secret["${secret}"].id
  }]
}

resource "azapi_resource" "container_app_onboarding_ms" {
  type      = "Microsoft.App/containerApps@2023-05-01"
  name      = "${local.project}-onboarding-ms"
  location  = azurerm_resource_group.selc_container_app_rg.location
  parent_id = azurerm_resource_group.selc_container_app_rg.id

  tags = var.tags

  identity {
    type = "SystemAssigned"
  }

  body = jsonencode({
    properties = {
      configuration = {
        activeRevisionsMode = "Single"
        ingress = {
          allowInsecure = true
          external      = true
          traffic = [
            {
              latestRevision = true
              weight         = 100
            }
          ]
          targetPort = 8080
        }
        secrets = local.secrets
      }
      environmentId = module.selc_cae.id
      template = {
        containers = [
          {
            env = [
              {
                name      = "JWT_TOKEN_PUBLIC_KEY"
                secretRef = "jwt-public-key"
              },
              {
                name      = "MONGODB_CONNECTION_URI"
                secretRef = "mongodb-connection-string"
              },
              {
                name      = "USER_REGISTRY_API_KEY"
                secretRef = "user-registry-api-key"
              },
              {
                name      = "ONBOARDING_FUNCTIONS_API_KEY"
                secretRef = "onboarding-functions-api-key"
              },
              {
                name  = "USER_REGISTRY_URL"
                value = "https://api.uat.pdv.pagopa.it/user-registry/v1"
              },
              {
                name  = "ONBOARDING_FUNCTIONS_URL"
                value = "https://selc-d-func.azurewebsites.net"
              },
              {
                name  = "ONBOARDING_ALLOWED_INSTITUTIONS_PRODUCTS"
                value = "'prod-interop': ['*'], 'prod-pn': ['*'], 'prod-io': ['*'], 'prod-io-premium': ['*'], 'prod-pagopa': ['*'], 'prod-fd': ['*'], 'prod-fd-garantito': ['*']}"
              }
            ]
            image = "ghcr.io/pagopa/selfcare-onboarding-ms:latest"
            name  = "${local.project}-onboarding-ms"
            resources = {
              cpu    = 0.5
              memory = "1Gi"
            }
          }
        ]
        revisionSuffix = "${formatdate("YYYYMMDDhhmmss", timestamp())}"
        scale = {
          maxReplicas = var.ca_onboarding_ms_replicas.maxReplicas
          minReplicas = var.ca_onboarding_ms_replicas.minReplicas
          rules       = var.ca_onboarding_ms_scale_rules
        }
      }
    }
  })
}

resource "azurerm_key_vault_access_policy" "keyvault_containerapp" {
  key_vault_id = module.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azapi_resource.container_app_onboarding_ms.identity[0].principal_id

  secret_permissions = [
    "Get",
  ]
}
