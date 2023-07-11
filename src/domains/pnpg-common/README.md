<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | = 2.33.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.45.0 |
| <a name="requirement_pkcs12"></a> [pkcs12](#requirement\_pkcs12) | 0.0.7 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_agid_spid"></a> [agid\_spid](#module\_agid\_spid) | git::https://github.com/pagopa/terraform-azurerm-v3.git//jwt_keys | refs/remotes/origin/jwt_cert_allowed_uses_as_variable |
| <a name="module_cosmosdb_account_mongodb"></a> [cosmosdb\_account\_mongodb](#module\_cosmosdb\_account\_mongodb) | git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_account | v5.3.0 |
| <a name="module_cosmosdb_mongodb_snet"></a> [cosmosdb\_mongodb\_snet](#module\_cosmosdb\_mongodb\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v5.3.0 |
| <a name="module_jwt_auth"></a> [jwt\_auth](#module\_jwt\_auth) | git::https://github.com/pagopa/terraform-azurerm-v3.git//jwt_keys | v5.3.0 |
| <a name="module_jwt_exchange"></a> [jwt\_exchange](#module\_jwt\_exchange) | git::https://github.com/pagopa/terraform-azurerm-v3.git//jwt_keys | v5.3.0 |
| <a name="module_key_vault_pnpg"></a> [key\_vault\_pnpg](#module\_key\_vault\_pnpg) | git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault | v5.3.0 |
| <a name="module_logs_storage_snet"></a> [logs\_storage\_snet](#module\_logs\_storage\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v5.3.0 |
| <a name="module_mongdb_collection_products"></a> [mongdb\_collection\_products](#module\_mongdb\_collection\_products) | git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_mongodb_collection | v5.3.0 |
| <a name="module_mongdb_collection_user-groups"></a> [mongdb\_collection\_user-groups](#module\_mongdb\_collection\_user-groups) | git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_mongodb_collection | v5.3.0 |
| <a name="module_pnpg_checkout_cdn"></a> [pnpg\_checkout\_cdn](#module\_pnpg\_checkout\_cdn) | git::https://github.com/pagopa/terraform-azurerm-v3.git//cdn | v5.3.0 |
| <a name="module_redis"></a> [redis](#module\_redis) | git::https://github.com/pagopa/terraform-azurerm-v3.git//redis_cache | v5.3.0 |
| <a name="module_redis_snet"></a> [redis\_snet](#module\_redis\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v5.3.0 |
| <a name="module_selc_logs_storage"></a> [selc\_logs\_storage](#module\_selc\_logs\_storage) | git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account | v5.3.0 |
| <a name="module_selc_ms_core_collections"></a> [selc\_ms\_core\_collections](#module\_selc\_ms\_core\_collections) | git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_mongodb_collection | v5.3.0 |
| <a name="module_spid-test-env"></a> [spid-test-env](#module\_spid-test-env) | ./modules/spid_testenv | n/a |
| <a name="module_spid_logs_encryption_keys"></a> [spid\_logs\_encryption\_keys](#module\_spid\_logs\_encryption\_keys) | git::https://github.com/pagopa/terraform-azurerm-v3.git//jwt_keys | v5.3.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_api_management_certificate.jwt_certificate](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_certificate) | resource |
| [azurerm_cosmosdb_mongo_database.selc_ms_core](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_mongo_database) | resource |
| [azurerm_cosmosdb_mongo_database.selc_product](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_mongo_database) | resource |
| [azurerm_cosmosdb_mongo_database.selc_user_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_mongo_database) | resource |
| [azurerm_key_vault_access_policy.ad_admin_group_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_developers_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_externals_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.api_management_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_iac_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_secret.cdn__storage_access_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.cdn_fqdn](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.cdn_storage_blob_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.cdn_storage_blob_primary_web_host](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.cdn_storage_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.cosmosdb_account_mongodb_connection_strings](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.redis_primary_access_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.selc_logs_storage_access_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.selc_logs_storage_blob_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.selc_logs_storage_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_management_lock.mongodb_selc_ms_core](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_lock) | resource |
| [azurerm_private_endpoint.logs_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_resource_group.checkout_fe_pnpg_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.mongodb_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_logs_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.sec_rg_pnpg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_container.selc_logs_container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [null_resource.upload_jwks](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [pkcs12_from_pem.jwt_pkcs12](https://registry.terraform.io/providers/chilicat/pkcs12/0.0.7/docs/resources/from_pem) | resource |
| [azuread_group.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azuread/2.33.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/2.33.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/2.33.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_security](https://registry.terraform.io/providers/hashicorp/azuread/2.33.0/docs/data-sources/group) | data source |
| [azuread_service_principal.iac_principal](https://registry.terraform.io/providers/hashicorp/azuread/2.33.0/docs/data-sources/service_principal) | data source |
| [azurerm_api_management.api_management_core](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_dns_zone.selfcare_public](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/dns_zone) | data source |
| [azurerm_log_analytics_workspace.log_analytics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_private_dns_zone.privatelink_blob_core_windows_net](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_mongo_cosmos_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_redis_cache_windows_net_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.private_endpoint_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.vnet_core](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_subnet_logs_storage"></a> [cidr\_subnet\_logs\_storage](#input\_cidr\_subnet\_logs\_storage) | Logs storage address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_pnpg_cosmosdb_mongodb"></a> [cidr\_subnet\_pnpg\_cosmosdb\_mongodb](#input\_cidr\_subnet\_pnpg\_cosmosdb\_mongodb) | Cosmosdb pnpg address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_redis"></a> [cidr\_subnet\_redis](#input\_cidr\_subnet\_redis) | Redis network address space. | `list(string)` | `[]` | no |
| <a name="input_cosmosdb_mongodb_additional_geo_locations"></a> [cosmosdb\_mongodb\_additional\_geo\_locations](#input\_cosmosdb\_mongodb\_additional\_geo\_locations) | The name of the Azure region to host replicated data and the priority to apply starting from 1. Not used when cosmosdb\_mongodb\_enable\_serverless | <pre>list(object({<br>    location          = string<br>    failover_priority = number<br>    zone_redundant    = bool<br>  }))</pre> | `[]` | no |
| <a name="input_cosmosdb_mongodb_consistency_policy"></a> [cosmosdb\_mongodb\_consistency\_policy](#input\_cosmosdb\_mongodb\_consistency\_policy) | n/a | <pre>object({<br>    consistency_level       = string<br>    max_interval_in_seconds = number<br>    max_staleness_prefix    = number<br>  })</pre> | <pre>{<br>  "consistency_level": "Session",<br>  "max_interval_in_seconds": null,<br>  "max_staleness_prefix": null<br>}</pre> | no |
| <a name="input_cosmosdb_mongodb_enable_autoscaling"></a> [cosmosdb\_mongodb\_enable\_autoscaling](#input\_cosmosdb\_mongodb\_enable\_autoscaling) | It will enable autoscaling mode. If true, cosmosdb\_mongodb\_throughput must be unset | `bool` | `false` | no |
| <a name="input_cosmosdb_mongodb_enable_free_tier"></a> [cosmosdb\_mongodb\_enable\_free\_tier](#input\_cosmosdb\_mongodb\_enable\_free\_tier) | Enable Free Tier pricing option for this Cosmos DB account | `bool` | `false` | no |
| <a name="input_cosmosdb_mongodb_extra_capabilities"></a> [cosmosdb\_mongodb\_extra\_capabilities](#input\_cosmosdb\_mongodb\_extra\_capabilities) | Enable cosmosdb extra capabilities | `list(string)` | `[]` | no |
| <a name="input_cosmosdb_mongodb_main_geo_location_zone_redundant"></a> [cosmosdb\_mongodb\_main\_geo\_location\_zone\_redundant](#input\_cosmosdb\_mongodb\_main\_geo\_location\_zone\_redundant) | Enable zone redundant Comsmos DB | `bool` | n/a | yes |
| <a name="input_cosmosdb_mongodb_max_throughput"></a> [cosmosdb\_mongodb\_max\_throughput](#input\_cosmosdb\_mongodb\_max\_throughput) | The maximum throughput of the MongoDB database (RU/s). Must be between 4,000 and 1,000,000. Must be set in increments of 1,000. Conflicts with throughput | `number` | `4000` | no |
| <a name="input_cosmosdb_mongodb_offer_type"></a> [cosmosdb\_mongodb\_offer\_type](#input\_cosmosdb\_mongodb\_offer\_type) | Specifies the Offer Type to use for this CosmosDB Account - currently this can only be set to Standard | `string` | n/a | yes |
| <a name="input_cosmosdb_mongodb_private_endpoint_enabled"></a> [cosmosdb\_mongodb\_private\_endpoint\_enabled](#input\_cosmosdb\_mongodb\_private\_endpoint\_enabled) | Enable private endpoint for Comsmos DB | `bool` | `true` | no |
| <a name="input_cosmosdb_mongodb_public_network_access_enabled"></a> [cosmosdb\_mongodb\_public\_network\_access\_enabled](#input\_cosmosdb\_mongodb\_public\_network\_access\_enabled) | Whether or not public network access is allowed for this CosmosDB account | `bool` | `false` | no |
| <a name="input_cosmosdb_mongodb_throughput"></a> [cosmosdb\_mongodb\_throughput](#input\_cosmosdb\_mongodb\_throughput) | The throughput of the MongoDB database (RU/s). Must be set in increments of 100. The minimum value is 400. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply. | `number` | `400` | no |
| <a name="input_dns_zone_prefix"></a> [dns\_zone\_prefix](#input\_dns\_zone\_prefix) | The dns subdomain. E.g: selfcare | `string` | n/a | yes |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_enable_spid_test"></a> [enable\_spid\_test](#input\_enable\_spid\_test) | to provision italia/spid-testenv2:1.1.0 | `bool` | `false` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation. E.g pagopa.it | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input\_instance) | One of beta, prod01, prod02 | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | Specifies the name of the Log Analytics Workspace. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_resource_group_name"></a> [log\_analytics\_workspace\_resource\_group\_name](#input\_log\_analytics\_workspace\_resource\_group\_name) | The name of the resource group in which the Log Analytics workspace is located in. | `string` | n/a | yes |
| <a name="input_logs_account_replication_type"></a> [logs\_account\_replication\_type](#input\_logs\_account\_replication\_type) | logs replication type | `string` | n/a | yes |
| <a name="input_logs_advanced_threat_protection"></a> [logs\_advanced\_threat\_protection](#input\_logs\_advanced\_threat\_protection) | Enable logs threat advanced protection | `bool` | `false` | no |
| <a name="input_logs_delete_retention_days"></a> [logs\_delete\_retention\_days](#input\_logs\_delete\_retention\_days) | Number of days to retain deleted logs | `number` | n/a | yes |
| <a name="input_logs_enable_versioning"></a> [logs\_enable\_versioning](#input\_logs\_enable\_versioning) | Enable logs versioning | `bool` | n/a | yes |
| <a name="input_monitor_resource_group_name"></a> [monitor\_resource\_group\_name](#input\_monitor\_resource\_group\_name) | Monitor resource group name | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_redis_capacity"></a> [redis\_capacity](#input\_redis\_capacity) | # Redis cache | `number` | `1` | no |
| <a name="input_redis_family"></a> [redis\_family](#input\_redis\_family) | n/a | `string` | `"C"` | no |
| <a name="input_redis_private_endpoint_enabled"></a> [redis\_private\_endpoint\_enabled](#input\_redis\_private\_endpoint\_enabled) | n/a | `bool` | `true` | no |
| <a name="input_redis_sku_name"></a> [redis\_sku\_name](#input\_redis\_sku\_name) | n/a | `string` | `"Standard"` | no |
| <a name="input_robots_indexed_paths"></a> [robots\_indexed\_paths](#input\_robots\_indexed\_paths) | List of cdn paths to allow robots index | `list(string)` | n/a | yes |
| <a name="input_spa"></a> [spa](#input\_spa) | spa root dirs | `list(string)` | <pre>[<br>  "auth",<br>  "onboarding",<br>  "dashboard"<br>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "CreatedBy": "Terraform"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azurerm_api_management_certificate_jwt_certificate_thumbprint"></a> [azurerm\_api\_management\_certificate\_jwt\_certificate\_thumbprint](#output\_azurerm\_api\_management\_certificate\_jwt\_certificate\_thumbprint) | n/a |
| <a name="output_jwt_auth_jwt_kid"></a> [jwt\_auth\_jwt\_kid](#output\_jwt\_auth\_jwt\_kid) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
