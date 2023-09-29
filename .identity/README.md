# identity

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.45.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_federated_identity_credential.environment_cd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/federated_identity_credential) | resource |
| [azurerm_federated_identity_credential.environment_ci](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/federated_identity_credential) | resource |
| [azurerm_resource_group.identity_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.environment_cd_subscription](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.environment_ci_subscription](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_user_assigned_identity.this_cd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_user_assigned_identity.this_ci](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | Environment | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_environment_cd_roles"></a> [environment\_cd\_roles](#input\_environment\_cd\_roles) | GitHub Continous Delivery roles | <pre>object({<br>    subscription = list(string)<br>  })</pre> | n/a | yes |
| <a name="input_environment_ci_roles"></a> [environment\_ci\_roles](#input\_environment\_ci\_roles) | GitHub Continous Integration roles | <pre>object({<br>    subscription = list(string)<br>  })</pre> | n/a | yes |
| <a name="input_github"></a> [github](#input\_github) | GitHub Organization and repository name | <pre>object({<br>    org        = string<br>    repository = string<br>  })</pre> | <pre>{<br>  "org": "pagopa",<br>  "repository": "selfcare-infra"<br>}</pre> | no |
| <a name="input_github-federation"></a> [github-federation](#input\_github-federation) | Static GitHub federation data | <pre>object({<br>    audience = list(string)<br>    issuer   = string<br>  })</pre> | <pre>{<br>  "audience": [<br>    "api://AzureADTokenExchange"<br>  ],<br>  "issuer": "https://token.actions.githubusercontent.com"<br>}</pre> | no |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | n/a | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azure_environment_cd"></a> [azure\_environment\_cd](#output\_azure\_environment\_cd) | n/a |
| <a name="output_azure_environment_ci"></a> [azure\_environment\_ci](#output\_azure\_environment\_ci) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
