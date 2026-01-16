module "container_app_job" {
  source = "github.com/pagopa/terraform-azurerm-v4.git//container_app_job_gh_runner?ref=v8.2.0"
  resource_group_name = "selc-${var.env_short}-github-runner-rg"

  location  = var.location
  prefix    = var.prefix
  env_short = var.env_short

  key_vault_rg          = data.azurerm_key_vault.key_vault_common.resource_group_name
  key_vault_name        = data.azurerm_key_vault.key_vault_common.name
  key_vault_secret_name = var.key_vault.pat_secret_name

  environment_name = module.container_app_environment_runner.name
  environment_rg   = module.container_app_environment_runner.resource_group_name

  job = {
    name = "infra"
  }

  job_meta = {
    repo = "selfcare-infra"
  }

  runner_labels = [local.environment[var.env_short]]

  tags = var.tags
}
