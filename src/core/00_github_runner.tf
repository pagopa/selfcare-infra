module "github_runner" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//container_app_job_gh_runner?ref=v7.12.0"

  location  = var.location
  prefix    = var.prefix
  env_short = var.env_short

  key_vault = {
    resource_group_name = module.key_vault.resource_group_name
    name                = module.key_vault.name
    secret_name         = var.gh_runner_pat_secret_name
  }

  network = {
    rg_vnet      = module.vnet.resource_group_name
    vnet         = module.vnet.name
    cidr_subnets = var.cidr_subnet_gh_runner
  }

  environment = {
    workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.workspace_id
    customerId   = azurerm_log_analytics_workspace.log_analytics_workspace.workspace_id
    sharedKey    = azurerm_log_analytics_workspace.log_analytics_workspace.primary_shared_key
  }

  app = {
    repos = [
      "selfcare-infra"
    ]
  }

  tags = var.tags
}
