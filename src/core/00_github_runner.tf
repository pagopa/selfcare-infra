resource "azurerm_resource_group" "github_runner" {
  name     = "${local.project}-github-runner-rg"
  location = var.location

  tags = var.tags
}

resource "azurerm_subnet" "github_runner" {
  name                 = "${local.project}-github-runner-snet"
  resource_group_name  = azurerm_resource_group.rg_vnet.name
  virtual_network_name = module.vnet.name
  address_prefixes     = var.cidr_subnet_gh_runner
  service_endpoints    = []
}

module "github_runner" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//container_app_environment?ref=v6.15.0"

  name                      = "${local.project}-github-runner-cae"
  resource_group_name       = azurerm_resource_group.github_runner.name
  location                  = var.location
  vnet_internal             = true
  subnet_id                 = azurerm_subnet.github_runner.id
  log_destination           = "log-analytics"
  log_analytics_customer_id = azurerm_log_analytics_workspace.log_analytics_workspace.workspace_id
  log_analytics_shared_key  = azurerm_log_analytics_workspace.log_analytics_workspace.primary_shared_key
  zone_redundant            = true

  tags = var.tags
}

locals {
  repo_owner = "pagopa"
  repo_name  = "selfcare-infra"
  image_name = "ghcr.io/pagopa/github-self-hosted-runner-azure:beta-dockerfile-v2@sha256:ed51ac419d78b6410be96ecaa8aa8dbe645aa0309374132886412178e2739a47"
}

data "azurerm_key_vault_secret" "github_pat_selfcare_infra" {
  name         = "github-pat-selfcare-infra"
  key_vault_id = module.key_vault.id
}

resource "azapi_resource" "github_runner_job" {
  type      = "Microsoft.App/jobs@2023-05-01"
  name      = "${local.project}-github-runner-job"
  location  = var.location
  parent_id = azurerm_resource_group.github_runner.id

  body = jsonencode({
    properties = {
      configuration = {
        replicaRetryLimit = 1
        replicaTimeout    = 1800
        eventTriggerConfig = {
          parallelism            = 1
          replicaCompletionCount = 1
          scale = {
            maxExecutions   = 10
            minExecutions   = 0
            pollingInterval = 20
            rules = [
              {
                name = "github-runner"
                type = "github-runner"
                metadata = {
                  github_runner             = "https://api.github.com"
                  owner                     = local.repo_owner
                  runnerScope               = "repo"
                  repos                     = local.repo_name
                  targetWorkflowQueueLength = "1"
                }
                auth = [
                  {
                    secretRef        = "personal-access-token"
                    triggerParameter = "personalAccessToken"
                  }
                ]
              }
            ]
          }
        }
        secrets = [
          {
            name  = "personal-access-token"
            value = "${data.azurerm_key_vault_secret.github_pat_selfcare_infra.value}"
          }
        ]
        triggerType = "Event"
      }
      environmentId = module.github_runner.id
      template = {
        containers = [
          {
            env = [
              {
                name      = "GITHUB_PAT"
                secretRef = "personal-access-token"
              },
              {
                name  = "REPO_URL"
                value = "https://github.com/${local.repo_owner}/${local.repo_name}"
              },
              {
                name  = "REGISTRATION_TOKEN_API_URL"
                value = "https://api.github.com/repos/${local.repo_owner}/${local.repo_name}/actions/runners/registration-token"
              }
            ]
            image = local.image_name
            name  = "github-actions-runner-job"
            resources = {
              cpu    = 0.5
              memory = "1Gi"
            }
          }
      ] }
    }
  })
}
