# container_app_environments

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Modules

No modules.

## How to use

Make sure your PAT has access to this repository. Then, follow these steps:

- set the subscription: `az account set --subscription "DEV-SelfCare" (or UAT-SelfCare/PROD-SelfCare)`
- run `cd dev/westeurope`
- run `terraform plan`
- run `terraform apply`

## Resources

| Name | Type |
|------|------|
| [azurerm_container_app_environment.cae_pnpg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_environment) | resource |
| [azurerm_container_app_environment.cae_selc](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_environment) | resource |
| [azurerm_management_lock.lock_pnpg_cae](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_lock) | resource |
| [azurerm_management_lock.lock_selc_cae](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_lock) | resource |
| [azurerm_log_analytics_workspace.log_analytics_workspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | Azure region | `string` | n/a | yes |
| <a name="input_pnpg_subnet_id"></a> [pnpg\_subnet\_id](#input\_pnpg\_subnet\_id) | Id of the subnet to use for PNPG Container App Environment | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | SelfCare prefix and short environment | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group where resources will be created | `string` | n/a | yes |
| <a name="input_selc_subnet_id"></a> [selc\_subnet\_id](#input\_selc\_subnet\_id) | Id of the subnet to use for SelfCare Container App Environment | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Resource tags | `map(any)` | n/a | yes |
| <a name="input_zone_redundant"></a> [zone\_redundant](#input\_zone\_redundant) | Enable or not the zone redundancy | `bool` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_container_app_environment_selfcare"></a> [container\_app\_environment\_selfcare](#output\_container\_app\_environment\_selfcare) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
