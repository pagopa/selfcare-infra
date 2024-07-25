data "github_repository" "repo" {
  full_name = "pagopa/selfcare-infra"
}

resource "github_repository_environment" "github_repository_environment_cd" {
  environment = "${var.env}-cd"
  repository  = data.github_repository.repo.name
}

resource "github_actions_environment_secret" "github_cd_secrets_storage" {
  repository       = data.github_repository.repo.name
  environment      = github_repository_environment.github_repository_environment_cd.environment
  secret_name      = "STORAGE_CONTRACTS_ACCOUNT_KEY"
  plaintext_value  = azurerm_key_vault_secret.selc_contracts_storage_access_key.value
}
