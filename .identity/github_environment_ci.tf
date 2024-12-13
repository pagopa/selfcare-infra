resource "github_repository_environment" "github_repository_environment_ci" {
  environment = "${var.env}-ci"
  repository  = local.github.repository

  dynamic "reviewers" {
    for_each = (var.github_repository_environment_ci.reviewers_teams == null ? [] : [1])
    content {
      teams = matchkeys(
        data.github_organization_teams.all.teams[*].id,
        data.github_organization_teams.all.teams[*].slug,
        var.github_repository_environment_ci.reviewers_teams
      )
    }
  }

  dynamic "deployment_branch_policy" {
    for_each = local.github.ci_branch_policy_enabled == true ? [1] : []

    content {
      protected_branches     = var.github_repository_environment_ci.protected_branches
      custom_branch_policies = var.github_repository_environment_ci.custom_branch_policies
    }
  }
}

resource "github_repository_environment_deployment_policy" "ci_deployment_policy" {
  count = var.github_repository_environment_ci.branch_pattern == null ? 0 : 1

  repository     = local.github.repository
  environment    = github_repository_environment.github_repository_environment_ci.environment
  branch_pattern = var.github_repository_environment_ci.branch_pattern
}

resource "github_actions_environment_secret" "env_ci_secrets" {
  for_each        = local.env_ci_secrets
  repository      = local.github.repository
  environment     = github_repository_environment.github_repository_environment_ci.environment
  secret_name     = each.key
  plaintext_value = each.value
}


data "azurerm_key_vault_secret" "storage_checkout_account_key" {
  name         = "web-storage-access-key"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

resource "github_actions_environment_secret" "storage_checkout_account_key" {
  repository      = local.github.repository
  environment     = github_repository_environment.github_repository_environment_ci.environment
  secret_name     = "STORAGE_CHECKOUT_ACCOUNT_KEY"
  plaintext_value = data.azurerm_key_vault_secret.storage_checkout_account_key.value
}

data "azurerm_key_vault_secret" "storage_contracts_account_key" {
  name         = "contracts-storage-access-key"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

resource "github_actions_environment_secret" "storage_contracts_account_key" {
  repository      = local.github.repository
  environment     = github_repository_environment.github_repository_environment_ci.environment
  secret_name     = "STORAGE_CONTRACTS_ACCOUNT_KEY"
  plaintext_value = data.azurerm_key_vault_secret.storage_contracts_account_key.value
}
