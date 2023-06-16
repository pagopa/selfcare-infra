# core

<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | = 2.5.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | = 2.99.0 |
| <a name="requirement_pkcs12"></a> [pkcs12](#requirement\_pkcs12) | 0.0.7 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_acr"></a> [acr](#module\_acr) | git::https://github.com/pagopa/azurerm.git//container_registry | v1.0.58 |
| <a name="module_acr_common"></a> [acr\_common](#module\_acr\_common) | git::https://github.com/pagopa/azurerm.git//container_registry | v4.3.2 |
| <a name="module_agid_spid"></a> [agid\_spid](#module\_agid\_spid) | git::https://github.com/pagopa/azurerm.git//jwt_keys | v3.8.1 |
| <a name="module_aks"></a> [aks](#module\_aks) | git::https://github.com/pagopa/azurerm.git//kubernetes_cluster | v2.15.1 |
| <a name="module_apim"></a> [apim](#module\_apim) | git::https://github.com/pagopa/azurerm.git//api_management | v2.12.5 |
| <a name="module_apim_external_api_ms_v1"></a> [apim\_external\_api\_ms\_v1](#module\_apim\_external\_api\_ms\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.12.5 |
| <a name="module_apim_external_api_ms_v2"></a> [apim\_external\_api\_ms\_v2](#module\_apim\_external\_api\_ms\_v2) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.12.5 |
| <a name="module_apim_external_api_onboarding_auto_v1"></a> [apim\_external\_api\_onboarding\_auto\_v1](#module\_apim\_external\_api\_onboarding\_auto\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.12.5 |
| <a name="module_apim_external_api_onboarding_io_v1"></a> [apim\_external\_api\_onboarding\_io\_v1](#module\_apim\_external\_api\_onboarding\_io\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.12.5 |
| <a name="module_apim_internal_api_ms_v1"></a> [apim\_internal\_api\_ms\_v1](#module\_apim\_internal\_api\_ms\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.12.5 |
| <a name="module_apim_product_idpay"></a> [apim\_product\_idpay](#module\_apim\_product\_idpay) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.16 |
| <a name="module_apim_product_interop"></a> [apim\_product\_interop](#module\_apim\_product\_interop) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.16 |
| <a name="module_apim_product_interop_coll"></a> [apim\_product\_interop\_coll](#module\_apim\_product\_interop\_coll) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.16 |
| <a name="module_apim_product_io"></a> [apim\_product\_io](#module\_apim\_product\_io) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.16 |
| <a name="module_apim_product_io_sign"></a> [apim\_product\_io\_sign](#module\_apim\_product\_io\_sign) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.16 |
| <a name="module_apim_product_pagopa"></a> [apim\_product\_pagopa](#module\_apim\_product\_pagopa) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.16 |
| <a name="module_apim_product_pn"></a> [apim\_product\_pn](#module\_apim\_product\_pn) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.16 |
| <a name="module_apim_product_pn_cert"></a> [apim\_product\_pn\_cert](#module\_apim\_product\_pn\_cert) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.16 |
| <a name="module_apim_product_pn_coll"></a> [apim\_product\_pn\_coll](#module\_apim\_product\_pn\_coll) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.16 |
| <a name="module_apim_product_pn_dev"></a> [apim\_product\_pn\_dev](#module\_apim\_product\_pn\_dev) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.16 |
| <a name="module_apim_product_pn_hotfix"></a> [apim\_product\_pn\_hotfix](#module\_apim\_product\_pn\_hotfix) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.16 |
| <a name="module_apim_product_pn_prod"></a> [apim\_product\_pn\_prod](#module\_apim\_product\_pn\_prod) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.16 |
| <a name="module_apim_product_pn_svil"></a> [apim\_product\_pn\_svil](#module\_apim\_product\_pn\_svil) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.16 |
| <a name="module_apim_product_pn_test"></a> [apim\_product\_pn\_test](#module\_apim\_product\_pn\_test) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.16 |
| <a name="module_apim_product_pn_uat"></a> [apim\_product\_pn\_uat](#module\_apim\_product\_pn\_uat) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.16 |
| <a name="module_apim_product_support_io"></a> [apim\_product\_support\_io](#module\_apim\_product\_support\_io) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.16 |
| <a name="module_apim_product_test_io"></a> [apim\_product\_test\_io](#module\_apim\_product\_test\_io) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.16 |
| <a name="module_apim_product_test_io_premium"></a> [apim\_product\_test\_io\_premium](#module\_apim\_product\_test\_io\_premium) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.16 |
| <a name="module_apim_selfcare_support_service_v1"></a> [apim\_selfcare\_support\_service\_v1](#module\_apim\_selfcare\_support\_service\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.12.5 |
| <a name="module_apim_snet"></a> [apim\_snet](#module\_apim\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v2.12.5 |
| <a name="module_apim_user_group_ms_v1"></a> [apim\_user\_group\_ms\_v1](#module\_apim\_user\_group\_ms\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.12.5 |
| <a name="module_apim_uservice_party_management_v1"></a> [apim\_uservice\_party\_management\_v1](#module\_apim\_uservice\_party\_management\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.12.5 |
| <a name="module_apim_uservice_party_process_v1"></a> [apim\_uservice\_party\_process\_v1](#module\_apim\_uservice\_party\_process\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.12.5 |
| <a name="module_app_gw"></a> [app\_gw](#module\_app\_gw) | git::https://github.com/pagopa/azurerm.git//app_gateway | v4.10.1 |
| <a name="module_appgateway_snet"></a> [appgateway\_snet](#module\_appgateway\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v4.10.1 |
| <a name="module_azdoa_li"></a> [azdoa\_li](#module\_azdoa\_li) | git::https://github.com/pagopa/azurerm.git//azure_devops_agent | v1.0.58 |
| <a name="module_azdoa_snet"></a> [azdoa\_snet](#module\_azdoa\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.58 |
| <a name="module_checkout_cdn"></a> [checkout\_cdn](#module\_checkout\_cdn) | git::https://github.com/pagopa/azurerm.git//cdn | v2.12.1 |
| <a name="module_contracts_storage_snet"></a> [contracts\_storage\_snet](#module\_contracts\_storage\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.60 |
| <a name="module_cosmosdb_account_mongodb"></a> [cosmosdb\_account\_mongodb](#module\_cosmosdb\_account\_mongodb) | git::https://github.com/pagopa/azurerm.git//cosmosdb | v2.0.19 |
| <a name="module_cosmosdb_mongodb_snet"></a> [cosmosdb\_mongodb\_snet](#module\_cosmosdb\_mongodb\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.58 |
| <a name="module_dns_forwarder"></a> [dns\_forwarder](#module\_dns\_forwarder) | git::https://github.com/pagopa/azurerm.git//dns_forwarder | v2.0.8 |
| <a name="module_dns_forwarder_pair_subnet"></a> [dns\_forwarder\_pair\_subnet](#module\_dns\_forwarder\_pair\_subnet) | git::https://github.com/pagopa/azurerm.git//subnet | v2.0.8 |
| <a name="module_dns_forwarder_snet"></a> [dns\_forwarder\_snet](#module\_dns\_forwarder\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v2.0.8 |
| <a name="module_event_hub"></a> [event\_hub](#module\_event\_hub) | git::https://github.com/pagopa/azurerm.git//eventhub | v2.18.7 |
| <a name="module_eventhub_snet"></a> [eventhub\_snet](#module\_eventhub\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v2.18.6 |
| <a name="module_jwt"></a> [jwt](#module\_jwt) | git::https://github.com/pagopa/azurerm.git//jwt_keys | v2.12.1 |
| <a name="module_jwt_exchange"></a> [jwt\_exchange](#module\_jwt\_exchange) | git::https://github.com/pagopa/azurerm.git//jwt_keys | v2.12.1 |
| <a name="module_k8s_snet"></a> [k8s\_snet](#module\_k8s\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v2.1.15 |
| <a name="module_key_vault"></a> [key\_vault](#module\_key\_vault) | git::https://github.com/pagopa/azurerm.git//key_vault | v2.12.1 |
| <a name="module_load_tests_snet"></a> [load\_tests\_snet](#module\_load\_tests\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v2.0.3 |
| <a name="module_logs_storage_snet"></a> [logs\_storage\_snet](#module\_logs\_storage\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v2.18.10 |
| <a name="module_mongdb_collection_products"></a> [mongdb\_collection\_products](#module\_mongdb\_collection\_products) | git::https://github.com/pagopa/azurerm.git//cosmosdb_mongodb_collection | v3.3.0 |
| <a name="module_mongdb_collection_user-groups"></a> [mongdb\_collection\_user-groups](#module\_mongdb\_collection\_user-groups) | git::https://github.com/pagopa/azurerm.git//cosmosdb_mongodb_collection | v3.3.0 |
| <a name="module_monitor"></a> [monitor](#module\_monitor) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.12.5 |
| <a name="module_postgres_snet"></a> [postgres\_snet](#module\_postgres\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.60 |
| <a name="module_postgresql"></a> [postgresql](#module\_postgresql) | git::https://github.com/pagopa/azurerm.git//postgresql_server | v1.0.79 |
| <a name="module_private_endpoints_subnet"></a> [private\_endpoints\_subnet](#module\_private\_endpoints\_subnet) | git::https://github.com/pagopa/azurerm.git//subnet | v4.8.0 |
| <a name="module_redis"></a> [redis](#module\_redis) | git::https://github.com/pagopa/azurerm.git//redis_cache | v4.15.0 |
| <a name="module_redis_snet"></a> [redis\_snet](#module\_redis\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.58 |
| <a name="module_secrets_selfcare_status_dev"></a> [secrets\_selfcare\_status\_dev](#module\_secrets\_selfcare\_status\_dev) | git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query | v4.3.2 |
| <a name="module_secrets_selfcare_status_uat"></a> [secrets\_selfcare\_status\_uat](#module\_secrets\_selfcare\_status\_uat) | git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query | v4.3.2 |
| <a name="module_selc-contracts-storage"></a> [selc-contracts-storage](#module\_selc-contracts-storage) | git::https://github.com/pagopa/azurerm.git//storage_account | v2.12.1 |
| <a name="module_selc_logs_storage"></a> [selc\_logs\_storage](#module\_selc\_logs\_storage) | git::https://github.com/pagopa/azurerm.git//storage_account | v2.18.10 |
| <a name="module_selc_ms_core_collections"></a> [selc\_ms\_core\_collections](#module\_selc\_ms\_core\_collections) | git::https://github.com/pagopa/azurerm.git//cosmosdb_mongodb_collection | v4.13.0 |
| <a name="module_spid-test-env"></a> [spid-test-env](#module\_spid-test-env) | ./modules/spid_testenv | n/a |
| <a name="module_spid_logs_encryption_keys"></a> [spid\_logs\_encryption\_keys](#module\_spid\_logs\_encryption\_keys) | git::https://github.com/pagopa/azurerm.git//jwt_keys | v2.12.1 |
| <a name="module_vnet"></a> [vnet](#module\_vnet) | git::https://github.com/pagopa/azurerm.git//virtual_network | v4.3.2 |
| <a name="module_vnet_aks_platform"></a> [vnet\_aks\_platform](#module\_vnet\_aks\_platform) | git::https://github.com/pagopa/azurerm.git//virtual_network | v4.3.2 |
| <a name="module_vnet_pair"></a> [vnet\_pair](#module\_vnet\_pair) | git::https://github.com/pagopa/azurerm.git//virtual_network | v4.3.2 |
| <a name="module_vnet_peering_core_2_aks"></a> [vnet\_peering\_core\_2\_aks](#module\_vnet\_peering\_core\_2\_aks) | git::https://github.com/pagopa/azurerm.git//virtual_network_peering | v2.16.0 |
| <a name="module_vnet_peering_pair_vs_aks"></a> [vnet\_peering\_pair\_vs\_aks](#module\_vnet\_peering\_pair\_vs\_aks) | git::https://github.com/pagopa/azurerm.git//virtual_network_peering | v2.16.0 |
| <a name="module_vnet_peering_pair_vs_core"></a> [vnet\_peering\_pair\_vs\_core](#module\_vnet\_peering\_pair\_vs\_core) | git::https://github.com/pagopa/azurerm.git//virtual_network_peering | v2.16.0 |
| <a name="module_vpn"></a> [vpn](#module\_vpn) | git::https://github.com/pagopa/azurerm.git//vpn_gateway | v2.0.11 |
| <a name="module_vpn_pair_dns_forwarder"></a> [vpn\_pair\_dns\_forwarder](#module\_vpn\_pair\_dns\_forwarder) | git::https://github.com/pagopa/azurerm.git//dns_forwarder | v2.0.8 |
| <a name="module_vpn_snet"></a> [vpn\_snet](#module\_vpn\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.58 |
| <a name="module_web_test_api"></a> [web\_test\_api](#module\_web\_test\_api) | git::https://github.com/pagopa/azurerm.git//application_insights_web_test_preview | v2.0.18 |

## Resources

| Name | Type |
|------|------|
| [azurerm_api_management_api_version_set.apim_external_api_ms](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.apim_external_api_onboarding_auto](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.apim_external_api_onboarding_io](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.apim_internal_api_ms](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.apim_selfcare_support_service](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.apim_user_group_ms](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.apim_uservice_party_management](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.apim_uservice_party_process](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_certificate.jwt_certificate](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_certificate) | resource |
| [azurerm_api_management_custom_domain.api_custom_domain](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_custom_domain) | resource |
| [azurerm_api_management_named_value.apim_named_value_backend_access_token](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/api_management_named_value) | resource |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/application_insights) | resource |
| [azurerm_container_group.load_tests_db](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/container_group) | resource |
| [azurerm_cosmosdb_mongo_database.selc_ms_core](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/cosmosdb_mongo_database) | resource |
| [azurerm_cosmosdb_mongo_database.selc_product](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/cosmosdb_mongo_database) | resource |
| [azurerm_cosmosdb_mongo_database.selc_user_group](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/cosmosdb_mongo_database) | resource |
| [azurerm_dashboard.monitoring-dashboard](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dashboard) | resource |
| [azurerm_dns_a_record.dns_a_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_a_record) | resource |
| [azurerm_dns_a_record.public_api_pnpg](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_a_record) | resource |
| [azurerm_dns_caa_record.caa_selfcare](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_caa_record) | resource |
| [azurerm_dns_ns_record.dev_selfcare](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_ns_record) | resource |
| [azurerm_dns_ns_record.interop_selfcare](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_ns_record) | resource |
| [azurerm_dns_ns_record.io_selfcare](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_ns_record) | resource |
| [azurerm_dns_ns_record.uat_selfcare](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_ns_record) | resource |
| [azurerm_dns_zone.selfcare_public](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/dns_zone) | resource |
| [azurerm_key_vault_access_policy.adgroup_admin_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_developers_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_externals_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_security_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.api_management_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.app_gateway_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_app_projects_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_iac_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdo_sp_tls_cert](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azure_cdn_frontdoor_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_secret.application_insights_key](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.cosmosdb_account_mongodb_connection_strings](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.event_hub_connection_strings](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.event_hub_keys](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.redis_primary_access_key](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.selc_contracts_storage_access_key](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.selc_contracts_storage_blob_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.selc_contracts_storage_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.selc_logs_storage_access_key](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.selc_logs_storage_blob_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.selc_logs_storage_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.selc_web_storage_access_key](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.selc_web_storage_blob_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.selc_web_storage_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_secret) | resource |
| [azurerm_log_analytics_workspace.log_analytics_workspace](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/log_analytics_workspace) | resource |
| [azurerm_management_lock.mongodb_selc_ms_core](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/management_lock) | resource |
| [azurerm_management_lock.mongodb_selc_product](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/management_lock) | resource |
| [azurerm_management_lock.mongodb_selc_user_group](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/management_lock) | resource |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_action_group.error_action_group](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_action_group.selfcare_status_dev](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_action_group.selfcare_status_uat](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/monitor_action_group) | resource |
| [azurerm_network_profile.network_profile_load_tests_db](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/network_profile) | resource |
| [azurerm_postgresql_database.selc_db](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/postgresql_database) | resource |
| [azurerm_private_dns_zone.internal_private_dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.privatelink_blob_core_windows_net](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.privatelink_documents_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.privatelink_mongo_cosmos_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.privatelink_redis_cache_windows_net](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.privatelink_servicebus_windows_net](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.internal_env_selfcare_pagopa_it_2_aks_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.internal_env_selfcare_pagopa_it_2_vnet_core](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.internal_env_selfcare_pagopa_it_2_vnet_core_pair](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_blob_core_windows_net_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_blob_core_windows_net_vnet_pair](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_blob_core_windows_net_vnet_vs_aks_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_documents_azure_com_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_documents_azure_com_vnet_pair](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_documents_azure_com_vnet_vs_aks_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_mongo_cosmos_azure_com_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_mongo_cosmos_azure_com_vnet_pair](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_mongo_cosmos_azure_com_vnet_vs_aks_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_redis_cache_windows_net_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_redis_cache_windows_net_vnet_pair](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_redis_cache_windows_net_vnet_vs_aks_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_servicebus_windows_net_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_servicebus_windows_net_vnet_pair](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_servicebus_windows_net_vnet_vs_aks_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_endpoint.contracts_storage](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.logs_storage](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_endpoint) | resource |
| [azurerm_public_ip.aks_outbound](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/public_ip) | resource |
| [azurerm_public_ip.appgateway_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/public_ip) | resource |
| [azurerm_public_ip.outbound_ip_aks_platform](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/public_ip) | resource |
| [azurerm_resource_group.azdo_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.checkout_fe_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.data](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.default_roleassignment_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.docker_registry](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.event_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.mongodb_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.postgres_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_aks](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_contracts_storage](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_load_tests_db](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_logs_storage](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_pair_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_vnet_aks](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.sec_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.aks_to_acr](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/role_assignment) | resource |
| [azurerm_storage_container.selc-contracts-container](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/storage_container) | resource |
| [azurerm_storage_container.selc_logs_container](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/storage_container) | resource |
| [azurerm_user_assigned_identity.appgateway](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/user_assigned_identity) | resource |
| [null_resource.download_apim_external_api_v1](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.download_apim_external_api_v2](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.upload_assets](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.upload_contract_templates](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.upload_developer_external_api_v1](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.upload_developer_external_api_v2](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.upload_developer_index_v1](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.upload_developer_index_v2](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.upload_jwks](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.upload_one_trust](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.upload_resources_default_product_logo](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.upload_resources_default_product_resources_depict-image](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.upload_resources_logo](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.upload_resources_products_logo](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.upload_resources_templates](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [pkcs12_from_pem.jwt_pkcs12](https://registry.terraform.io/providers/chilicat/pkcs12/0.0.7/docs/resources/from_pem) | resource |
| [random_id.pair_dns_forwarder_hash](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [azuread_application.vpn_app](https://registry.terraform.io/providers/hashicorp/azuread/2.5.0/docs/data-sources/application) | data source |
| [azuread_group.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azuread/2.5.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/2.5.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/2.5.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_security](https://registry.terraform.io/providers/hashicorp/azuread/2.5.0/docs/data-sources/group) | data source |
| [azuread_service_principal.app_projects_principal](https://registry.terraform.io/providers/hashicorp/azuread/2.5.0/docs/data-sources/service_principal) | data source |
| [azuread_service_principal.azdo_sp_tls_cert](https://registry.terraform.io/providers/hashicorp/azuread/2.5.0/docs/data-sources/service_principal) | data source |
| [azuread_service_principal.iac_principal](https://registry.terraform.io/providers/hashicorp/azuread/2.5.0/docs/data-sources/service_principal) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/client_config) | data source |
| [azurerm_key_vault_certificate.api_pnpg_selfcare_certificate](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_certificate) | data source |
| [azurerm_key_vault_certificate.app_gw_platform](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_certificate) | data source |
| [azurerm_key_vault_secret.alert_error_notification_email](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.alert_error_notification_slack](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.apim_backend_access_token](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.apim_publisher_email](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.monitor_notification_email](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.monitor_notification_slack_email](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.postgres_administrator_login](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.postgres_administrator_login_password](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.sec_storage_id](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.sec_workspace_id](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/subscription) | data source |
| [local_file.resources_default_product_depict-image](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |
| [local_file.resources_default_product_logo](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aks_alerts_enabled"></a> [aks\_alerts\_enabled](#input\_aks\_alerts\_enabled) | Aks alert enabled? | `bool` | `true` | no |
| <a name="input_aks_kubernetes_version"></a> [aks\_kubernetes\_version](#input\_aks\_kubernetes\_version) | Kubernetes version for AKS | `string` | n/a | yes |
| <a name="input_aks_metric_alerts"></a> [aks\_metric\_alerts](#input\_aks\_metric\_alerts) | Map of name = criteria objects | <pre>map(object({<br>    # criteria.*.aggregation to be one of [Average Count Minimum Maximum Total]<br>    aggregation = string<br>    # "Insights.Container/pods" "Insights.Container/nodes"<br>    metric_namespace = string<br>    metric_name      = string<br>    # criteria.0.operator to be one of [Equals NotEquals GreaterThan GreaterThanOrEqual LessThan LessThanOrEqual]<br>    operator  = string<br>    threshold = number<br>    # Possible values are PT1M, PT5M, PT15M, PT30M and PT1H<br>    frequency = string<br>    # Possible values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D.<br>    window_size = string<br><br>    dimension = list(object(<br>      {<br>        name     = string<br>        operator = string<br>        values   = list(string)<br>      }<br>    ))<br>  }))</pre> | <pre>{<br>  "container_cpu": {<br>    "aggregation": "Average",<br>    "dimension": [<br>      {<br>        "name": "kubernetes namespace",<br>        "operator": "Include",<br>        "values": [<br>          "*"<br>        ]<br>      },<br>      {<br>        "name": "controllerName",<br>        "operator": "Include",<br>        "values": [<br>          "*"<br>        ]<br>      }<br>    ],<br>    "frequency": "PT1M",<br>    "metric_name": "cpuExceededPercentage",<br>    "metric_namespace": "Insights.Container/containers",<br>    "operator": "GreaterThan",<br>    "threshold": 95,<br>    "window_size": "PT5M"<br>  },<br>  "container_memory": {<br>    "aggregation": "Average",<br>    "dimension": [<br>      {<br>        "name": "kubernetes namespace",<br>        "operator": "Include",<br>        "values": [<br>          "*"<br>        ]<br>      },<br>      {<br>        "name": "controllerName",<br>        "operator": "Include",<br>        "values": [<br>          "*"<br>        ]<br>      }<br>    ],<br>    "frequency": "PT1M",<br>    "metric_name": "memoryWorkingSetExceededPercentage",<br>    "metric_namespace": "Insights.Container/containers",<br>    "operator": "GreaterThan",<br>    "threshold": 95,<br>    "window_size": "PT5M"<br>  },<br>  "container_oom": {<br>    "aggregation": "Average",<br>    "dimension": [<br>      {<br>        "name": "kubernetes namespace",<br>        "operator": "Include",<br>        "values": [<br>          "*"<br>        ]<br>      },<br>      {<br>        "name": "controllerName",<br>        "operator": "Include",<br>        "values": [<br>          "*"<br>        ]<br>      }<br>    ],<br>    "frequency": "PT1M",<br>    "metric_name": "oomKilledContainerCount",<br>    "metric_namespace": "Insights.Container/pods",<br>    "operator": "GreaterThan",<br>    "threshold": 0,<br>    "window_size": "PT1M"<br>  },<br>  "container_restart": {<br>    "aggregation": "Average",<br>    "dimension": [<br>      {<br>        "name": "kubernetes namespace",<br>        "operator": "Include",<br>        "values": [<br>          "*"<br>        ]<br>      },<br>      {<br>        "name": "controllerName",<br>        "operator": "Include",<br>        "values": [<br>          "*"<br>        ]<br>      }<br>    ],<br>    "frequency": "PT1M",<br>    "metric_name": "restartingContainerCount",<br>    "metric_namespace": "Insights.Container/pods",<br>    "operator": "GreaterThan",<br>    "threshold": 0,<br>    "window_size": "PT1M"<br>  },<br>  "node_cpu": {<br>    "aggregation": "Average",<br>    "dimension": [<br>      {<br>        "name": "host",<br>        "operator": "Include",<br>        "values": [<br>          "*"<br>        ]<br>      }<br>    ],<br>    "frequency": "PT1M",<br>    "metric_name": "cpuUsagePercentage",<br>    "metric_namespace": "Insights.Container/nodes",<br>    "operator": "GreaterThan",<br>    "threshold": 80,<br>    "window_size": "PT5M"<br>  },<br>  "node_disk": {<br>    "aggregation": "Average",<br>    "dimension": [<br>      {<br>        "name": "host",<br>        "operator": "Include",<br>        "values": [<br>          "*"<br>        ]<br>      },<br>      {<br>        "name": "device",<br>        "operator": "Include",<br>        "values": [<br>          "*"<br>        ]<br>      }<br>    ],<br>    "frequency": "PT1M",<br>    "metric_name": "DiskUsedPercentage",<br>    "metric_namespace": "Insights.Container/nodes",<br>    "operator": "GreaterThan",<br>    "threshold": 80,<br>    "window_size": "PT5M"<br>  },<br>  "node_memory": {<br>    "aggregation": "Average",<br>    "dimension": [<br>      {<br>        "name": "host",<br>        "operator": "Include",<br>        "values": [<br>          "*"<br>        ]<br>      }<br>    ],<br>    "frequency": "PT1M",<br>    "metric_name": "memoryWorkingSetPercentage",<br>    "metric_namespace": "Insights.Container/nodes",<br>    "operator": "GreaterThan",<br>    "threshold": 80,<br>    "window_size": "PT5M"<br>  },<br>  "node_not_ready": {<br>    "aggregation": "Average",<br>    "dimension": [<br>      {<br>        "name": "status",<br>        "operator": "Include",<br>        "values": [<br>          "NotReady"<br>        ]<br>      }<br>    ],<br>    "frequency": "PT1M",<br>    "metric_name": "nodesCount",<br>    "metric_namespace": "Insights.Container/nodes",<br>    "operator": "GreaterThan",<br>    "threshold": 0,<br>    "window_size": "PT5M"<br>  },<br>  "pods_failed": {<br>    "aggregation": "Average",<br>    "dimension": [<br>      {<br>        "name": "phase",<br>        "operator": "Include",<br>        "values": [<br>          "Failed"<br>        ]<br>      }<br>    ],<br>    "frequency": "PT1M",<br>    "metric_name": "podCount",<br>    "metric_namespace": "Insights.Container/pods",<br>    "operator": "GreaterThan",<br>    "threshold": 0,<br>    "window_size": "PT5M"<br>  },<br>  "pods_ready": {<br>    "aggregation": "Average",<br>    "dimension": [<br>      {<br>        "name": "kubernetes namespace",<br>        "operator": "Include",<br>        "values": [<br>          "*"<br>        ]<br>      },<br>      {<br>        "name": "controllerName",<br>        "operator": "Include",<br>        "values": [<br>          "*"<br>        ]<br>      }<br>    ],<br>    "frequency": "PT1M",<br>    "metric_name": "PodReadyPercentage",<br>    "metric_namespace": "Insights.Container/pods",<br>    "operator": "LessThan",<br>    "threshold": 80,<br>    "window_size": "PT5M"<br>  }<br>}</pre> | no |
| <a name="input_aks_num_outbound_ips"></a> [aks\_num\_outbound\_ips](#input\_aks\_num\_outbound\_ips) | How many outbound ips allocate for AKS cluster | `number` | `1` | no |
| <a name="input_aks_platform_env"></a> [aks\_platform\_env](#input\_aks\_platform\_env) | The env name used into aks platform folder. E.g: dev01 | `string` | n/a | yes |
| <a name="input_aks_sku_tier"></a> [aks\_sku\_tier](#input\_aks\_sku\_tier) | The SKU Tier that should be used for this Kubernetes Cluster. | `string` | `"Free"` | no |
| <a name="input_aks_system_node_pool_node_count_max"></a> [aks\_system\_node\_pool\_node\_count\_max](#input\_aks\_system\_node\_pool\_node\_count\_max) | The maximum number of nodes which should exist in this Node Pool. Between 1 and 1000 | `number` | n/a | yes |
| <a name="input_aks_system_node_pool_node_count_min"></a> [aks\_system\_node\_pool\_node\_count\_min](#input\_aks\_system\_node\_pool\_node\_count\_min) | The minimum number of nodes which should exist in this Node Pool. Between 1 and 1000 | `number` | n/a | yes |
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
| <a name="input_app_gateway_api_certificate_name"></a> [app\_gateway\_api\_certificate\_name](#input\_app\_gateway\_api\_certificate\_name) | Application gateway: api certificate name on Key Vault | `string` | n/a | yes |
| <a name="input_app_gateway_api_pnpg_certificate_name"></a> [app\_gateway\_api\_pnpg\_certificate\_name](#input\_app\_gateway\_api\_pnpg\_certificate\_name) | Application gateway: api-pnpg certificate name on Key Vault | `string` | n/a | yes |
| <a name="input_app_gateway_max_capacity"></a> [app\_gateway\_max\_capacity](#input\_app\_gateway\_max\_capacity) | n/a | `number` | `2` | no |
| <a name="input_app_gateway_min_capacity"></a> [app\_gateway\_min\_capacity](#input\_app\_gateway\_min\_capacity) | n/a | `number` | `0` | no |
| <a name="input_app_gateway_sku_name"></a> [app\_gateway\_sku\_name](#input\_app\_gateway\_sku\_name) | SKU Name of the App GW | `string` | `"Standard_v2"` | no |
| <a name="input_app_gateway_sku_tier"></a> [app\_gateway\_sku\_tier](#input\_app\_gateway\_sku\_tier) | SKU tier of the App GW | `string` | `"Standard_v2"` | no |
| <a name="input_app_gateway_waf_enabled"></a> [app\_gateway\_waf\_enabled](#input\_app\_gateway\_waf\_enabled) | Enable WAF | `bool` | `false` | no |
| <a name="input_azdo_sp_tls_cert_enabled"></a> [azdo\_sp\_tls\_cert\_enabled](#input\_azdo\_sp\_tls\_cert\_enabled) | Enable Azure DevOps connection for TLS cert management | `string` | `false` | no |
| <a name="input_azuread_service_principal_azure_cdn_frontdoor_id"></a> [azuread\_service\_principal\_azure\_cdn\_frontdoor\_id](#input\_azuread\_service\_principal\_azure\_cdn\_frontdoor\_id) | Azure CDN Front Door Principal ID | `string` | `"f3b3f72f-4770-47a5-8c1e-aa298003be12"` | no |
| <a name="input_cidr_aks_platform_vnet"></a> [cidr\_aks\_platform\_vnet](#input\_cidr\_aks\_platform\_vnet) | vnet for aks platform. | `list(string)` | n/a | yes |
| <a name="input_cidr_pair_vnet"></a> [cidr\_pair\_vnet](#input\_cidr\_pair\_vnet) | Virtual network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_api_config"></a> [cidr\_subnet\_api\_config](#input\_cidr\_subnet\_api\_config) | Address prefixes subnet api config | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_apim"></a> [cidr\_subnet\_apim](#input\_cidr\_subnet\_apim) | Address prefixes subnet api management. | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_appgateway"></a> [cidr\_subnet\_appgateway](#input\_cidr\_subnet\_appgateway) | Application gateway address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_azdoa"></a> [cidr\_subnet\_azdoa](#input\_cidr\_subnet\_azdoa) | Azure DevOps agent network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_contract_storage"></a> [cidr\_subnet\_contract\_storage](#input\_cidr\_subnet\_contract\_storage) | Contracts storage address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_cosmosdb_mongodb"></a> [cidr\_subnet\_cosmosdb\_mongodb](#input\_cidr\_subnet\_cosmosdb\_mongodb) | Application gateway address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_dns_forwarder"></a> [cidr\_subnet\_dns\_forwarder](#input\_cidr\_subnet\_dns\_forwarder) | DNS Forwarder network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_eventhub"></a> [cidr\_subnet\_eventhub](#input\_cidr\_subnet\_eventhub) | EventHub address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_k8s"></a> [cidr\_subnet\_k8s](#input\_cidr\_subnet\_k8s) | Subnet cluster kubernetes. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_load_tests"></a> [cidr\_subnet\_load\_tests](#input\_cidr\_subnet\_load\_tests) | private endpoints address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_logs_storage"></a> [cidr\_subnet\_logs\_storage](#input\_cidr\_subnet\_logs\_storage) | Logs storage address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_pair_dnsforwarder"></a> [cidr\_subnet\_pair\_dnsforwarder](#input\_cidr\_subnet\_pair\_dnsforwarder) | DNS Forwarder network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_postgres"></a> [cidr\_subnet\_postgres](#input\_cidr\_subnet\_postgres) | Database network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_private_endpoints"></a> [cidr\_subnet\_private\_endpoints](#input\_cidr\_subnet\_private\_endpoints) | private endpoints address space. | `list(string)` | n/a | yes |
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
| <a name="input_ddos_protection_plan"></a> [ddos\_protection\_plan](#input\_ddos\_protection\_plan) | Azure Distributed denial of service (DDoS) Protection plan | <pre>object({<br>    id     = string<br>    enable = bool<br>  })</pre> | `null` | no |
| <a name="input_dns_default_ttl_sec"></a> [dns\_default\_ttl\_sec](#input\_dns\_default\_ttl\_sec) | value | `number` | `3600` | no |
| <a name="input_dns_ns_interop_selfcare"></a> [dns\_ns\_interop\_selfcare](#input\_dns\_ns\_interop\_selfcare) | value | `list(string)` | `null` | no |
| <a name="input_dns_zone_prefix"></a> [dns\_zone\_prefix](#input\_dns\_zone\_prefix) | The dns subdomain. | `string` | `"selfcare"` | no |
| <a name="input_docker_registry"></a> [docker\_registry](#input\_docker\_registry) | ACR docker registry configuration | <pre>object({<br>    sku                     = string<br>    zone_redundancy_enabled = bool<br>    geo_replication = object({<br>      enabled                   = bool<br>      regional_endpoint_enabled = bool<br>      zone_redundancy_enabled   = bool<br>    })<br>    network_rule_set = object({<br>      default_action  = string<br>      ip_rule         = list(any)<br>      virtual_network = list(any)<br>    })<br>  })</pre> | n/a | yes |
| <a name="input_enable_app_projects_pipeline"></a> [enable\_app\_projects\_pipeline](#input\_enable\_app\_projects\_pipeline) | If true create the key vault policy to allow used by azure devops app projects pipelines. | `bool` | `false` | no |
| <a name="input_enable_azdoa"></a> [enable\_azdoa](#input\_enable\_azdoa) | Enable Azure DevOps agent. | `bool` | n/a | yes |
| <a name="input_enable_iac_pipeline"></a> [enable\_iac\_pipeline](#input\_enable\_iac\_pipeline) | If true create the key vault policy to allow used by azure devops iac pipelines. | `bool` | `false` | no |
| <a name="input_enable_load_tests_db"></a> [enable\_load\_tests\_db](#input\_enable\_load\_tests\_db) | To provision load tests db | `bool` | n/a | yes |
| <a name="input_enable_spid_test"></a> [enable\_spid\_test](#input\_enable\_spid\_test) | to provision italia/spid-testenv2:1.1.0 | `bool` | `false` | no |
| <a name="input_env"></a> [env](#input\_env) | env directory name | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_eventhub_alerts_enabled"></a> [eventhub\_alerts\_enabled](#input\_eventhub\_alerts\_enabled) | Event hub alerts enabled? | `bool` | `false` | no |
| <a name="input_eventhub_auto_inflate_enabled"></a> [eventhub\_auto\_inflate\_enabled](#input\_eventhub\_auto\_inflate\_enabled) | Is Auto Inflate enabled for the EventHub Namespace? | `bool` | `false` | no |
| <a name="input_eventhub_capacity"></a> [eventhub\_capacity](#input\_eventhub\_capacity) | Specifies the Capacity / Throughput Units for a Standard SKU namespace. | `number` | `null` | no |
| <a name="input_eventhub_ip_rules"></a> [eventhub\_ip\_rules](#input\_eventhub\_ip\_rules) | eventhub network rules | <pre>list(object({<br>    ip_mask = string<br>    action  = string<br>  }))</pre> | `[]` | no |
| <a name="input_eventhub_maximum_throughput_units"></a> [eventhub\_maximum\_throughput\_units](#input\_eventhub\_maximum\_throughput\_units) | Specifies the maximum number of throughput units when Auto Inflate is Enabled | `number` | `null` | no |
| <a name="input_eventhub_metric_alerts"></a> [eventhub\_metric\_alerts](#input\_eventhub\_metric\_alerts) | Map of name = criteria objects | <pre>map(object({<br>    # criteria.*.aggregation to be one of [Average Count Minimum Maximum Total]<br>    aggregation = string<br>    metric_name = string<br>    description = string<br>    # criteria.0.operator to be one of [Equals NotEquals GreaterThan GreaterThanOrEqual LessThan LessThanOrEqual]<br>    operator  = string<br>    threshold = number<br>    # Possible values are PT1M, PT5M, PT15M, PT30M and PT1H<br>    frequency = string<br>    # Possible values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D.<br>    window_size = string<br><br>    dimension = list(object(<br>      {<br>        name     = string<br>        operator = string<br>        values   = list(string)<br>      }<br>    ))<br>  }))</pre> | `{}` | no |
| <a name="input_eventhub_sku_name"></a> [eventhub\_sku\_name](#input\_eventhub\_sku\_name) | Defines which tier to use. | `string` | `"Basic"` | no |
| <a name="input_eventhub_zone_redundant"></a> [eventhub\_zone\_redundant](#input\_eventhub\_zone\_redundant) | Specifies if the EventHub Namespace should be Zone Redundant (created across Availability Zones). | `bool` | `false` | no |
| <a name="input_eventhubs"></a> [eventhubs](#input\_eventhubs) | A list of event hub topics to add to namespace. | <pre>list(object({<br>    name              = string<br>    partitions        = number<br>    message_retention = number<br>    consumers         = list(string)<br>    keys = list(object({<br>      name   = string<br>      listen = bool<br>      send   = bool<br>      manage = bool<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `"pagopa.it"` | no |
| <a name="input_law_daily_quota_gb"></a> [law\_daily\_quota\_gb](#input\_law\_daily\_quota\_gb) | The workspace daily quota for ingestion in GB. | `number` | `-1` | no |
| <a name="input_law_retention_in_days"></a> [law\_retention\_in\_days](#input\_law\_retention\_in\_days) | The workspace data retention in days | `number` | `30` | no |
| <a name="input_law_sku"></a> [law\_sku](#input\_law\_sku) | Sku of the Log Analytics Workspace | `string` | `"PerGB2018"` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | `"westeurope"` | no |
| <a name="input_location_pair"></a> [location\_pair](#input\_location\_pair) | Pair (Secondary) location region (e.g. northeurope) | `string` | n/a | yes |
| <a name="input_location_pair_short"></a> [location\_pair\_short](#input\_location\_pair\_short) | Pair (Secondary) location in short form (e.g. northeurope=neu) | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | Primary location in short form (e.g. westeurope=weu) | `string` | n/a | yes |
| <a name="input_lock_enable"></a> [lock\_enable](#input\_lock\_enable) | Apply locks to block accedentaly deletions. | `bool` | `false` | no |
| <a name="input_logs_account_replication_type"></a> [logs\_account\_replication\_type](#input\_logs\_account\_replication\_type) | logs replication type | `string` | `"LRS"` | no |
| <a name="input_logs_advanced_threat_protection"></a> [logs\_advanced\_threat\_protection](#input\_logs\_advanced\_threat\_protection) | Enable logs threat advanced protection | `bool` | `false` | no |
| <a name="input_logs_delete_retention_days"></a> [logs\_delete\_retention\_days](#input\_logs\_delete\_retention\_days) | Number of days to retain deleted logs | `number` | `1` | no |
| <a name="input_logs_enable_versioning"></a> [logs\_enable\_versioning](#input\_logs\_enable\_versioning) | Enable logs versioning | `bool` | `false` | no |
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
| <a name="input_redis_version"></a> [redis\_version](#input\_redis\_version) | n/a | `number` | `6` | no |
| <a name="input_reverse_proxy_ip"></a> [reverse\_proxy\_ip](#input\_reverse\_proxy\_ip) | AKS external ip. Also the ingress-nginx-controller external ip. Value known after installing the ingress controller. | `string` | `"127.0.0.1"` | no |
| <a name="input_robots_indexed_paths"></a> [robots\_indexed\_paths](#input\_robots\_indexed\_paths) | List of cdn paths to allow robots index | `list(string)` | n/a | yes |
| <a name="input_spa"></a> [spa](#input\_spa) | spa root dirs | `list(string)` | <pre>[<br>  "auth",<br>  "onboarding",<br>  "dashboard"<br>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "CreatedBy": "Terraform"<br>}</pre> | no |
| <a name="input_vnet_aks_ddos_protection_plan"></a> [vnet\_aks\_ddos\_protection\_plan](#input\_vnet\_aks\_ddos\_protection\_plan) | vnet enable ddos protection plan | `bool` | n/a | yes |
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
| <a name="output_subnet_pair_id"></a> [subnet\_pair\_id](#output\_subnet\_pair\_id) | n/a |
| <a name="output_vnet_address_space"></a> [vnet\_address\_space](#output\_vnet\_address\_space) | n/a |
| <a name="output_vnet_name"></a> [vnet\_name](#output\_vnet\_name) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
