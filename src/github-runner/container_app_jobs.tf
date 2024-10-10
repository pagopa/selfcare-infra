module "container_app_job" {
  source = "github.com/pagopa/terraform-azurerm-v3.git//container_app_job_gh_runner?ref=v8.48.0"

  location  = var.location
  prefix    = var.prefix
  env_short = var.env_short

  key_vault = {
    resource_group_name = data.azurerm_key_vault.key_vault_common.resource_group_name
    name                = data.azurerm_key_vault.key_vault_common.name
    secret_name         = var.key_vault.pat_secret_name
  }

  environment = {
    name                = module.container_app_environment_runner.name
    resource_group_name = module.container_app_environment_runner.resource_group_name
  }

  job = {
    name = "infra"
    repo = "selfcare-infra"
  }

  runner_labels = [local.environment[var.env_short]]

  tags = var.tags
}
