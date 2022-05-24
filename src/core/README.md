<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | = 2.5.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | = 2.99.0 |
| <a name="requirement_pkcs12"></a> [pkcs12](#requirement\_pkcs12) | 0.0.7 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 2.5.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.99.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.1.0 |
| <a name="provider_pkcs12"></a> [pkcs12](#provider\_pkcs12) | 0.0.7 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_acr"></a> [acr](#module\_acr) | git::https://github.com/pagopa/azurerm.git//container_registry | v1.0.58 |
| <a name="module_agid_spid"></a> [agid\_spid](#module\_agid\_spid) | git::https://github.com/pagopa/azurerm.git//jwt_keys | v2.7.0 |
| <a name="module_aks"></a> [aks](#module\_aks) | git::https://github.com/pagopa/azurerm.git//kubernetes_cluster | v2.15.1 |
| <a name="module_apim"></a> [apim](#module\_apim) | git::https://github.com/pagopa/azurerm.git//api_management | v2.12.5 |
| <a name="module_apim_snet"></a> [apim\_snet](#module\_apim\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v2.12.5 |
| <a name="module_apim_uservice_party_management_v1"></a> [apim\_uservice\_party\_management\_v1](#module\_apim\_uservice\_party\_management\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.12.5 |
| <a name="module_apim_uservice_party_process_v1"></a> [apim\_uservice\_party\_process\_v1](#module\_apim\_uservice\_party\_process\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.12.5 |
| <a name="module_app_gw"></a> [app\_gw](#module\_app\_gw) | git::https://github.com/pagopa/azurerm.git//app_gateway | v2.9.0 |
| <a name="module_appgateway_snet"></a> [appgateway\_snet](#module\_appgateway\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.58 |
| <a name="module_azdoa_li"></a> [azdoa\_li](#module\_azdoa\_li) | git::https://github.com/pagopa/azurerm.git//azure_devops_agent | v1.0.58 |
| <a name="module_azdoa_snet"></a> [azdoa\_snet](#module\_azdoa\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.58 |
| <a name="module_checkout_cdn"></a> [checkout\_cdn](#module\_checkout\_cdn) | git::https://github.com/pagopa/azurerm.git//cdn | v2.7.0 |
| <a name="module_contracts_storage_snet"></a> [contracts\_storage\_snet](#module\_contracts\_storage\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.60 |
| <a name="module_cosmosdb_account_mongodb"></a> [cosmosdb\_account\_mongodb](#module\_cosmosdb\_account\_mongodb) | git::https://github.com/pagopa/azurerm.git//cosmosdb | v2.0.19 |
| <a name="module_cosmosdb_mongodb_snet"></a> [cosmosdb\_mongodb\_snet](#module\_cosmosdb\_mongodb\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.58 |
| <a name="module_dns_forwarder"></a> [dns\_forwarder](#module\_dns\_forwarder) | git::https://github.com/pagopa/azurerm.git//dns_forwarder | v2.0.8 |
| <a name="module_dns_forwarder_snet"></a> [dns\_forwarder\_snet](#module\_dns\_forwarder\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v2.0.3 |
| <a name="module_jwt"></a> [jwt](#module\_jwt) | git::https://github.com/pagopa/azurerm.git//jwt_keys | v2.7.0 |
| <a name="module_jwt_exchange"></a> [jwt\_exchange](#module\_jwt\_exchange) | git::https://github.com/pagopa/azurerm.git//jwt_keys | v2.7.0 |
| <a name="module_k8s_snet"></a> [k8s\_snet](#module\_k8s\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v2.1.15 |
| <a name="module_key_vault"></a> [key\_vault](#module\_key\_vault) | git::https://github.com/pagopa/azurerm.git//key_vault | v1.0.90 |
| <a name="module_mongdb_collection_products"></a> [mongdb\_collection\_products](#module\_mongdb\_collection\_products) | git::https://github.com/pagopa/azurerm.git//cosmosdb_mongodb_collection | v2.3.0 |
| <a name="module_mongdb_collection_user-groups"></a> [mongdb\_collection\_user-groups](#module\_mongdb\_collection\_user-groups) | git::https://github.com/pagopa/azurerm.git//cosmosdb_mongodb_collection | v2.3.0 |
| <a name="module_monitor"></a> [monitor](#module\_monitor) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.12.5 |
| <a name="module_postgres_snet"></a> [postgres\_snet](#module\_postgres\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.60 |
| <a name="module_postgresql"></a> [postgresql](#module\_postgresql) | git::https://github.com/pagopa/azurerm.git//postgresql_server | v1.0.79 |
| <a name="module_redis"></a> [redis](#module\_redis) | git::https://github.com/pagopa/azurerm.git//redis_cache | v2.0.11 |
| <a name="module_redis_snet"></a> [redis\_snet](#module\_redis\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.58 |
| <a name="module_selc-contracts-storage"></a> [selc-contracts-storage](#module\_selc-contracts-storage) | git::https://github.com/pagopa/azurerm.git//storage_account | v2.7.0 |
| <a name="module_spid-test-env"></a> [spid-test-env](#module\_spid-test-env) | ../modules/spid_testenv | n/a |
| <a name="module_vnet"></a> [vnet](#module\_vnet) | git::https://github.com/pagopa/azurerm.git//virtual_network | v1.0.58 |
| <a name="module_vpn"></a> [vpn](#module\_vpn) | git::https://github.com/pagopa/azurerm.git//vpn_gateway | v2.0.11 |
| <a name="module_vpn_snet"></a> [vpn\_snet](#module\_vpn\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.58 |
| <a name="module_web_test_api"></a> [web\_test\_api](#module\_web\_test\_api) | git::https://github.com/pagopa/azurerm.git//application_insights_web_test_preview | v2.0.18 |

## Resources

| Name | Type |
|------|------|
| [azurerm_api_management_api_version_set.apim_uservice_party_management](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.apim_uservice_party_process](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_certificate.jwt_certificate](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_certificate) | resource |
| [azurerm_api_management_custom_domain.api_custom_domain](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_custom_domain) | resource |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/application_insights) | resource |
| [azurerm_cosmosdb_mongo_collection.products](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/cosmosdb_mongo_collection) | resource |
| [azurerm_cosmosdb_mongo_database.selc_product](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/cosmosdb_mongo_database) | resource |
| [azurerm_cosmosdb_mongo_database.selc_user_group](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/cosmosdb_mongo_database) | resource |
| [azurerm_dns_a_record.dns_a_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_a_record) | resource |
| [azurerm_dns_caa_record.caa_selfcare](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_caa_record) | resource |
| [azurerm_dns_ns_record.dev_selfcare](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_ns_record) | resource |
| [azurerm_dns_ns_record.io_selfcare](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_ns_record) | resource |
| [azurerm_dns_ns_record.uat_selfcare](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_ns_record) | resource |
| [azurerm_dns_zone.selfcare_public](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_zone) | resource |
| [azurerm_key_vault_access_policy.adgroup_admin_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_developers_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_externals_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_security_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.api_management_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.app_gateway_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_iac_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdo_sp_tls_cert](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azure_cdn_frontdoor_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_secret.application_insights_key](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.cosmosdb_account_mongodb_connection_strings](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.redis_primary_access_key](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.selc_contracts_storage_access_key](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.selc_contracts_storage_blob_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.selc_contracts_storage_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.selc_web_storage_access_key](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.selc_web_storage_blob_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.selc_web_storage_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_secret) | resource |
| [azurerm_log_analytics_workspace.log_analytics_workspace](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/log_analytics_workspace) | resource |
| [azurerm_management_lock.mongodb_selc_product](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/management_lock) | resource |
| [azurerm_management_lock.mongodb_selc_user_group](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/management_lock) | resource |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/monitor_action_group) | resource |
| [azurerm_postgresql_database.selc_db](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/postgresql_database) | resource |
| [azurerm_private_dns_zone.privatelink_blob_core_windows_net](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.privatelink_documents_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.privatelink_mongo_cosmos_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.privatelink_redis_cache_windows_net](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_blob_core_windows_net_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_documents_azure_com_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_mongo_cosmos_azure_com_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_redis_cache_windows_net_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_endpoint.contracts_storage](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_endpoint) | resource |
| [azurerm_public_ip.aks_outbound](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/public_ip) | resource |
| [azurerm_public_ip.appgateway_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/public_ip) | resource |
| [azurerm_resource_group.azdo_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.checkout_fe_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.data](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.default_roleassignment_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.mongodb_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.postgres_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_aks](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_contracts_storage](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.sec_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.aks_to_acr](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/role_assignment) | resource |
| [azurerm_storage_container.selc-contracts-container](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/storage_container) | resource |
| [azurerm_user_assigned_identity.appgateway](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/user_assigned_identity) | resource |
| [null_resource.upload_assets](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.upload_contract_templates](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.upload_jwks](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.upload_resources_templates](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [pkcs12_from_pem.jwt_pkcs12](https://registry.terraform.io/providers/chilicat/pkcs12/0.0.7/docs/resources/from_pem) | resource |
| [azuread_application.vpn_app](https://registry.terraform.io/providers/hashicorp/azuread/2.5.0/docs/data-sources/application) | data source |
| [azuread_group.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azuread/2.5.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/2.5.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/2.5.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_security](https://registry.terraform.io/providers/hashicorp/azuread/2.5.0/docs/data-sources/group) | data source |
| [azuread_service_principal.azdo_sp_tls_cert](https://registry.terraform.io/providers/hashicorp/azuread/2.5.0/docs/data-sources/service_principal) | data source |
| [azuread_service_principal.iac_principal](https://registry.terraform.io/providers/hashicorp/azuread/2.5.0/docs/data-sources/service_principal) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/client_config) | data source |
| [azurerm_key_vault_certificate.app_gw_platform](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_certificate) | data source |
| [azurerm_key_vault_secret.apim_publisher_email](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.monitor_notification_email](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.monitor_notification_slack_email](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.postgres_administrator_login](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.postgres_administrator_login_password](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.sec_storage_id](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.sec_workspace_id](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aks_alerts_enabled"></a> [aks\_alerts\_enabled](#input\_aks\_alerts\_enabled) | Aks alert enabled? | `bool` | `true` | no |
| <a name="input_aks_kubernetes_version"></a> [aks\_kubernetes\_version](#input\_aks\_kubernetes\_version) | Kubernetes version for AKS | `string` | n/a | yes |
| <a name="input_aks_metric_alerts"></a> [aks\_metric\_alerts](#input\_aks\_metric\_alerts) | Map of name = criteria objects | <pre>map(object({<br>    # criteria.*.aggregation to be one of [Average Count Minimum Maximum Total]<br>    aggregation = string<br>    # "Insights.Container/pods" "Insights.Container/nodes"<br>    metric_namespace = string<br>    metric_name      = string<br>    # criteria.0.operator to be one of [Equals NotEquals GreaterThan GreaterThanOrEqual LessThan LessThanOrEqual]<br>    operator  = string<br>    threshold = number<br>    # Possible values are PT1M, PT5M, PT15M, PT30M and PT1H<br>    frequency = string<br>    # Possible values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D.<br>    window_size = string<br><br>    dimension = list(object(<br>      {<br>        name     = string<br>        operator = string<br>        values   = list(string)<br>      }<br>    ))<br>  }))</pre> | <pre>{<br>  "container_cpu": {<br>    "aggregation": "Average",<br>    "dimension": [<br>      {<br>        "name": "kubernetes namespace",<br>        "operator": "Include",<br>        "values": [<br>          "*"<br>        ]<br>      },<br>      {<br>        "name": "controllerName",<br>        "operator": "Include",<br>        "values": [<br>          "*"<br>        ]<br>      }<br>    ],<br>    "frequency": "PT1M",<br>    "metric_name": "cpuExceededPercentage",<br>    "metric_namespace": "Insights.Container/containers",<br>    "operator": "GreaterThan",<br>    "threshold": 95,<br>    "window_size": "PT5M"<br>  },<br>  "container_memory": {<br>    "aggregation": "Average",<br>    "dimension": [<br>      {<br>        "name": "kubernetes namespace",<br>        "operator": "Include",<br>        "values": [<br>          "*"<br>        ]<br>      },<br>      {<br>        "name": "controllerName",<br>        "operator": "Include",<br>        "values": [<br>          "*"<br>        ]<br>      }<br>    ],<br>    "frequency": "PT1M",<br>    "metric_name": "memoryWorkingSetExceededPercentage",<br>    "metric_namespace": "Insights.Container/containers",<br>    "operator": "GreaterThan",<br>    "threshold": 95,<br>    "window_size": "PT5M"<br>  },<br>  "container_oom": {<br>    "aggregation": "Average",<br>    "dimension": [<br>      {<br>        "name": "kubernetes namespace",<br>        "operator": "Include",<br>        "values": [<br>          "*"<br>        ]<br>      },<br>      {<br>        "name": "controllerName",<br>        "operator": "Include",<br>        "values": [<br>          "*"<br>        ]<br>      }<br>    ],<br>    "frequency": "PT1M",<br>    "metric_name": "oomKilledContainerCount",<br>    "metric_namespace": "Insights.Container/pods",<br>    "operator": "GreaterThan",<br>    "threshold": 0,<br>    "window_size": "PT1M"<br>  },<br>  "container_restart": {<br>    "aggregation": "Average",<br>    "dimension": [<br>      {<br>        "name": "kubernetes namespace",<br>        "operator": "Include",<br>        "values": [<br>          "*"<br>        ]<br>      },<br>      {<br>        "name": "controllerName",<br>        "operator": "Include",<br>        "values": [<br>          "*"<br>        ]<br>      }<br>    ],<br>    "frequency": "PT1M",<br>    "metric_name": "restartingContainerCount",<br>    "metric_namespace": "Insights.Container/pods",<br>    "operator": "GreaterThan",<br>    "threshold": 0,<br>    "window_size": "PT1M"<br>  },<br>  "node_cpu": {<br>    "aggregation": "Average",<br>    "dimension": [<br>      {<br>        "name": "host",<br>        "operator": "Include",<br>        "values": [<br>          "*"<br>        ]<br>      }<br>    ],<br>    "frequency": "PT1M",<br>    "metric_name": "cpuUsagePercentage",<br>    "metric_namespace": "Insights.Container/nodes",<br>    "operator": "GreaterThan",<br>    "threshold": 80,<br>    "window_size": "PT5M"<br>  },<br>  "node_disk": {<br>    "aggregation": "Average",<br>    "dimension": [<br>      {<br>        "name": "host",<br>        "operator": "Include",<br>        "values": [<br>          "*"<br>        ]<br>      },<br>      {<br>        "name": "device",<br>        "operator": "Include",<br>        "values": [<br>          "*"<br>        ]<br>      }<br>    ],<br>    "frequency": "PT1M",<br>    "metric_name": "DiskUsedPercentage",<br>    "metric_namespace": "Insights.Container/nodes",<br>    "operator": "GreaterThan",<br>    "threshold": 80,<br>    "window_size": "PT5M"<br>  },<br>  "node_memory": {<br>    "aggregation": "Average",<br>    "dimension": [<br>      {<br>        "name": "host",<br>        "operator": "Include",<br>        "values": [<br>          "*"<br>        ]<br>      }<br>    ],<br>    "frequency": "PT1M",<br>    "metric_name": "memoryWorkingSetPercentage",<br>    "metric_namespace": "Insights.Container/nodes",<br>    "operator": "GreaterThan",<br>    "threshold": 80,<br>    "window_size": "PT5M"<br>  },<br>  "node_not_ready": {<br>    "aggregation": "Average",<br>    "dimension": [<br>      {<br>        "name": "status",<br>        "operator": "Include",<br>        "values": [<br>          "NotReady"<br>        ]<br>      }<br>    ],<br>    "frequency": "PT1M",<br>    "metric_name": "nodesCount",<br>    "metric_namespace": "Insights.Container/nodes",<br>    "operator": "GreaterThan",<br>    "threshold": 0,<br>    "window_size": "PT5M"<br>  },<br>  "pods_failed": {<br>    "aggregation": "Average",<br>    "dimension": [<br>      {<br>        "name": "phase",<br>        "operator": "Include",<br>        "values": [<br>          "Failed"<br>        ]<br>      }<br>    ],<br>    "frequency": "PT1M",<br>    "metric_name": "podCount",<br>    "metric_namespace": "Insights.Container/pods",<br>    "operator": "GreaterThan",<br>    "threshold": 0,<br>    "window_size": "PT5M"<br>  },<br>  "pods_ready": {<br>    "aggregation": "Average",<br>    "dimension": [<br>      {<br>        "name": "kubernetes namespace",<br>        "operator": "Include",<br>        "values": [<br>          "*"<br>        ]<br>      },<br>      {<br>        "name": "controllerName",<br>        "operator": "Include",<br>        "values": [<br>          "*"<br>        ]<br>      }<br>    ],<br>    "frequency": "PT1M",<br>    "metric_name": "PodReadyPercentage",<br>    "metric_namespace": "Insights.Container/pods",<br>    "operator": "LessThan",<br>    "threshold": 80,<br>    "window_size": "PT5M"<br>  }<br>}</pre> | no |
| <a name="input_aks_num_outbound_ips"></a> [aks\_num\_outbound\_ips](#input\_aks\_num\_outbound\_ips) | How many outbound ips allocate for AKS cluster | `number` | `1` | no |
| <a name="input_aks_sku_tier"></a> [aks\_sku\_tier](#input\_aks\_sku\_tier) | The SKU Tier that should be used for this Kubernetes Cluster. | `string` | `"Free"` | no |
| <a name="input_aks_system_node_pool_node_count_max"></a> [aks\_system\_node\_pool\_node\_count\_max](#input\_aks\_system\_node\_pool\_node\_count\_max) | The maximum number of nodes which should exist in this Node Pool. Between 1 and 1000 | `number` | `1` | no |
| <a name="input_aks_system_node_pool_node_count_min"></a> [aks\_system\_node\_pool\_node\_count\_min](#input\_aks\_system\_node\_pool\_node\_count\_min) | The minimum number of nodes which should exist in this Node Pool. Between 1 and 1000 | `number` | `1` | no |
| <a name="input_aks_system_node_pool_only_critical_addons_enabled"></a> [aks\_system\_node\_pool\_only\_critical\_addons\_enabled](#input\_aks\_system\_node\_pool\_only\_critical\_addons\_enabled) | (Optional) Enabling this option will taint default node pool with CriticalAddonsOnly=true:NoSchedule taint. Changing this forces a new resource to be created. | `bool` | `true` | no |
| <a name="input_aks_system_node_pool_os_disk_size_gb"></a> [aks\_system\_node\_pool\_os\_disk\_size\_gb](#input\_aks\_system\_node\_pool\_os\_disk\_size\_gb) | (Optional) The size of the OS Disk which should be used for each agent in the Node Pool. Changing this forces a new resource to be created. | `number` | `null` | no |
| <a name="input_aks_system_node_pool_os_disk_type"></a> [aks\_system\_node\_pool\_os\_disk\_type](#input\_aks\_system\_node\_pool\_os\_disk\_type) | (Required) The type of disk which should be used for the Operating System. Possible values are Ephemeral and Managed. Defaults to Managed. | `string` | n/a | yes |
| <a name="input_aks_system_node_pool_vm_size"></a> [aks\_system\_node\_pool\_vm\_size](#input\_aks\_system\_node\_pool\_vm\_size) | The size of the AKS Virtual Machine in the Node Pool. | `string` | `"Standard_DS3_v2"` | no |
| <a name="input_aks_upgrade_settings_max_surge"></a> [aks\_upgrade\_settings\_max\_surge](#input\_aks\_upgrade\_settings\_max\_surge) | The maximum number or percentage of nodes which will be added to the Node Pool size during an upgrade. | `string` | `"33%"` | no |
| <a name="input_aks_user_node_pool_enabled"></a> [aks\_user\_node\_pool\_enabled](#input\_aks\_user\_node\_pool\_enabled) | Is user node pool enabled? | `bool` | `false` | no |
| <a name="input_aks_user_node_pool_node_count_max"></a> [aks\_user\_node\_pool\_node\_count\_max](#input\_aks\_user\_node\_pool\_node\_count\_max) | The maximum number of nodes which should exist in this Node Pool. Between 1 and 1000 | `number` | `1` | no |
| <a name="input_aks_user_node_pool_node_count_min"></a> [aks\_user\_node\_pool\_node\_count\_min](#input\_aks\_user\_node\_pool\_node\_count\_min) | The minimum number of nodes which should exist in this Node Pool. Between 1 and 1000 | `number` | `1` | no |
| <a name="input_aks_user_node_pool_os_disk_size_gb"></a> [aks\_user\_node\_pool\_os\_disk\_size\_gb](#input\_aks\_user\_node\_pool\_os\_disk\_size\_gb) | (Optional) The size of the OS Disk which should be used for each agent in the Node Pool. Changing this forces a new resource to be created. | `number` | `null` | no |
| <a name="input_aks_user_node_pool_os_disk_type"></a> [aks\_user\_node\_pool\_os\_disk\_type](#input\_aks\_user\_node\_pool\_os\_disk\_type) | (Optional) The type of disk which should be used for the Operating System. Possible values are Ephemeral and Managed. Defaults to Managed. | `string` | `"Managed"` | no |
| <a name="input_aks_user_node_pool_vm_size"></a> [aks\_user\_node\_pool\_vm\_size](#input\_aks\_user\_node\_pool\_vm\_size) | The size of the AKS Virtual Machine in the Node Pool. | `string` | `"Standard_DS3_v2"` | no |
| <a name="input_api_config_enabled"></a> [api\_config\_enabled](#input\_api\_config\_enabled) | Api Config enabled | `bool` | `false` | no |
| <a name="input_apim_publisher_name"></a> [apim\_publisher\_name](#input\_apim\_publisher\_name) | apim | `string` | n/a | yes |
| <a name="input_apim_sku"></a> [apim\_sku](#input\_apim\_sku) | n/a | `string` | n/a | yes |
| <a name="input_app_gateway_alerts_enabled"></a> [app\_gateway\_alerts\_enabled](#input\_app\_gateway\_alerts\_enabled) | Enable alerts | `bool` | `false` | no |
| <a name="input_app_gateway_api_certificate_name"></a> [app\_gateway\_api\_certificate\_name](#input\_app\_gateway\_api\_certificate\_name) | Application gateway api certificate name on Key Vault | `string` | n/a | yes |
| <a name="input_app_gateway_max_capacity"></a> [app\_gateway\_max\_capacity](#input\_app\_gateway\_max\_capacity) | n/a | `number` | `2` | no |
| <a name="input_app_gateway_min_capacity"></a> [app\_gateway\_min\_capacity](#input\_app\_gateway\_min\_capacity) | n/a | `number` | `0` | no |
| <a name="input_app_gateway_sku_name"></a> [app\_gateway\_sku\_name](#input\_app\_gateway\_sku\_name) | SKU Name of the App GW | `string` | `"Standard_v2"` | no |
| <a name="input_app_gateway_sku_tier"></a> [app\_gateway\_sku\_tier](#input\_app\_gateway\_sku\_tier) | SKU tier of the App GW | `string` | `"Standard_v2"` | no |
| <a name="input_app_gateway_waf_enabled"></a> [app\_gateway\_waf\_enabled](#input\_app\_gateway\_waf\_enabled) | Enable WAF | `bool` | `false` | no |
| <a name="input_azdo_sp_tls_cert_enabled"></a> [azdo\_sp\_tls\_cert\_enabled](#input\_azdo\_sp\_tls\_cert\_enabled) | Enable Azure DevOps connection for TLS cert management | `string` | `false` | no |
| <a name="input_azuread_service_principal_azure_cdn_frontdoor_id"></a> [azuread\_service\_principal\_azure\_cdn\_frontdoor\_id](#input\_azuread\_service\_principal\_azure\_cdn\_frontdoor\_id) | Azure CDN Front Door Principal ID | `string` | `"f3b3f72f-4770-47a5-8c1e-aa298003be12"` | no |
| <a name="input_cidr_subnet_api_config"></a> [cidr\_subnet\_api\_config](#input\_cidr\_subnet\_api\_config) | Address prefixes subnet api config | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_apim"></a> [cidr\_subnet\_apim](#input\_cidr\_subnet\_apim) | Address prefixes subnet api management. | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_appgateway"></a> [cidr\_subnet\_appgateway](#input\_cidr\_subnet\_appgateway) | Application gateway address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_azdoa"></a> [cidr\_subnet\_azdoa](#input\_cidr\_subnet\_azdoa) | Azure DevOps agent network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_contract_storage"></a> [cidr\_subnet\_contract\_storage](#input\_cidr\_subnet\_contract\_storage) | Contracts storage address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_cosmosdb_mongodb"></a> [cidr\_subnet\_cosmosdb\_mongodb](#input\_cidr\_subnet\_cosmosdb\_mongodb) | Application gateway address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_dns_forwarder"></a> [cidr\_subnet\_dns\_forwarder](#input\_cidr\_subnet\_dns\_forwarder) | DNS Forwarder network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_k8s"></a> [cidr\_subnet\_k8s](#input\_cidr\_subnet\_k8s) | Subnet cluster kubernetes. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_postgres"></a> [cidr\_subnet\_postgres](#input\_cidr\_subnet\_postgres) | Database network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_redis"></a> [cidr\_subnet\_redis](#input\_cidr\_subnet\_redis) | Redis network address space. | `list(string)` | `[]` | no |
| <a name="input_cidr_subnet_vpn"></a> [cidr\_subnet\_vpn](#input\_cidr\_subnet\_vpn) | VPN network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_vnet"></a> [cidr\_vnet](#input\_cidr\_vnet) | Virtual network address space. | `list(string)` | n/a | yes |
| <a name="input_contracts_account_replication_type"></a> [contracts\_account\_replication\_type](#input\_contracts\_account\_replication\_type) | Contracts replication type | `string` | `"LRS"` | no |
| <a name="input_contracts_advanced_threat_protection"></a> [contracts\_advanced\_threat\_protection](#input\_contracts\_advanced\_threat\_protection) | Enable contract threat advanced protection | `bool` | `false` | no |
| <a name="input_contracts_delete_retention_days"></a> [contracts\_delete\_retention\_days](#input\_contracts\_delete\_retention\_days) | Number of days to retain deleted contracts | `number` | `1` | no |
| <a name="input_contracts_enable_versioning"></a> [contracts\_enable\_versioning](#input\_contracts\_enable\_versioning) | Enable contract versioning | `bool` | `false` | no |
| <a name="input_cosmosdb_mongodb_additional_geo_locations"></a> [cosmosdb\_mongodb\_additional\_geo\_locations](#input\_cosmosdb\_mongodb\_additional\_geo\_locations) | The name of the Azure region to host replicated data and the priority to apply starting from 1. Not used when cosmosdb\_mongodb\_enable\_serverless | <pre>list(object({<br>    location          = string<br>    failover_priority = number<br>    zone_redundant    = bool<br>  }))</pre> | `[]` | no |
| <a name="input_cosmosdb_mongodb_consistency_policy"></a> [cosmosdb\_mongodb\_consistency\_policy](#input\_cosmosdb\_mongodb\_consistency\_policy) | n/a | <pre>object({<br>    consistency_level       = string<br>    max_interval_in_seconds = number<br>    max_staleness_prefix    = number<br>  })</pre> | <pre>{<br>  "consistency_level": "Session",<br>  "max_interval_in_seconds": null,<br>  "max_staleness_prefix": null<br>}</pre> | no |
| <a name="input_cosmosdb_mongodb_enable_autoscaling"></a> [cosmosdb\_mongodb\_enable\_autoscaling](#input\_cosmosdb\_mongodb\_enable\_autoscaling) | It will enable autoscaling mode. If true, cosmosdb\_mongodb\_throughput must be unset | `bool` | `false` | no |
| <a name="input_cosmosdb_mongodb_enable_free_tier"></a> [cosmosdb\_mongodb\_enable\_free\_tier](#input\_cosmosdb\_mongodb\_enable\_free\_tier) | Enable Free Tier pricing option for this Cosmos DB account | `bool` | `true` | no |
| <a name="input_cosmosdb_mongodb_extra_capabilities"></a> [cosmosdb\_mongodb\_extra\_capabilities](#input\_cosmosdb\_mongodb\_extra\_capabilities) | Enable cosmosdb extra capabilities | `list(string)` | `[]` | no |
| <a name="input_cosmosdb_mongodb_main_geo_location_zone_redundant"></a> [cosmosdb\_mongodb\_main\_geo\_location\_zone\_redundant](#input\_cosmosdb\_mongodb\_main\_geo\_location\_zone\_redundant) | Enable zone redundant Comsmos DB | `bool` | n/a | yes |
| <a name="input_cosmosdb_mongodb_max_throughput"></a> [cosmosdb\_mongodb\_max\_throughput](#input\_cosmosdb\_mongodb\_max\_throughput) | The maximum throughput of the MongoDB database (RU/s). Must be between 4,000 and 1,000,000. Must be set in increments of 1,000. Conflicts with throughput | `number` | `4000` | no |
| <a name="input_cosmosdb_mongodb_offer_type"></a> [cosmosdb\_mongodb\_offer\_type](#input\_cosmosdb\_mongodb\_offer\_type) | Specifies the Offer Type to use for this CosmosDB Account - currently this can only be set to Standard | `string` | `"Standard"` | no |
| <a name="input_cosmosdb_mongodb_private_endpoint_enabled"></a> [cosmosdb\_mongodb\_private\_endpoint\_enabled](#input\_cosmosdb\_mongodb\_private\_endpoint\_enabled) | Enable private endpoint for Comsmos DB | `bool` | `true` | no |
| <a name="input_cosmosdb_mongodb_public_network_access_enabled"></a> [cosmosdb\_mongodb\_public\_network\_access\_enabled](#input\_cosmosdb\_mongodb\_public\_network\_access\_enabled) | Whether or not public network access is allowed for this CosmosDB account | `bool` | `false` | no |
| <a name="input_cosmosdb_mongodb_throughput"></a> [cosmosdb\_mongodb\_throughput](#input\_cosmosdb\_mongodb\_throughput) | The throughput of the MongoDB database (RU/s). Must be set in increments of 100. The minimum value is 400. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply. | `number` | `400` | no |
| <a name="input_dns_default_ttl_sec"></a> [dns\_default\_ttl\_sec](#input\_dns\_default\_ttl\_sec) | value | `number` | `3600` | no |
| <a name="input_dns_zone_prefix"></a> [dns\_zone\_prefix](#input\_dns\_zone\_prefix) | The dns subdomain. | `string` | `"selfcare"` | no |
| <a name="input_enable_azdoa"></a> [enable\_azdoa](#input\_enable\_azdoa) | Enable Azure DevOps agent. | `bool` | n/a | yes |
| <a name="input_enable_iac_pipeline"></a> [enable\_iac\_pipeline](#input\_enable\_iac\_pipeline) | If true create the key vault policy to allow used by azure devops iac pipelines. | `bool` | `false` | no |
| <a name="input_enable_spid_test"></a> [enable\_spid\_test](#input\_enable\_spid\_test) | to provision italia/spid-testenv2:1.1.0 | `bool` | `false` | no |
| <a name="input_env"></a> [env](#input\_env) | env directory name | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `"pagopa.it"` | no |
| <a name="input_law_daily_quota_gb"></a> [law\_daily\_quota\_gb](#input\_law\_daily\_quota\_gb) | The workspace daily quota for ingestion in GB. | `number` | `-1` | no |
| <a name="input_law_retention_in_days"></a> [law\_retention\_in\_days](#input\_law\_retention\_in\_days) | The workspace data retention in days | `number` | `30` | no |
| <a name="input_law_sku"></a> [law\_sku](#input\_law\_sku) | Sku of the Log Analytics Workspace | `string` | `"PerGB2018"` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | `"westeurope"` | no |
| <a name="input_lock_enable"></a> [lock\_enable](#input\_lock\_enable) | Apply locks to block accedentaly deletions. | `bool` | `false` | no |
| <a name="input_postgres_alerts_enabled"></a> [postgres\_alerts\_enabled](#input\_postgres\_alerts\_enabled) | Database alerts enabled? | `bool` | `false` | no |
| <a name="input_postgres_configuration"></a> [postgres\_configuration](#input\_postgres\_configuration) | PostgreSQL Server configuration | `map(string)` | `{}` | no |
| <a name="input_postgres_enable_replica"></a> [postgres\_enable\_replica](#input\_postgres\_enable\_replica) | Create a PostgreSQL Server Replica. | `bool` | `false` | no |
| <a name="input_postgres_geo_redundant_backup_enabled"></a> [postgres\_geo\_redundant\_backup\_enabled](#input\_postgres\_geo\_redundant\_backup\_enabled) | Turn Geo-redundant server backups on/off. | `bool` | `false` | no |
| <a name="input_postgres_metric_alerts"></a> [postgres\_metric\_alerts](#input\_postgres\_metric\_alerts) | Map of name = criteria objects, see these docs for options<br>https://docs.microsoft.com/en-us/azure/azure-monitor/platform/metrics-supported#microsoftdbforpostgresqlservers<br>https://docs.microsoft.com/en-us/azure/postgresql/concepts-limits#maximum-connections | <pre>map(object({<br>    # criteria.*.aggregation to be one of [Average Count Minimum Maximum Total]<br>    aggregation = string<br>    metric_name = string<br>    # criteria.0.operator to be one of [Equals NotEquals GreaterThan GreaterThanOrEqual LessThan LessThanOrEqual]<br>    operator  = string<br>    threshold = number<br>    # Possible values are PT1M, PT5M, PT15M, PT30M and PT1H<br>    frequency = string<br>    # Possible values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D.<br>    window_size = string<br><br>    dimension = list(object(<br>      {<br>        name     = string<br>        operator = string<br>        values   = list(string)<br>      }<br>    ))<br>  }))</pre> | <pre>{<br>  "cpu": {<br>    "aggregation": "Average",<br>    "dimension": [],<br>    "frequency": "PT1M",<br>    "metric_name": "cpu_percent",<br>    "operator": "GreaterThan",<br>    "threshold": 70,<br>    "window_size": "PT5M"<br>  },<br>  "failed_connections": {<br>    "aggregation": "Total",<br>    "dimension": [],<br>    "frequency": "PT5M",<br>    "metric_name": "connections_failed",<br>    "operator": "GreaterThan",<br>    "threshold": 10,<br>    "window_size": "PT15M"<br>  },<br>  "io": {<br>    "aggregation": "Average",<br>    "dimension": [],<br>    "frequency": "PT1M",<br>    "metric_name": "io_consumption_percent",<br>    "operator": "GreaterThan",<br>    "threshold": 55,<br>    "window_size": "PT5M"<br>  },<br>  "max_active_connections": {<br>    "aggregation": "Average",<br>    "dimension": [],<br>    "frequency": "PT5M",<br>    "metric_name": "active_connections",<br>    "operator": "GreaterThan",<br>    "threshold": 1196,<br>    "window_size": "PT5M"<br>  },<br>  "memory": {<br>    "aggregation": "Average",<br>    "dimension": [],<br>    "frequency": "PT1M",<br>    "metric_name": "memory_percent",<br>    "operator": "GreaterThan",<br>    "threshold": 75,<br>    "window_size": "PT5M"<br>  },<br>  "min_active_connections": {<br>    "aggregation": "Average",<br>    "dimension": [],<br>    "frequency": "PT5M",<br>    "metric_name": "active_connections",<br>    "operator": "LessThanOrEqual",<br>    "threshold": 0,<br>    "window_size": "PT15M"<br>  },<br>  "replica_lag": {<br>    "aggregation": "Average",<br>    "dimension": [],<br>    "frequency": "PT1M",<br>    "metric_name": "pg_replica_log_delay_in_seconds",<br>    "operator": "GreaterThan",<br>    "threshold": 60,<br>    "window_size": "PT5M"<br>  }<br>}</pre> | no |
| <a name="input_postgres_network_rules"></a> [postgres\_network\_rules](#input\_postgres\_network\_rules) | Database network rules | <pre>object({<br>    ip_rules                       = list(string)<br>    allow_access_to_azure_services = bool<br>  })</pre> | <pre>{<br>  "allow_access_to_azure_services": true,<br>  "ip_rules": []<br>}</pre> | no |
| <a name="input_postgres_replica_network_rules"></a> [postgres\_replica\_network\_rules](#input\_postgres\_replica\_network\_rules) | Database network rules | <pre>object({<br>    ip_rules                       = list(string)<br>    allow_access_to_azure_services = bool<br>  })</pre> | <pre>{<br>  "allow_access_to_azure_services": true,<br>  "ip_rules": []<br>}</pre> | no |
| <a name="input_postgres_sku_name"></a> [postgres\_sku\_name](#input\_postgres\_sku\_name) | Specifies the SKU Name for this PostgreSQL Server. | `string` | n/a | yes |
| <a name="input_postgres_storage_mb"></a> [postgres\_storage\_mb](#input\_postgres\_storage\_mb) | Max storage allowed for a server | `number` | `5120` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | `"selc"` | no |
| <a name="input_redis_capacity"></a> [redis\_capacity](#input\_redis\_capacity) | # Redis cache | `number` | `1` | no |
| <a name="input_redis_family"></a> [redis\_family](#input\_redis\_family) | n/a | `string` | `"C"` | no |
| <a name="input_redis_private_endpoint_enabled"></a> [redis\_private\_endpoint\_enabled](#input\_redis\_private\_endpoint\_enabled) | n/a | `bool` | `true` | no |
| <a name="input_redis_sku_name"></a> [redis\_sku\_name](#input\_redis\_sku\_name) | n/a | `string` | `"Standard"` | no |
| <a name="input_reverse_proxy_ip"></a> [reverse\_proxy\_ip](#input\_reverse\_proxy\_ip) | AKS external ip. Also the ingress-nginx-controller external ip. Value known after installing the ingress controller. | `string` | `"127.0.0.1"` | no |
| <a name="input_robots_indexed_paths"></a> [robots\_indexed\_paths](#input\_robots\_indexed\_paths) | List of cdn paths to allow robots index | `list(string)` | n/a | yes |
| <a name="input_spa"></a> [spa](#input\_spa) | spa root dirs | `list(string)` | <pre>[<br>  "auth",<br>  "onboarding",<br>  "dashboard"<br>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "CreatedBy": "Terraform"<br>}</pre> | no |
| <a name="input_vpn_pip_sku"></a> [vpn\_pip\_sku](#input\_vpn\_pip\_sku) | VPN GW PIP SKU | `string` | `"Basic"` | no |
| <a name="input_vpn_sku"></a> [vpn\_sku](#input\_vpn\_sku) | VPN Gateway SKU | `string` | `"VpnGw1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aks_client_certificate"></a> [aks\_client\_certificate](#output\_aks\_client\_certificate) | n/a |
| <a name="output_aks_cluster_name"></a> [aks\_cluster\_name](#output\_aks\_cluster\_name) | # AKS |
| <a name="output_aks_fqdn"></a> [aks\_fqdn](#output\_aks\_fqdn) | n/a |
| <a name="output_aks_kube_config"></a> [aks\_kube\_config](#output\_aks\_kube\_config) | n/a |
| <a name="output_aks_outbound_ips"></a> [aks\_outbound\_ips](#output\_aks\_outbound\_ips) | n/a |
| <a name="output_aks_private_fqdn"></a> [aks\_private\_fqdn](#output\_aks\_private\_fqdn) | n/a |
| <a name="output_api_fqdn"></a> [api\_fqdn](#output\_api\_fqdn) | n/a |
| <a name="output_app_gateway_fqdn"></a> [app\_gateway\_fqdn](#output\_app\_gateway\_fqdn) | n/a |
| <a name="output_app_gateway_public_ip"></a> [app\_gateway\_public\_ip](#output\_app\_gateway\_public\_ip) | # Application gateway. |
| <a name="output_container_registry_admin_password"></a> [container\_registry\_admin\_password](#output\_container\_registry\_admin\_password) | n/a |
| <a name="output_container_registry_admin_username"></a> [container\_registry\_admin\_username](#output\_container\_registry\_admin\_username) | n/a |
| <a name="output_container_registry_login_server"></a> [container\_registry\_login\_server](#output\_container\_registry\_login\_server) | # Container registry ## |
| <a name="output_cosmosdb_account_mongodb_connection_strings"></a> [cosmosdb\_account\_mongodb\_connection\_strings](#output\_cosmosdb\_account\_mongodb\_connection\_strings) | n/a |
| <a name="output_cosmosdb_account_mongodb_endpoint"></a> [cosmosdb\_account\_mongodb\_endpoint](#output\_cosmosdb\_account\_mongodb\_endpoint) | n/a |
| <a name="output_cosmosdb_account_mongodb_id"></a> [cosmosdb\_account\_mongodb\_id](#output\_cosmosdb\_account\_mongodb\_id) | # CosmosDb - MongoDB ## |
| <a name="output_cosmosdb_account_mongodb_primary_key"></a> [cosmosdb\_account\_mongodb\_primary\_key](#output\_cosmosdb\_account\_mongodb\_primary\_key) | n/a |
| <a name="output_cosmosdb_account_mongodb_primary_readonly_key"></a> [cosmosdb\_account\_mongodb\_primary\_readonly\_key](#output\_cosmosdb\_account\_mongodb\_primary\_readonly\_key) | n/a |
| <a name="output_key_vault_name"></a> [key\_vault\_name](#output\_key\_vault\_name) | n/a |
| <a name="output_key_vault_uri"></a> [key\_vault\_uri](#output\_key\_vault\_uri) | # key vault ## |
| <a name="output_postgresql_administrator_login"></a> [postgresql\_administrator\_login](#output\_postgresql\_administrator\_login) | n/a |
| <a name="output_postgresql_administrator_login_password"></a> [postgresql\_administrator\_login\_password](#output\_postgresql\_administrator\_login\_password) | n/a |
| <a name="output_postgresql_fqdn"></a> [postgresql\_fqdn](#output\_postgresql\_fqdn) | # Postgresql server |
| <a name="output_postgresql_replica_fqdn"></a> [postgresql\_replica\_fqdn](#output\_postgresql\_replica\_fqdn) | n/a |
| <a name="output_redis_hostname"></a> [redis\_hostname](#output\_redis\_hostname) | n/a |
| <a name="output_redis_port"></a> [redis\_port](#output\_redis\_port) | n/a |
| <a name="output_redis_primary_access_key"></a> [redis\_primary\_access\_key](#output\_redis\_primary\_access\_key) | # Redis cache |
| <a name="output_redis_ssl_port"></a> [redis\_ssl\_port](#output\_redis\_ssl\_port) | n/a |
| <a name="output_reverse_proxy_ip"></a> [reverse\_proxy\_ip](#output\_reverse\_proxy\_ip) | n/a |
| <a name="output_vnet_address_space"></a> [vnet\_address\_space](#output\_vnet\_address\_space) | n/a |
| <a name="output_vnet_name"></a> [vnet\_name](#output\_vnet\_name) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
