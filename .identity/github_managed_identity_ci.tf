module "identity_ci" {
  source = "github.com/pagopa/terraform-azurerm-v3//github_federated_identity?ref=v7.50.1"

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
  source = "github.com/pagopa/terraform-azurerm-v3//github_federated_identity?ref=v7.50.1"

  prefix    = var.prefix
  env_short = var.env_short
  domain    = "ms"

  identity_role = "ci"

  github_federations = var.ci_github_federations_ms

  ci_rbac_roles = {
    subscription_roles = var.environment_ci_roles_ms.subscription
    resource_groups    = var.environment_ci_roles_ms.resource_groups
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
