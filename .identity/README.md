# identity

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.45.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_identity-cd"></a> [identity-cd](#module\_identity-cd) | github.com/pagopa/terraform-azurerm-v3//github_federated_identity | gh-identity-module |
| <a name="module_identity-ci"></a> [identity-ci](#module\_identity-ci) | github.com/pagopa/terraform-azurerm-v3//github_federated_identity | gh-identity-module |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.identity_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cd_github_federations"></a> [cd\_github\_federations](#input\_cd\_github\_federations) | GitHub Organization, repository name and scope permissions | <pre>list(object({<br>    repository        = string<br>    credentials_scope = optional(string, "environment")<br>    subject           = string<br>  }))</pre> | n/a | yes |
| <a name="input_ci_github_federations"></a> [ci\_github\_federations](#input\_ci\_github\_federations) | GitHub Organization, repository name and scope permissions | <pre>list(object({<br>    repository        = string<br>    credentials_scope = optional(string, "environment")<br>    subject           = string<br>  }))</pre> | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_environment_cd_roles"></a> [environment\_cd\_roles](#input\_environment\_cd\_roles) | GitHub Continous Delivery roles | <pre>object({<br>    subscription    = list(string)<br>    resource_groups = map(list(string))<br>  })</pre> | n/a | yes |
| <a name="input_environment_ci_roles"></a> [environment\_ci\_roles](#input\_environment\_ci\_roles) | GitHub Continous Integration roles | <pre>object({<br>    subscription    = list(string)<br>    resource_groups = map(list(string))<br>  })</pre> | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "CreatedBy": "Terraform"<br>}</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
