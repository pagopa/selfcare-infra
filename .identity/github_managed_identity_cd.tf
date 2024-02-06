module "identity_cd" {
  source = "github.com/pagopa/terraform-azurerm-v3//github_federated_identity?ref=v7.50.1"

  prefix    = var.prefix
  env_short = var.env_short
  domain    = var.domain

  identity_role = "cd"

  github_federations = var.cd_github_federations

  cd_rbac_roles = {
    subscription_roles = var.environment_cd_roles.subscription
    resource_groups    = var.environment_cd_roles.resource_groups
  }

  tags = var.tags

  depends_on = [
    azurerm_resource_group.identity_rg
  ]
}

module "identity_cd_ms" {
  source = "github.com/pagopa/terraform-azurerm-v3//github_federated_identity?ref=v7.50.1"

  prefix    = var.prefix
  env_short = var.env_short
  domain    = "ms"

  identity_role = "cd"

  github_federations = var.cd_github_federations_ms

  cd_rbac_roles = {
    subscription_roles = var.environment_cd_roles_ms.subscription
    resource_groups    = var.environment_cd_roles_ms.resource_groups
  }

  tags = var.tags

  depends_on = [
    azurerm_resource_group.identity_rg
  ]
}
