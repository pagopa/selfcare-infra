# core

<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | >= 2.33.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.116.0 |
| <a name="requirement_pkcs12"></a> [pkcs12](#requirement\_pkcs12) | 0.0.7 |
| <a name="requirement_random"></a> [random](#requirement\_random) | <= 3.5.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_acr"></a> [acr](#module\_acr) | github.com/pagopa/terraform-azurerm-v3.git//container_registry | v7.50.1 |
| <a name="module_acr_common"></a> [acr\_common](#module\_acr\_common) | github.com/pagopa/terraform-azurerm-v3.git//container_registry | v7.50.1 |
| <a name="module_app_gw"></a> [app\_gw](#module\_app\_gw) | github.com/pagopa/terraform-azurerm-v3.git//app_gateway | v7.50.1 |
| <a name="module_appgateway_snet"></a> [appgateway\_snet](#module\_appgateway\_snet) | github.com/pagopa/terraform-azurerm-v3.git//subnet | v7.50.1 |
| <a name="module_azdoa_li"></a> [azdoa\_li](#module\_azdoa\_li) | github.com/pagopa/terraform-azurerm-v3.git//azure_devops_agent | v7.50.1 |
| <a name="module_azdoa_li_infra"></a> [azdoa\_li\_infra](#module\_azdoa\_li\_infra) | github.com/pagopa/terraform-azurerm-v3.git//azure_devops_agent | v7.50.1 |
| <a name="module_azdoa_snet"></a> [azdoa\_snet](#module\_azdoa\_snet) | github.com/pagopa/terraform-azurerm-v3.git//subnet | v7.50.1 |
| <a name="module_checkout_cdn"></a> [checkout\_cdn](#module\_checkout\_cdn) | github.com/pagopa/terraform-azurerm-v3.git//cdn | v7.50.1 |
| <a name="module_contracts_storage_snet"></a> [contracts\_storage\_snet](#module\_contracts\_storage\_snet) | github.com/pagopa/terraform-azurerm-v3.git//subnet | v7.50.1 |
| <a name="module_cosmosdb_account_mongodb"></a> [cosmosdb\_account\_mongodb](#module\_cosmosdb\_account\_mongodb) | github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_account | v7.50.1 |
| <a name="module_cosmosdb_mongodb_snet"></a> [cosmosdb\_mongodb\_snet](#module\_cosmosdb\_mongodb\_snet) | github.com/pagopa/terraform-azurerm-v3.git//subnet | v7.50.1 |
| <a name="module_dns_forwarder"></a> [dns\_forwarder](#module\_dns\_forwarder) | github.com/pagopa/terraform-azurerm-v3.git//dns_forwarder | v7.50.1 |
| <a name="module_dns_forwarder_pair_subnet"></a> [dns\_forwarder\_pair\_subnet](#module\_dns\_forwarder\_pair\_subnet) | github.com/pagopa/terraform-azurerm-v3.git//subnet | v7.50.1 |
| <a name="module_dns_forwarder_snet"></a> [dns\_forwarder\_snet](#module\_dns\_forwarder\_snet) | github.com/pagopa/terraform-azurerm-v3.git//subnet | v7.50.1 |
| <a name="module_event_hub"></a> [event\_hub](#module\_event\_hub) | github.com/pagopa/terraform-azurerm-v3.git//eventhub | v7.50.1 |
| <a name="module_eventhub_snet"></a> [eventhub\_snet](#module\_eventhub\_snet) | github.com/pagopa/terraform-azurerm-v3.git//subnet | v7.50.1 |
| <a name="module_evh_rds_vm_snet"></a> [evh\_rds\_vm\_snet](#module\_evh\_rds\_vm\_snet) | github.com/pagopa/terraform-azurerm-v3.git//subnet | v7.50.1 |
| <a name="module_jwt"></a> [jwt](#module\_jwt) | github.com/pagopa/terraform-azurerm-v3.git//jwt_keys | jwt_cert_allowed_uses_as_variable |
| <a name="module_jwt_exchange"></a> [jwt\_exchange](#module\_jwt\_exchange) | github.com/pagopa/terraform-azurerm-v3.git//jwt_keys | jwt_cert_allowed_uses_as_variable |
| <a name="module_key_vault"></a> [key\_vault](#module\_key\_vault) | github.com/pagopa/terraform-azurerm-v3.git//key_vault | v7.50.1 |
| <a name="module_load_tests_snet"></a> [load\_tests\_snet](#module\_load\_tests\_snet) | github.com/pagopa/terraform-azurerm-v3.git//subnet | v7.50.1 |
| <a name="module_logs_storage_snet"></a> [logs\_storage\_snet](#module\_logs\_storage\_snet) | github.com/pagopa/terraform-azurerm-v3.git//subnet | v7.50.1 |
| <a name="module_private_endpoints_subnet"></a> [private\_endpoints\_subnet](#module\_private\_endpoints\_subnet) | github.com/pagopa/terraform-azurerm-v3.git//subnet | v7.50.1 |
| <a name="module_redis"></a> [redis](#module\_redis) | github.com/pagopa/terraform-azurerm-v3.git//redis_cache | v7.50.1 |
| <a name="module_redis_snet"></a> [redis\_snet](#module\_redis\_snet) | github.com/pagopa/terraform-azurerm-v3.git//subnet | v7.50.1 |
| <a name="module_secrets_selfcare_status_dev"></a> [secrets\_selfcare\_status\_dev](#module\_secrets\_selfcare\_status\_dev) | github.com/pagopa/terraform-azurerm-v3.git//key_vault_secrets_query | v7.50.1 |
| <a name="module_secrets_selfcare_status_uat"></a> [secrets\_selfcare\_status\_uat](#module\_secrets\_selfcare\_status\_uat) | github.com/pagopa/terraform-azurerm-v3.git//key_vault_secrets_query | v7.50.1 |
| <a name="module_selc-contracts-storage"></a> [selc-contracts-storage](#module\_selc-contracts-storage) | github.com/pagopa/terraform-azurerm-v3.git//storage_account | v7.50.1 |
| <a name="module_selc_logs_storage"></a> [selc\_logs\_storage](#module\_selc\_logs\_storage) | github.com/pagopa/terraform-azurerm-v3.git//storage_account | v7.50.1 |
| <a name="module_selc_ms_core_collections"></a> [selc\_ms\_core\_collections](#module\_selc\_ms\_core\_collections) | github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_mongodb_collection | v7.50.1 |
| <a name="module_spid-test-env"></a> [spid-test-env](#module\_spid-test-env) | ./modules/spid_testenv | n/a |
| <a name="module_spid_logs_encryption_keys"></a> [spid\_logs\_encryption\_keys](#module\_spid\_logs\_encryption\_keys) | github.com/pagopa/terraform-azurerm-v3.git//jwt_keys | jwt_cert_allowed_uses_as_variable |
| <a name="module_vnet"></a> [vnet](#module\_vnet) | github.com/pagopa/terraform-azurerm-v3.git//virtual_network | v7.50.1 |
| <a name="module_vnet_aks_platform"></a> [vnet\_aks\_platform](#module\_vnet\_aks\_platform) | github.com/pagopa/terraform-azurerm-v3.git//virtual_network | v7.50.1 |
| <a name="module_vnet_pair"></a> [vnet\_pair](#module\_vnet\_pair) | github.com/pagopa/terraform-azurerm-v3.git//virtual_network | v7.50.1 |
| <a name="module_vnet_peering_core_2_aks"></a> [vnet\_peering\_core\_2\_aks](#module\_vnet\_peering\_core\_2\_aks) | github.com/pagopa/terraform-azurerm-v3.git//virtual_network_peering | v7.50.1 |
| <a name="module_vnet_peering_pair_vs_aks"></a> [vnet\_peering\_pair\_vs\_aks](#module\_vnet\_peering\_pair\_vs\_aks) | github.com/pagopa/terraform-azurerm-v3.git//virtual_network_peering | v7.50.1 |
| <a name="module_vnet_peering_pair_vs_core"></a> [vnet\_peering\_pair\_vs\_core](#module\_vnet\_peering\_pair\_vs\_core) | github.com/pagopa/terraform-azurerm-v3.git//virtual_network_peering | v7.50.1 |
| <a name="module_vpn"></a> [vpn](#module\_vpn) | github.com/pagopa/terraform-azurerm-v3.git//vpn_gateway | v7.50.1 |
| <a name="module_vpn_pair_dns_forwarder"></a> [vpn\_pair\_dns\_forwarder](#module\_vpn\_pair\_dns\_forwarder) | github.com/pagopa/terraform-azurerm-v3.git//dns_forwarder | v7.50.1 |
| <a name="module_vpn_snet"></a> [vpn\_snet](#module\_vpn\_snet) | github.com/pagopa/terraform-azurerm-v3.git//subnet | v7.50.1 |
| <a name="module_web_test_api"></a> [web\_test\_api](#module\_web\_test\_api) | github.com/pagopa/terraform-azurerm-v3.git//application_insights_web_test_preview | v7.50.1 |

## Resources

| Name | Type |
|------|------|
| [azuread_application.external_oauth2_client_fd](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_application.external_oauth2_issuer](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_application_password.external_oauth2_client_fd_password](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_password) | resource |
| [azuread_service_principal.external_oauth2_client_fd_sp](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azuread_service_principal.external_oauth2_issuer](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) | resource |
| [azurerm_container_group.load_tests_db](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_group) | resource |
| [azurerm_cosmosdb_mongo_database.selc_ms_core](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_mongo_database) | resource |
| [azurerm_dashboard.monitoring-dashboard](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dashboard) | resource |
| [azurerm_dns_a_record.dns_a_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_a_record) | resource |
| [azurerm_dns_a_record.public_api_pnpg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_a_record) | resource |
| [azurerm_dns_caa_record.caa_areariservata](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_caa_record) | resource |
| [azurerm_dns_caa_record.caa_selfcare](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_caa_record) | resource |
| [azurerm_dns_cname_record.dkim-aws-ses-areariservata-pagopa-it](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_cname_record) | resource |
| [azurerm_dns_cname_record.dkim-aws-ses-selfcare-pagopa-it](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_cname_record) | resource |
| [azurerm_dns_mx_record.dns-mx-email-areariservata-pagopa-it](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_mx_record) | resource |
| [azurerm_dns_mx_record.dns-mx-email-selfcare-pagopa-it](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_mx_record) | resource |
| [azurerm_dns_ns_record.dev_areariservata](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_ns_record) | resource |
| [azurerm_dns_ns_record.dev_selfcare](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_ns_record) | resource |
| [azurerm_dns_ns_record.firmaconio_selfcare](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_ns_record) | resource |
| [azurerm_dns_ns_record.interop_selfcare](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_ns_record) | resource |
| [azurerm_dns_ns_record.io_selfcare](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_ns_record) | resource |
| [azurerm_dns_ns_record.uat_areariservata](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_ns_record) | resource |
| [azurerm_dns_ns_record.uat_selfcare](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_ns_record) | resource |
| [azurerm_dns_txt_record.dns-txt-areariservata-pagopa-it-aws-ses](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_txt_record) | resource |
| [azurerm_dns_txt_record.dns-txt-email-areariservata-pagopa-it-aws-ses](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_txt_record) | resource |
| [azurerm_dns_txt_record.dns-txt-email-selfcare-pagopa-it-aws-ses](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_txt_record) | resource |
| [azurerm_dns_txt_record.dns-txt-selfcare-pagopa-it-aws-ses](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_txt_record) | resource |
| [azurerm_dns_zone.areariservata_public](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_zone) | resource |
| [azurerm_dns_zone.selfcare_public](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_zone) | resource |
| [azurerm_key_vault_access_policy.adgroup_admin_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_developers_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_externals_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_security_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.app_gateway_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_app_projects_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_iac_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdo_sp_tls_cert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azure_cdn_frontdoor_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_secret.application_insights_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.cosmosdb_account_mongodb_connection_strings](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.event_hub_connection_strings](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.event_hub_connection_strings_lc](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.event_hub_keys](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.event_hub_keys_lc](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.evh_rds_vm_password](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.external_oauth2_client_fd_sp_client_id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.external_oauth2_client_fd_sp_client_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.external_oauth2_issuer_identifier_uri](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.redis_primary_access_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.selc_contracts_storage_access_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.selc_contracts_storage_blob_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.selc_contracts_storage_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.selc_logs_storage_access_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.selc_logs_storage_blob_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.selc_logs_storage_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.selc_web_storage_access_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.selc_web_storage_blob_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.selc_web_storage_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_linux_virtual_machine.evh_rds_vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_log_analytics_workspace.log_analytics_workspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_management_lock.management_lock](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_lock) | resource |
| [azurerm_management_lock.mongodb_selc_ms_core](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_lock) | resource |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_action_group.error_action_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_action_group.selfcare_status_dev](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_action_group.selfcare_status_uat](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_metric_alert.functions_exceptions](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_nat_gateway.nat_gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway) | resource |
| [azurerm_nat_gateway_public_ip_association.pip_nat_gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway_public_ip_association) | resource |
| [azurerm_network_interface.evh_rds_vm_public](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_interface_security_group_association.evh_rds_vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association) | resource |
| [azurerm_network_profile.network_profile_load_tests_db](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_profile) | resource |
| [azurerm_network_security_group.evh_rds_vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_private_dns_a_record.selc](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_zone.internal_private_dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.private_azurecontainerapps_io](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.privatelink_blob_core_windows_net](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.privatelink_documents_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.privatelink_mongo_cosmos_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.privatelink_redis_cache_windows_net](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.privatelink_servicebus_windows_net](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.internal_env_selfcare_pagopa_it_2_aks_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.internal_env_selfcare_pagopa_it_2_vnet_core](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.internal_env_selfcare_pagopa_it_2_vnet_core_pair](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_azurecontainerapps_io_vnet_pair](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_azurecontainerapps_io_weu_vnet_pair](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_blob_core_windows_net_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_blob_core_windows_net_vnet_pair](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_blob_core_windows_net_vnet_vs_aks_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_documents_azure_com_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_documents_azure_com_vnet_pair](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_documents_azure_com_vnet_vs_aks_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_mongo_cosmos_azure_com_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_mongo_cosmos_azure_com_vnet_pair](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_mongo_cosmos_azure_com_vnet_vs_aks_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_redis_cache_windows_net_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_redis_cache_windows_net_vnet_pair](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_redis_cache_windows_net_vnet_vs_aks_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_servicebus_windows_net_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_servicebus_windows_net_vnet_pair](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.privatelink_servicebus_windows_net_vnet_vs_aks_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_endpoint.contracts_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.logs_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_public_ip.aks_outbound](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_public_ip.aks_outbound_temp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_public_ip.appgateway_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_public_ip.evh_rds](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_public_ip.functions_pip_outbound](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_public_ip.outbound_ip_aks_platform](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_public_ip.pip_outbound](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.azdo_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.checkout_fe_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.dashboards](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.data](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.default_roleassignment_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.docker_registry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.event_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.mongodb_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.nat_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_contracts_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_load_tests_db](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_logs_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_pair_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_vnet_aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.sec_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.client_eventhub_access](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.event_hubs_assignments](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.external_oauth2_issuer_apim_contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_storage_container.selc-contracts-container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container.selc_logs_container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_user_assigned_identity.appgateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_virtual_machine_extension.evh_rds_vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [null_resource.app_io_premium_plans](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.upload_alert_message](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.upload_assets](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.upload_config](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.upload_contract_templates](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.upload_jwks](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.upload_metadata](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.upload_one_trust](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.upload_resources_aggregates](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.upload_resources_anac_data_csv](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.upload_resources_default_product_logo](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.upload_resources_default_product_resources_depict-image](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.upload_resources_ivass_data_csv](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.upload_resources_logo](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.upload_resources_products_logo](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.upload_resources_templates](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.upload_spid_idp_status](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [random_id.pair_dns_forwarder_hash](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_password.evh_rds_vm_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_uuid.identifier_uri](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |
| [random_uuid.scope_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |
| [time_rotating.client](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/rotating) | resource |
| [azuread_application.vpn_app](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/application) | data source |
| [azuread_group.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_security](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_service_principal.app_projects_principal](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |
| [azuread_service_principal.azdo_sp_tls_cert](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |
| [azuread_service_principal.iac_principal](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |
| [azurerm_api_management.apim](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management) | data source |
| [azurerm_api_management.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_eventhub.event_hubs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub) | data source |
| [azurerm_key_vault_certificate.api_pnpg_selfcare_certificate](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_certificate) | data source |
| [azurerm_key_vault_certificate.app_gw_platform](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_certificate) | data source |
| [azurerm_key_vault_secret.alert_error_notification_email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.alert_error_notification_slack](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.apim_publisher_email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.hub_docker_pwd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.hub_docker_user](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.monitor_notification_email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.monitor_notification_opsgenie](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.monitor_notification_slack_email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.sec_storage_id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.sec_workspace_id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [local_file.resources_anac_data_csv](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |
| [local_file.resources_default_product_depict-image](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |
| [local_file.resources_default_product_logo](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |
| [local_file.resources_ivass_data_csv](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aks_alerts_enabled"></a> [aks\_alerts\_enabled](#input\_aks\_alerts\_enabled) | Aks alert enabled? | `bool` | `true` | no |
| <a name="input_aks_kubernetes_version"></a> [aks\_kubernetes\_version](#input\_aks\_kubernetes\_version) | Kubernetes version for AKS | `string` | n/a | yes |
| <a name="input_aks_metric_alerts"></a> [aks\_metric\_alerts](#input\_aks\_metric\_alerts) | Map of name = criteria objects | <pre>map(object({<br/>    # criteria.*.aggregation to be one of [Average Count Minimum Maximum Total]<br/>    aggregation = string<br/>    # "Insights.Container/pods" "Insights.Container/nodes"<br/>    metric_namespace = string<br/>    metric_name      = string<br/>    # criteria.0.operator to be one of [Equals NotEquals GreaterThan GreaterThanOrEqual LessThan LessThanOrEqual]<br/>    operator  = string<br/>    threshold = number<br/>    # Possible values are PT1M, PT5M, PT15M, PT30M and PT1H<br/>    frequency = string<br/>    # Possible values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D.<br/>    window_size = string<br/><br/>    dimension = list(object(<br/>      {<br/>        name     = string<br/>        operator = string<br/>        values   = list(string)<br/>      }<br/>    ))<br/>  }))</pre> | <pre>{<br/>  "container_cpu": {<br/>    "aggregation": "Average",<br/>    "dimension": [<br/>      {<br/>        "name": "kubernetes namespace",<br/>        "operator": "Include",<br/>        "values": [<br/>          "*"<br/>        ]<br/>      },<br/>      {<br/>        "name": "controllerName",<br/>        "operator": "Include",<br/>        "values": [<br/>          "*"<br/>        ]<br/>      }<br/>    ],<br/>    "frequency": "PT1M",<br/>    "metric_name": "cpuExceededPercentage",<br/>    "metric_namespace": "Insights.Container/containers",<br/>    "operator": "GreaterThan",<br/>    "threshold": 95,<br/>    "window_size": "PT5M"<br/>  },<br/>  "container_memory": {<br/>    "aggregation": "Average",<br/>    "dimension": [<br/>      {<br/>        "name": "kubernetes namespace",<br/>        "operator": "Include",<br/>        "values": [<br/>          "*"<br/>        ]<br/>      },<br/>      {<br/>        "name": "controllerName",<br/>        "operator": "Include",<br/>        "values": [<br/>          "*"<br/>        ]<br/>      }<br/>    ],<br/>    "frequency": "PT1M",<br/>    "metric_name": "memoryWorkingSetExceededPercentage",<br/>    "metric_namespace": "Insights.Container/containers",<br/>    "operator": "GreaterThan",<br/>    "threshold": 95,<br/>    "window_size": "PT5M"<br/>  },<br/>  "container_oom": {<br/>    "aggregation": "Average",<br/>    "dimension": [<br/>      {<br/>        "name": "kubernetes namespace",<br/>        "operator": "Include",<br/>        "values": [<br/>          "*"<br/>        ]<br/>      },<br/>      {<br/>        "name": "controllerName",<br/>        "operator": "Include",<br/>        "values": [<br/>          "*"<br/>        ]<br/>      }<br/>    ],<br/>    "frequency": "PT1M",<br/>    "metric_name": "oomKilledContainerCount",<br/>    "metric_namespace": "Insights.Container/pods",<br/>    "operator": "GreaterThan",<br/>    "threshold": 0,<br/>    "window_size": "PT1M"<br/>  },<br/>  "container_restart": {<br/>    "aggregation": "Average",<br/>    "dimension": [<br/>      {<br/>        "name": "kubernetes namespace",<br/>        "operator": "Include",<br/>        "values": [<br/>          "*"<br/>        ]<br/>      },<br/>      {<br/>        "name": "controllerName",<br/>        "operator": "Include",<br/>        "values": [<br/>          "*"<br/>        ]<br/>      }<br/>    ],<br/>    "frequency": "PT1M",<br/>    "metric_name": "restartingContainerCount",<br/>    "metric_namespace": "Insights.Container/pods",<br/>    "operator": "GreaterThan",<br/>    "threshold": 0,<br/>    "window_size": "PT1M"<br/>  },<br/>  "node_cpu": {<br/>    "aggregation": "Average",<br/>    "dimension": [<br/>      {<br/>        "name": "host",<br/>        "operator": "Include",<br/>        "values": [<br/>          "*"<br/>        ]<br/>      }<br/>    ],<br/>    "frequency": "PT1M",<br/>    "metric_name": "cpuUsagePercentage",<br/>    "metric_namespace": "Insights.Container/nodes",<br/>    "operator": "GreaterThan",<br/>    "threshold": 80,<br/>    "window_size": "PT5M"<br/>  },<br/>  "node_disk": {<br/>    "aggregation": "Average",<br/>    "dimension": [<br/>      {<br/>        "name": "host",<br/>        "operator": "Include",<br/>        "values": [<br/>          "*"<br/>        ]<br/>      },<br/>      {<br/>        "name": "device",<br/>        "operator": "Include",<br/>        "values": [<br/>          "*"<br/>        ]<br/>      }<br/>    ],<br/>    "frequency": "PT1M",<br/>    "metric_name": "DiskUsedPercentage",<br/>    "metric_namespace": "Insights.Container/nodes",<br/>    "operator": "GreaterThan",<br/>    "threshold": 80,<br/>    "window_size": "PT5M"<br/>  },<br/>  "node_memory": {<br/>    "aggregation": "Average",<br/>    "dimension": [<br/>      {<br/>        "name": "host",<br/>        "operator": "Include",<br/>        "values": [<br/>          "*"<br/>        ]<br/>      }<br/>    ],<br/>    "frequency": "PT1M",<br/>    "metric_name": "memoryWorkingSetPercentage",<br/>    "metric_namespace": "Insights.Container/nodes",<br/>    "operator": "GreaterThan",<br/>    "threshold": 80,<br/>    "window_size": "PT5M"<br/>  },<br/>  "node_not_ready": {<br/>    "aggregation": "Average",<br/>    "dimension": [<br/>      {<br/>        "name": "status",<br/>        "operator": "Include",<br/>        "values": [<br/>          "NotReady"<br/>        ]<br/>      }<br/>    ],<br/>    "frequency": "PT1M",<br/>    "metric_name": "nodesCount",<br/>    "metric_namespace": "Insights.Container/nodes",<br/>    "operator": "GreaterThan",<br/>    "threshold": 0,<br/>    "window_size": "PT5M"<br/>  },<br/>  "pods_failed": {<br/>    "aggregation": "Average",<br/>    "dimension": [<br/>      {<br/>        "name": "phase",<br/>        "operator": "Include",<br/>        "values": [<br/>          "Failed"<br/>        ]<br/>      }<br/>    ],<br/>    "frequency": "PT1M",<br/>    "metric_name": "podCount",<br/>    "metric_namespace": "Insights.Container/pods",<br/>    "operator": "GreaterThan",<br/>    "threshold": 0,<br/>    "window_size": "PT5M"<br/>  },<br/>  "pods_ready": {<br/>    "aggregation": "Average",<br/>    "dimension": [<br/>      {<br/>        "name": "kubernetes namespace",<br/>        "operator": "Include",<br/>        "values": [<br/>          "*"<br/>        ]<br/>      },<br/>      {<br/>        "name": "controllerName",<br/>        "operator": "Include",<br/>        "values": [<br/>          "*"<br/>        ]<br/>      }<br/>    ],<br/>    "frequency": "PT1M",<br/>    "metric_name": "PodReadyPercentage",<br/>    "metric_namespace": "Insights.Container/pods",<br/>    "operator": "LessThan",<br/>    "threshold": 80,<br/>    "window_size": "PT5M"<br/>  }<br/>}</pre> | no |
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
| <a name="input_app_gateway_alerts_enabled"></a> [app\_gateway\_alerts\_enabled](#input\_app\_gateway\_alerts\_enabled) | Enable alerts | `bool` | `false` | no |
| <a name="input_app_gateway_api_certificate_name"></a> [app\_gateway\_api\_certificate\_name](#input\_app\_gateway\_api\_certificate\_name) | Application gateway: api certificate name on Key Vault | `string` | n/a | yes |
| <a name="input_app_gateway_api_pnpg_certificate_name"></a> [app\_gateway\_api\_pnpg\_certificate\_name](#input\_app\_gateway\_api\_pnpg\_certificate\_name) | Application gateway: api-pnpg certificate name on Key Vault | `string` | n/a | yes |
| <a name="input_app_gateway_max_capacity"></a> [app\_gateway\_max\_capacity](#input\_app\_gateway\_max\_capacity) | n/a | `number` | `2` | no |
| <a name="input_app_gateway_min_capacity"></a> [app\_gateway\_min\_capacity](#input\_app\_gateway\_min\_capacity) | n/a | `number` | `0` | no |
| <a name="input_app_gateway_sku_name"></a> [app\_gateway\_sku\_name](#input\_app\_gateway\_sku\_name) | SKU Name of the App GW | `string` | `"Standard_v2"` | no |
| <a name="input_app_gateway_sku_tier"></a> [app\_gateway\_sku\_tier](#input\_app\_gateway\_sku\_tier) | SKU tier of the App GW | `string` | `"Standard_v2"` | no |
| <a name="input_app_gateway_waf_enabled"></a> [app\_gateway\_waf\_enabled](#input\_app\_gateway\_waf\_enabled) | Enable WAF | `bool` | `false` | no |
| <a name="input_azdo_agent_vm_sku"></a> [azdo\_agent\_vm\_sku](#input\_azdo\_agent\_vm\_sku) | sku of the azdo agent vm | `string` | `"Standard_B1s"` | no |
| <a name="input_azdo_sp_tls_cert_enabled"></a> [azdo\_sp\_tls\_cert\_enabled](#input\_azdo\_sp\_tls\_cert\_enabled) | Enable Azure DevOps connection for TLS cert management | `string` | `false` | no |
| <a name="input_azuread_service_principal_azure_cdn_frontdoor_id"></a> [azuread\_service\_principal\_azure\_cdn\_frontdoor\_id](#input\_azuread\_service\_principal\_azure\_cdn\_frontdoor\_id) | Azure CDN Front Door Principal ID | `string` | `"f3b3f72f-4770-47a5-8c1e-aa298003be12"` | no |
| <a name="input_ca_pnpg_suffix_dns_private_name"></a> [ca\_pnpg\_suffix\_dns\_private\_name](#input\_ca\_pnpg\_suffix\_dns\_private\_name) | CA PNPG suffix private DNS record | `string` | n/a | yes |
| <a name="input_ca_suffix_dns_private_name"></a> [ca\_suffix\_dns\_private\_name](#input\_ca\_suffix\_dns\_private\_name) | CA suffix private DNS record | `string` | n/a | yes |
| <a name="input_cae_zone_redundant"></a> [cae\_zone\_redundant](#input\_cae\_zone\_redundant) | Container App Environment zone redudancy | `bool` | n/a | yes |
| <a name="input_cae_zone_redundant_pnpg"></a> [cae\_zone\_redundant\_pnpg](#input\_cae\_zone\_redundant\_pnpg) | Container App Environment zone redudancy | `bool` | n/a | yes |
| <a name="input_checkout_advanced_threat_protection_enabled"></a> [checkout\_advanced\_threat\_protection\_enabled](#input\_checkout\_advanced\_threat\_protection\_enabled) | Enable checkout threat advanced protection | `string` | `false` | no |
| <a name="input_cidr_aks_platform_vnet"></a> [cidr\_aks\_platform\_vnet](#input\_cidr\_aks\_platform\_vnet) | vnet for aks platform. | `list(string)` | n/a | yes |
| <a name="input_cidr_pair_vnet"></a> [cidr\_pair\_vnet](#input\_cidr\_pair\_vnet) | Virtual network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_api_config"></a> [cidr\_subnet\_api\_config](#input\_cidr\_subnet\_api\_config) | Address prefixes subnet api config | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_appgateway"></a> [cidr\_subnet\_appgateway](#input\_cidr\_subnet\_appgateway) | Application gateway address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_azdoa"></a> [cidr\_subnet\_azdoa](#input\_cidr\_subnet\_azdoa) | Azure DevOps agent network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_contract_storage"></a> [cidr\_subnet\_contract\_storage](#input\_cidr\_subnet\_contract\_storage) | Contracts storage address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_cosmosdb_mongodb"></a> [cidr\_subnet\_cosmosdb\_mongodb](#input\_cidr\_subnet\_cosmosdb\_mongodb) | Application gateway address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_dns_forwarder"></a> [cidr\_subnet\_dns\_forwarder](#input\_cidr\_subnet\_dns\_forwarder) | DNS Forwarder network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_eventhub"></a> [cidr\_subnet\_eventhub](#input\_cidr\_subnet\_eventhub) | EventHub address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_eventhub_rds"></a> [cidr\_subnet\_eventhub\_rds](#input\_cidr\_subnet\_eventhub\_rds) | EventHub rds vm address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_k8s"></a> [cidr\_subnet\_k8s](#input\_cidr\_subnet\_k8s) | Subnet cluster kubernetes. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_load_tests"></a> [cidr\_subnet\_load\_tests](#input\_cidr\_subnet\_load\_tests) | private endpoints address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_logs_storage"></a> [cidr\_subnet\_logs\_storage](#input\_cidr\_subnet\_logs\_storage) | Logs storage address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_pair_dnsforwarder"></a> [cidr\_subnet\_pair\_dnsforwarder](#input\_cidr\_subnet\_pair\_dnsforwarder) | DNS Forwarder network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_postgres"></a> [cidr\_subnet\_postgres](#input\_cidr\_subnet\_postgres) | Database network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_private_endpoints"></a> [cidr\_subnet\_private\_endpoints](#input\_cidr\_subnet\_private\_endpoints) | private endpoints address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_redis"></a> [cidr\_subnet\_redis](#input\_cidr\_subnet\_redis) | Redis network address space. | `list(string)` | `[]` | no |
| <a name="input_cidr_subnet_selc"></a> [cidr\_subnet\_selc](#input\_cidr\_subnet\_selc) | Address prefixes subnet selc ca and functions | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_selc_pnpg"></a> [cidr\_subnet\_selc\_pnpg](#input\_cidr\_subnet\_selc\_pnpg) | Address prefixes subnet selc ca and functions | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_vpn"></a> [cidr\_subnet\_vpn](#input\_cidr\_subnet\_vpn) | VPN network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_vnet"></a> [cidr\_vnet](#input\_cidr\_vnet) | Virtual network address space. | `list(string)` | n/a | yes |
| <a name="input_contracts_account_replication_type"></a> [contracts\_account\_replication\_type](#input\_contracts\_account\_replication\_type) | Contracts replication type | `string` | `"LRS"` | no |
| <a name="input_contracts_advanced_threat_protection"></a> [contracts\_advanced\_threat\_protection](#input\_contracts\_advanced\_threat\_protection) | Enable contract threat advanced protection | `bool` | `false` | no |
| <a name="input_contracts_delete_retention_days"></a> [contracts\_delete\_retention\_days](#input\_contracts\_delete\_retention\_days) | Number of days to retain deleted contracts | `number` | `1` | no |
| <a name="input_contracts_enable_versioning"></a> [contracts\_enable\_versioning](#input\_contracts\_enable\_versioning) | Enable contract versioning | `bool` | `false` | no |
| <a name="input_cosmosdb_mongodb_additional_geo_locations"></a> [cosmosdb\_mongodb\_additional\_geo\_locations](#input\_cosmosdb\_mongodb\_additional\_geo\_locations) | The name of the Azure region to host replicated data and the priority to apply starting from 1. Not used when cosmosdb\_mongodb\_enable\_serverless | <pre>list(object({<br/>    location          = string<br/>    failover_priority = number<br/>    zone_redundant    = bool<br/>  }))</pre> | `[]` | no |
| <a name="input_cosmosdb_mongodb_consistency_policy"></a> [cosmosdb\_mongodb\_consistency\_policy](#input\_cosmosdb\_mongodb\_consistency\_policy) | n/a | <pre>object({<br/>    consistency_level       = string<br/>    max_interval_in_seconds = number<br/>    max_staleness_prefix    = number<br/>  })</pre> | <pre>{<br/>  "consistency_level": "Session",<br/>  "max_interval_in_seconds": null,<br/>  "max_staleness_prefix": null<br/>}</pre> | no |
| <a name="input_cosmosdb_mongodb_enable_autoscaling"></a> [cosmosdb\_mongodb\_enable\_autoscaling](#input\_cosmosdb\_mongodb\_enable\_autoscaling) | It will enable autoscaling mode. If true, cosmosdb\_mongodb\_throughput must be unset | `bool` | `false` | no |
| <a name="input_cosmosdb_mongodb_enable_free_tier"></a> [cosmosdb\_mongodb\_enable\_free\_tier](#input\_cosmosdb\_mongodb\_enable\_free\_tier) | Enable Free Tier pricing option for this Cosmos DB account | `bool` | `true` | no |
| <a name="input_cosmosdb_mongodb_extra_capabilities"></a> [cosmosdb\_mongodb\_extra\_capabilities](#input\_cosmosdb\_mongodb\_extra\_capabilities) | Enable cosmosdb extra capabilities | `list(string)` | `[]` | no |
| <a name="input_cosmosdb_mongodb_main_geo_location_zone_redundant"></a> [cosmosdb\_mongodb\_main\_geo\_location\_zone\_redundant](#input\_cosmosdb\_mongodb\_main\_geo\_location\_zone\_redundant) | Enable zone redundant Comsmos DB | `bool` | n/a | yes |
| <a name="input_cosmosdb_mongodb_max_throughput"></a> [cosmosdb\_mongodb\_max\_throughput](#input\_cosmosdb\_mongodb\_max\_throughput) | The maximum throughput of the MongoDB database (RU/s). Must be between 4,000 and 1,000,000. Must be set in increments of 1,000. Conflicts with throughput | `number` | `4000` | no |
| <a name="input_cosmosdb_mongodb_offer_type"></a> [cosmosdb\_mongodb\_offer\_type](#input\_cosmosdb\_mongodb\_offer\_type) | Specifies the Offer Type to use for this CosmosDB Account - currently this can only be set to Standard | `string` | `"Standard"` | no |
| <a name="input_cosmosdb_mongodb_private_endpoint_enabled"></a> [cosmosdb\_mongodb\_private\_endpoint\_enabled](#input\_cosmosdb\_mongodb\_private\_endpoint\_enabled) | Enable private endpoint for Comsmos DB | `bool` | `true` | no |
| <a name="input_cosmosdb_mongodb_public_network_access_enabled"></a> [cosmosdb\_mongodb\_public\_network\_access\_enabled](#input\_cosmosdb\_mongodb\_public\_network\_access\_enabled) | Whether or not public network access is allowed for this CosmosDB account | `bool` | `false` | no |
| <a name="input_cosmosdb_mongodb_throughput"></a> [cosmosdb\_mongodb\_throughput](#input\_cosmosdb\_mongodb\_throughput) | The throughput of the MongoDB database (RU/s). Must be set in increments of 100. The minimum value is 400. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply. | `number` | `400` | no |
| <a name="input_ddos_protection_plan"></a> [ddos\_protection\_plan](#input\_ddos\_protection\_plan) | Azure Distributed denial of service (DDoS) Protection plan | <pre>object({<br/>    id     = string<br/>    enable = bool<br/>  })</pre> | `null` | no |
| <a name="input_dns_default_ttl_sec"></a> [dns\_default\_ttl\_sec](#input\_dns\_default\_ttl\_sec) | value | `number` | `3600` | no |
| <a name="input_dns_ns_interop_selfcare"></a> [dns\_ns\_interop\_selfcare](#input\_dns\_ns\_interop\_selfcare) | value | `list(string)` | `null` | no |
| <a name="input_dns_zone_prefix"></a> [dns\_zone\_prefix](#input\_dns\_zone\_prefix) | The dns subdomain. | `string` | `"selfcare"` | no |
| <a name="input_dns_zone_prefix_ar"></a> [dns\_zone\_prefix\_ar](#input\_dns\_zone\_prefix\_ar) | The dns subdomain. | `string` | `"areariservat"` | no |
| <a name="input_docker_registry"></a> [docker\_registry](#input\_docker\_registry) | ACR docker registry configuration | <pre>object({<br/>    sku                     = string<br/>    zone_redundancy_enabled = bool<br/>    geo_replication = object({<br/>      enabled                   = bool<br/>      regional_endpoint_enabled = bool<br/>      zone_redundancy_enabled   = bool<br/>    })<br/>    network_rule_set = object({<br/>      default_action  = string<br/>      ip_rule         = list(any)<br/>      virtual_network = list(any)<br/>    })<br/>  })</pre> | n/a | yes |
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
| <a name="input_eventhub_ip_rules"></a> [eventhub\_ip\_rules](#input\_eventhub\_ip\_rules) | eventhub network rules | <pre>list(object({<br/>    ip_mask = string<br/>    action  = string<br/>  }))</pre> | `[]` | no |
| <a name="input_eventhub_maximum_throughput_units"></a> [eventhub\_maximum\_throughput\_units](#input\_eventhub\_maximum\_throughput\_units) | Specifies the maximum number of throughput units when Auto Inflate is Enabled | `number` | `null` | no |
| <a name="input_eventhub_metric_alerts"></a> [eventhub\_metric\_alerts](#input\_eventhub\_metric\_alerts) | Map of name = criteria objects | <pre>map(object({<br/>    # criteria.*.aggregation to be one of [Average Count Minimum Maximum Total]<br/>    aggregation = string<br/>    metric_name = string<br/>    description = string<br/>    # criteria.0.operator to be one of [Equals NotEquals GreaterThan GreaterThanOrEqual LessThan LessThanOrEqual]<br/>    operator  = string<br/>    threshold = number<br/>    # Possible values are PT1M, PT5M, PT15M, PT30M and PT1H<br/>    frequency = string<br/>    # Possible values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D.<br/>    window_size = string<br/><br/>    dimension = list(object(<br/>      {<br/>        name     = string<br/>        operator = string<br/>        values   = list(string)<br/>      }<br/>    ))<br/>  }))</pre> | `{}` | no |
| <a name="input_eventhub_rds_vm"></a> [eventhub\_rds\_vm](#input\_eventhub\_rds\_vm) | n/a | <pre>object({<br/>    size                = string<br/>    allowed_ipaddresses = list(string)<br/>  })</pre> | n/a | yes |
| <a name="input_eventhub_sku_name"></a> [eventhub\_sku\_name](#input\_eventhub\_sku\_name) | Defines which tier to use. | `string` | `"Basic"` | no |
| <a name="input_eventhub_zone_redundant"></a> [eventhub\_zone\_redundant](#input\_eventhub\_zone\_redundant) | Specifies if the EventHub Namespace should be Zone Redundant (created across Availability Zones). | `bool` | `false` | no |
| <a name="input_eventhubs"></a> [eventhubs](#input\_eventhubs) | A list of event hub topics to add to namespace. | <pre>list(object({<br/>    name              = string<br/>    partitions        = number<br/>    message_retention = number<br/>    consumers         = list(string)<br/>    keys = list(object({<br/>      name   = string<br/>      listen = bool<br/>      send   = bool<br/>      manage = bool<br/>    }))<br/>    iam_roles = optional(map(string), {})<br/>  }))</pre> | `[]` | no |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `"pagopa.it"` | no |
| <a name="input_k8s_kube_config_path_prefix"></a> [k8s\_kube\_config\_path\_prefix](#input\_k8s\_kube\_config\_path\_prefix) | n/a | `string` | `"~/.kube"` | no |
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
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | `"selc"` | no |
| <a name="input_private_dns_name"></a> [private\_dns\_name](#input\_private\_dns\_name) | AKS private DNS record | `string` | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Enable or Disable public access. It should always set to false unless there are special needs | `bool` | n/a | yes |
| <a name="input_redis_capacity"></a> [redis\_capacity](#input\_redis\_capacity) | # Redis cache | `number` | `1` | no |
| <a name="input_redis_family"></a> [redis\_family](#input\_redis\_family) | n/a | `string` | `"C"` | no |
| <a name="input_redis_private_endpoint_enabled"></a> [redis\_private\_endpoint\_enabled](#input\_redis\_private\_endpoint\_enabled) | n/a | `bool` | `true` | no |
| <a name="input_redis_sku_name"></a> [redis\_sku\_name](#input\_redis\_sku\_name) | n/a | `string` | `"Standard"` | no |
| <a name="input_redis_version"></a> [redis\_version](#input\_redis\_version) | n/a | `number` | `6` | no |
| <a name="input_reverse_proxy_ip"></a> [reverse\_proxy\_ip](#input\_reverse\_proxy\_ip) | AKS external ip. Also the ingress-nginx-controller external ip. Value known after installing the ingress controller. | `string` | `"127.0.0.1"` | no |
| <a name="input_robots_indexed_paths"></a> [robots\_indexed\_paths](#input\_robots\_indexed\_paths) | List of cdn paths to allow robots index | `list(string)` | n/a | yes |
| <a name="input_spa"></a> [spa](#input\_spa) | spa root dirs | `list(string)` | <pre>[<br/>  "auth",<br/>  "onboarding",<br/>  "dashboard"<br/>]</pre> | no |
| <a name="input_spid_pnpg_path_prefix"></a> [spid\_pnpg\_path\_prefix](#input\_spid\_pnpg\_path\_prefix) | Path prefix to hub spid login | `string` | `"/spid/v1"` | no |
| <a name="input_spid_selc_path_prefix"></a> [spid\_selc\_path\_prefix](#input\_spid\_selc\_path\_prefix) | Path prefix to hub spid login | `string` | `"/spid/v1"` | no |
| <a name="input_system_node_pool_enable_host_encryption"></a> [system\_node\_pool\_enable\_host\_encryption](#input\_system\_node\_pool\_enable\_host\_encryption) | (Optional) Should the nodes in the Default Node Pool have host encryption enabled? Defaults to true. | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br/>  "CreatedBy": "Terraform"<br/>}</pre> | no |
| <a name="input_user_node_pool_node_labels"></a> [user\_node\_pool\_node\_labels](#input\_user\_node\_pool\_node\_labels) | (Optional) A map of Kubernetes labels which should be applied to nodes in the Default Node Pool. Changing this forces a new resource to be created. | `map(string)` | `{}` | no |
| <a name="input_vnet_aks_ddos_protection_plan"></a> [vnet\_aks\_ddos\_protection\_plan](#input\_vnet\_aks\_ddos\_protection\_plan) | vnet enable ddos protection plan | `bool` | n/a | yes |
| <a name="input_vpn_pip_sku"></a> [vpn\_pip\_sku](#input\_vpn\_pip\_sku) | VPN GW PIP SKU | `string` | `"Basic"` | no |
| <a name="input_vpn_sku"></a> [vpn\_sku](#input\_vpn\_sku) | VPN Gateway SKU | `string` | `"VpnGw1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aks_outbound_ips"></a> [aks\_outbound\_ips](#output\_aks\_outbound\_ips) | n/a |
| <a name="output_aks_outbound_temp_ips"></a> [aks\_outbound\_temp\_ips](#output\_aks\_outbound\_temp\_ips) | n/a |
| <a name="output_api_fqdn"></a> [api\_fqdn](#output\_api\_fqdn) | n/a |
| <a name="output_app_gateway_fqdn"></a> [app\_gateway\_fqdn](#output\_app\_gateway\_fqdn) | n/a |
| <a name="output_app_gateway_public_ip"></a> [app\_gateway\_public\_ip](#output\_app\_gateway\_public\_ip) | # Application gateway. |
| <a name="output_ca_suffix_dns_private_name"></a> [ca\_suffix\_dns\_private\_name](#output\_ca\_suffix\_dns\_private\_name) | n/a |
| <a name="output_cosmosdb_account_mongodb_connection_strings"></a> [cosmosdb\_account\_mongodb\_connection\_strings](#output\_cosmosdb\_account\_mongodb\_connection\_strings) | n/a |
| <a name="output_cosmosdb_account_mongodb_endpoint"></a> [cosmosdb\_account\_mongodb\_endpoint](#output\_cosmosdb\_account\_mongodb\_endpoint) | n/a |
| <a name="output_cosmosdb_account_mongodb_id"></a> [cosmosdb\_account\_mongodb\_id](#output\_cosmosdb\_account\_mongodb\_id) | # CosmosDb - MongoDB ## |
| <a name="output_cosmosdb_account_mongodb_primary_key"></a> [cosmosdb\_account\_mongodb\_primary\_key](#output\_cosmosdb\_account\_mongodb\_primary\_key) | n/a |
| <a name="output_cosmosdb_account_mongodb_primary_readonly_key"></a> [cosmosdb\_account\_mongodb\_primary\_readonly\_key](#output\_cosmosdb\_account\_mongodb\_primary\_readonly\_key) | n/a |
| <a name="output_evh_rds_addresses"></a> [evh\_rds\_addresses](#output\_evh\_rds\_addresses) | n/a |
| <a name="output_key_vault_name"></a> [key\_vault\_name](#output\_key\_vault\_name) | n/a |
| <a name="output_key_vault_uri"></a> [key\_vault\_uri](#output\_key\_vault\_uri) | # key vault ## |
| <a name="output_private_dns_name"></a> [private\_dns\_name](#output\_private\_dns\_name) | n/a |
| <a name="output_redis_hostname"></a> [redis\_hostname](#output\_redis\_hostname) | n/a |
| <a name="output_redis_port"></a> [redis\_port](#output\_redis\_port) | n/a |
| <a name="output_redis_primary_access_key"></a> [redis\_primary\_access\_key](#output\_redis\_primary\_access\_key) | # Redis cache |
| <a name="output_redis_ssl_port"></a> [redis\_ssl\_port](#output\_redis\_ssl\_port) | n/a |
| <a name="output_reverse_proxy_ip"></a> [reverse\_proxy\_ip](#output\_reverse\_proxy\_ip) | n/a |
| <a name="output_subnet_pair_id"></a> [subnet\_pair\_id](#output\_subnet\_pair\_id) | n/a |
| <a name="output_vnet_address_space"></a> [vnet\_address\_space](#output\_vnet\_address\_space) | n/a |
| <a name="output_vnet_name"></a> [vnet\_name](#output\_vnet\_name) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
