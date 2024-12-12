module "identity_ci" {
  source = "github.com/pagopa/terraform-azurerm-v3//github_federated_identity?ref=v8.49.1"

  prefix    = var.prefix
  env_short = var.env_short
  domain    = var.domain

  identity_role = "ci"

  github_federations = var.ci_github_federations

  ci_rbac_roles = {
    subscription_roles = var.environment_ci_roles.subscription
    resource_groups    = var.environment_ci_roles.resource_groups
  }

  tags = var.tags

  depends_on = [
    azurerm_resource_group.identity_rg
  ]
}

module "identity_ci_ms" {
  source = "github.com/pagopa/terraform-azurerm-v3//github_federated_identity?ref=v8.49.1"

  prefix    = var.prefix
  env_short = var.env_short
  domain    = "ms"

  identity_role = "ci"

  github_federations = var.ci_github_federations_ms

  ci_rbac_roles = {
    subscription_roles = concat(var.environment_ci_roles_ms.subscription, [azurerm_role_definition.container_apps_jobs_reader.name, azurerm_role_definition.apim_integration_reader.name])
    resource_groups = merge(var.environment_ci_roles_ms.resource_groups,
      {
        "selc-${var.env_short}-checkout-fe-rg" = ["Storage Blob Data Contributor", "Storage Account Key Operator Service Role", "CDN Endpoint Contributor"]
    })
  }

  tags = var.tags

  depends_on = [
    azurerm_resource_group.identity_rg
  ]
}

resource "azurerm_key_vault_access_policy" "key_vault_access_policy_identity_ci" {
  key_vault_id = data.azurerm_key_vault.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = module.identity_ci_ms.identity_principal_id

  secret_permissions = [
    "Get",
    "List",
  ]

  certificate_permissions = [
    "Get",
    "List",
  ]
}


resource "azurerm_key_vault_access_policy" "key_vault_access_policy_pnpg_identity_ci" {
  key_vault_id = data.azurerm_key_vault.key_vault_pnpg.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = module.identity_ci_ms.identity_principal_id

  secret_permissions = [
    "Get",
    "List",
  ]
}

resource "azurerm_role_definition" "container_apps_jobs_reader" {
  name        = "SelfCare ${var.env} ContainerApp Jobs Reader"
  scope       = data.azurerm_subscription.current.id
  description = "Custom role used to read container apps jobs execution properties"

  permissions {
    actions = [
      "microsoft.app/jobs/read",
      "microsoft.app/jobs/listsecrets/action",
      "microsoft.app/jobs/detectors/read",
      "microsoft.app/jobs/execution/read",
      "microsoft.app/jobs/executions/read"
    ]
  }

  assignable_scopes = [
    data.azurerm_subscription.current.id
  ]
}

resource "azurerm_role_definition" "apim_integration_reader" {
  name        = "SelfCare ${var.env} APIM Integration Reader"
  scope       = data.azurerm_subscription.current.id
  description = "Custom role used to read APIM integration secrets"

  permissions {
    actions     = ["Microsoft.ApiManagement/service/portalSettings/listSecrets/action", "Microsoft.ApiManagement/service/tenant/listSecrets/action"]
    not_actions = []
  }

  assignable_scopes = [
    data.azurerm_subscription.current.id,
  ]
}
