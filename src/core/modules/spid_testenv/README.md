# spid_testenv

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_container_group.spid_testenv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_group) | resource |
| [azurerm_resource_group.rg_spid_testenv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_account.spid_testenv_storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_share.spid_testenv_caddy_storage_share](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share) | resource |
| [azurerm_storage_share.spid_testenv_storage_share](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share) | resource |
| [local_file.spid_testenv_config](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [null_resource.upload_config_spid_testenv](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_spid_test"></a> [enable\_spid\_test](#input\_enable\_spid\_test) | spid-testenv specific variables | `bool` | n/a | yes |
| <a name="input_hub_spid_login_metadata_url"></a> [hub\_spid\_login\_metadata\_url](#input\_hub\_spid\_login\_metadata\_url) | n/a | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | General Variables | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_password"></a> [password](#input\_password) | n/a | `string` | n/a | yes |
| <a name="input_spid_testenv_local_config_dir"></a> [spid\_testenv\_local\_config\_dir](#input\_spid\_testenv\_local\_config\_dir) | n/a | `string` | n/a | yes |
| <a name="input_subscription_name"></a> [subscription\_name](#input\_subscription\_name) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_container_id"></a> [container\_id](#output\_container\_id) | The id of the spid\_testenv container. |
| <a name="output_spid_testenv_url"></a> [spid\_testenv\_url](#output\_spid\_testenv\_url) | The id of the spid\_testenv container. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
