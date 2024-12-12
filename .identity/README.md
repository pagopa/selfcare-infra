# identity

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.116.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | 5.45.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_identity_cd"></a> [identity\_cd](#module\_identity\_cd) | github.com/pagopa/terraform-azurerm-v3//github_federated_identity | v8.49.1 |
| <a name="module_identity_cd_ms"></a> [identity\_cd\_ms](#module\_identity\_cd\_ms) | github.com/pagopa/terraform-azurerm-v3//github_federated_identity | v8.49.1 |
| <a name="module_identity_ci"></a> [identity\_ci](#module\_identity\_ci) | github.com/pagopa/terraform-azurerm-v3//github_federated_identity | v8.49.1 |
| <a name="module_identity_ci_ms"></a> [identity\_ci\_ms](#module\_identity\_ci\_ms) | github.com/pagopa/terraform-azurerm-v3//github_federated_identity | v8.49.1 |

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault_access_policy.key_vault_access_policy_identity_cd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.key_vault_access_policy_identity_ci](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.key_vault_access_policy_pnpg_identity_cd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.key_vault_access_policy_pnpg_identity_ci](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_resource_group.identity_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_definition.apim_integration_reader](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_definition) | resource |
| [azurerm_role_definition.container_apps_jobs_reader](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_definition) | resource |
| [github_actions_environment_secret.env_cd_secrets](https://registry.terraform.io/providers/integrations/github/5.45.0/docs/resources/actions_environment_secret) | resource |
| [github_actions_environment_secret.env_ci_secrets](https://registry.terraform.io/providers/integrations/github/5.45.0/docs/resources/actions_environment_secret) | resource |
| [github_actions_environment_secret.storage_checkout_account_key](https://registry.terraform.io/providers/integrations/github/5.45.0/docs/resources/actions_environment_secret) | resource |
| [github_actions_environment_secret.storage_contracts_account_key](https://registry.terraform.io/providers/integrations/github/5.45.0/docs/resources/actions_environment_secret) | resource |
| [github_branch_default.default_main](https://registry.terraform.io/providers/integrations/github/5.45.0/docs/resources/branch_default) | resource |
| [github_branch_protection_v3.protection_main](https://registry.terraform.io/providers/integrations/github/5.45.0/docs/resources/branch_protection_v3) | resource |
| [github_repository_environment.github_repository_environment_cd](https://registry.terraform.io/providers/integrations/github/5.45.0/docs/resources/repository_environment) | resource |
| [github_repository_environment.github_repository_environment_ci](https://registry.terraform.io/providers/integrations/github/5.45.0/docs/resources/repository_environment) | resource |
| [github_repository_environment_deployment_policy.cd_deployment_policy](https://registry.terraform.io/providers/integrations/github/5.45.0/docs/resources/repository_environment_deployment_policy) | resource |
| [github_repository_environment_deployment_policy.ci_deployment_policy](https://registry.terraform.io/providers/integrations/github/5.45.0/docs/resources/repository_environment_deployment_policy) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_key_vault.key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault.key_vault_pnpg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.storage_checkout_account_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.storage_contracts_account_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [github_organization_teams.all](https://registry.terraform.io/providers/integrations/github/5.45.0/docs/data-sources/organization_teams) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cd_github_federations"></a> [cd\_github\_federations](#input\_cd\_github\_federations) | GitHub Organization, repository name and scope permissions | <pre>list(object({<br/>    repository        = string<br/>    credentials_scope = optional(string, "environment")<br/>    subject           = string<br/>  }))</pre> | n/a | yes |
| <a name="input_cd_github_federations_ms"></a> [cd\_github\_federations\_ms](#input\_cd\_github\_federations\_ms) | GitHub Organization, repository name and scope permissions | <pre>list(object({<br/>    repository        = string<br/>    credentials_scope = optional(string, "environment")<br/>    subject           = string<br/>  }))</pre> | n/a | yes |
| <a name="input_ci_github_federations"></a> [ci\_github\_federations](#input\_ci\_github\_federations) | GitHub Organization, repository name and scope permissions | <pre>list(object({<br/>    repository        = string<br/>    credentials_scope = optional(string, "environment")<br/>    subject           = string<br/>  }))</pre> | n/a | yes |
| <a name="input_ci_github_federations_ms"></a> [ci\_github\_federations\_ms](#input\_ci\_github\_federations\_ms) | GitHub Organization, repository name and scope permissions | <pre>list(object({<br/>    repository        = string<br/>    credentials_scope = optional(string, "environment")<br/>    subject           = string<br/>  }))</pre> | n/a | yes |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | `"infra"` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_environment_cd_roles"></a> [environment\_cd\_roles](#input\_environment\_cd\_roles) | GitHub Continous Delivery roles | <pre>object({<br/>    subscription    = list(string)<br/>    resource_groups = map(list(string))<br/>  })</pre> | n/a | yes |
| <a name="input_environment_cd_roles_ms"></a> [environment\_cd\_roles\_ms](#input\_environment\_cd\_roles\_ms) | GitHub Continous Delivery roles | <pre>object({<br/>    subscription    = list(string)<br/>    resource_groups = map(list(string))<br/>  })</pre> | n/a | yes |
| <a name="input_environment_ci_roles"></a> [environment\_ci\_roles](#input\_environment\_ci\_roles) | GitHub Continous Integration roles | <pre>object({<br/>    subscription    = list(string)<br/>    resource_groups = map(list(string))<br/>  })</pre> | n/a | yes |
| <a name="input_environment_ci_roles_ms"></a> [environment\_ci\_roles\_ms](#input\_environment\_ci\_roles\_ms) | GitHub Continous Integration roles | <pre>object({<br/>    subscription    = list(string)<br/>    resource_groups = map(list(string))<br/>  })</pre> | n/a | yes |
| <a name="input_github_repository_environment_cd"></a> [github\_repository\_environment\_cd](#input\_github\_repository\_environment\_cd) | GitHub Continous Delivery roles | <pre>object({<br/>    protected_branches     = bool<br/>    custom_branch_policies = bool<br/>    reviewers_teams        = optional(list(string), [])<br/>    branch_pattern         = optional(string, null)<br/>  })</pre> | n/a | yes |
| <a name="input_github_repository_environment_ci"></a> [github\_repository\_environment\_ci](#input\_github\_repository\_environment\_ci) | GitHub Continous Integration roles | <pre>object({<br/>    protected_branches     = bool<br/>    custom_branch_policies = bool<br/>    reviewers_teams        = optional(list(string), [])<br/>    branch_pattern         = optional(string, null)<br/>  })</pre> | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br/>  "CreatedBy": "Terraform"<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_subscription_id"></a> [subscription\_id](#output\_subscription\_id) | n/a |
| <a name="output_tenant_id"></a> [tenant\_id](#output\_tenant\_id) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
