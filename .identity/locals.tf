locals {
  project = "${var.prefix}-${var.env_short}"

  github = {
    org        = "pagopa"
    repository = "selfcare-infra"

    ci_branch_policy_enabled = var.github_repository_environment_ci.protected_branches == true || var.github_repository_environment_ci.custom_branch_policies == true
    cd_branch_policy_enabled = var.github_repository_environment_cd.protected_branches == true || var.github_repository_environment_cd.custom_branch_policies == true
  }

  env_ci_secrets = {
    "AZURE_CLIENT_ID_CI"    = module.identity_ci.identity_client_id
    "AZURE_SUBSCRIPTION_ID" = data.azurerm_client_config.current.subscription_id
    "AZURE_TENANT_ID"       = data.azurerm_client_config.current.tenant_id,
  }

  env_cd_secrets = {
    "AZURE_CLIENT_ID_CD"    = module.identity_cd.identity_client_id
    "AZURE_SUBSCRIPTION_ID" = data.azurerm_client_config.current.subscription_id
    "AZURE_TENANT_ID"       = data.azurerm_client_config.current.tenant_id,
  }
}
