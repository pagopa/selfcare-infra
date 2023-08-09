<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | = 2.33.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.45.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | = 2.7.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | = 2.18.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_apim_external_api_data_vault_v1"></a> [apim\_external\_api\_data\_vault\_v1](#module\_apim\_external\_api\_data\_vault\_v1) | git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api | v4.1.17 |
| <a name="module_apim_external_api_ms_v2"></a> [apim\_external\_api\_ms\_v2](#module\_apim\_external\_api\_ms\_v2) | git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api | v4.1.17 |
| <a name="module_apim_pnpg"></a> [apim\_pnpg](#module\_apim\_pnpg) | git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product | v4.1.17 |
| <a name="module_apim_pnpg_product_pn_pg"></a> [apim\_pnpg\_product\_pn\_pg](#module\_apim\_pnpg\_product\_pn\_pg) | git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product | v4.1.17 |
| <a name="module_apim_product_pnpg_dev"></a> [apim\_product\_pnpg\_dev](#module\_apim\_product\_pnpg\_dev) | git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product | v4.1.17 |
| <a name="module_apim_product_pnpg_hotfix"></a> [apim\_product\_pnpg\_hotfix](#module\_apim\_product\_pnpg\_hotfix) | git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product | v4.1.17 |
| <a name="module_apim_product_pnpg_test"></a> [apim\_product\_pnpg\_test](#module\_apim\_product\_pnpg\_test) | git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product | v4.1.17 |
| <a name="module_apim_product_pnpg_uat"></a> [apim\_product\_pnpg\_uat](#module\_apim\_product\_pnpg\_uat) | git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product | v4.1.17 |
| <a name="module_apim_product_pnpg_uat_cert"></a> [apim\_product\_pnpg\_uat\_cert](#module\_apim\_product\_pnpg\_uat\_cert) | git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product | v4.1.17 |
| <a name="module_apim_product_pnpg_uat_coll"></a> [apim\_product\_pnpg\_uat\_coll](#module\_apim\_product\_pnpg\_uat\_coll) | git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product | v4.1.17 |
| <a name="module_apim_product_pnpg_uat_svil"></a> [apim\_product\_pnpg\_uat\_svil](#module\_apim\_product\_pnpg\_uat\_svil) | git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product | v4.1.17 |
| <a name="module_domain_pod_identity"></a> [domain\_pod\_identity](#module\_domain\_pod\_identity) | git::https://github.com/pagopa/terraform-azurerm-v3.git//kubernetes_pod_identity | v4.1.17 |
| <a name="module_key_vault_secrets_query"></a> [key\_vault\_secrets\_query](#module\_key\_vault\_secrets\_query) | git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault_secrets_query | v5.1.0 |
| <a name="module_tls_checker"></a> [tls\_checker](#module\_tls\_checker) | git::https://github.com/pagopa/terraform-azurerm-v3.git//tls_checker | v6.7.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_api_management_api_version_set.apim_external_api_data_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.apim_external_api_v2_for_pnpg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_named_value.apim_named_value_backend_access_token](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_key_vault_secret.apim_service_account_access_token](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.appinsights-instrumentation-key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.azure_devops_aks_apiserver_url](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.azure_devops_sa_cacrt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.azure_devops_sa_token](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_monitor_action_group.http_status](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_metric_alert.pnpg_error_5xx](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_private_dns_a_record.ingress](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [helm_release.reloader](https://registry.terraform.io/providers/hashicorp/helm/2.7.1/docs/resources/release) | resource |
| [kubernetes_config_map.aruba-sign-service](https://registry.terraform.io/providers/hashicorp/kubernetes/2.18.1/docs/resources/config_map) | resource |
| [kubernetes_config_map.common](https://registry.terraform.io/providers/hashicorp/kubernetes/2.18.1/docs/resources/config_map) | resource |
| [kubernetes_config_map.geo-taxonomies](https://registry.terraform.io/providers/hashicorp/kubernetes/2.18.1/docs/resources/config_map) | resource |
| [kubernetes_config_map.hub-spid-login-ms](https://registry.terraform.io/providers/hashicorp/kubernetes/2.18.1/docs/resources/config_map) | resource |
| [kubernetes_config_map.infocamere-service](https://registry.terraform.io/providers/hashicorp/kubernetes/2.18.1/docs/resources/config_map) | resource |
| [kubernetes_config_map.inner-service-url](https://registry.terraform.io/providers/hashicorp/kubernetes/2.18.1/docs/resources/config_map) | resource |
| [kubernetes_config_map.interop-be-party-process](https://registry.terraform.io/providers/hashicorp/kubernetes/2.18.1/docs/resources/config_map) | resource |
| [kubernetes_config_map.jwt](https://registry.terraform.io/providers/hashicorp/kubernetes/2.18.1/docs/resources/config_map) | resource |
| [kubernetes_config_map.jwt-exchange](https://registry.terraform.io/providers/hashicorp/kubernetes/2.18.1/docs/resources/config_map) | resource |
| [kubernetes_config_map.jwt-social](https://registry.terraform.io/providers/hashicorp/kubernetes/2.18.1/docs/resources/config_map) | resource |
| [kubernetes_config_map.national-registries-service](https://registry.terraform.io/providers/hashicorp/kubernetes/2.18.1/docs/resources/config_map) | resource |
| [kubernetes_config_map.selfcare-core](https://registry.terraform.io/providers/hashicorp/kubernetes/2.18.1/docs/resources/config_map) | resource |
| [kubernetes_ingress_v1.selc_ingress](https://registry.terraform.io/providers/hashicorp/kubernetes/2.18.1/docs/resources/ingress_v1) | resource |
| [kubernetes_namespace.domain_namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/2.18.1/docs/resources/namespace) | resource |
| [kubernetes_namespace.system_domain_namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/2.18.1/docs/resources/namespace) | resource |
| [kubernetes_role_binding.deployer_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/2.18.1/docs/resources/role_binding) | resource |
| [kubernetes_role_binding.system_deployer_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/2.18.1/docs/resources/role_binding) | resource |
| [kubernetes_role_binding.tokenreview_role_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/2.18.1/docs/resources/role_binding) | resource |
| [kubernetes_secret.aruba-sign-service-secrets](https://registry.terraform.io/providers/hashicorp/kubernetes/2.18.1/docs/resources/secret) | resource |
| [kubernetes_secret.b4f-dashboard](https://registry.terraform.io/providers/hashicorp/kubernetes/2.18.1/docs/resources/secret) | resource |
| [kubernetes_secret.cdn-storage](https://registry.terraform.io/providers/hashicorp/kubernetes/2.18.1/docs/resources/secret) | resource |
| [kubernetes_secret.common-secrets](https://registry.terraform.io/providers/hashicorp/kubernetes/2.18.1/docs/resources/secret) | resource |
| [kubernetes_secret.contracts-storage](https://registry.terraform.io/providers/hashicorp/kubernetes/2.18.1/docs/resources/secret) | resource |
| [kubernetes_secret.event-secrets](https://registry.terraform.io/providers/hashicorp/kubernetes/2.18.1/docs/resources/secret) | resource |
| [kubernetes_secret.hub-spid-login-ms](https://registry.terraform.io/providers/hashicorp/kubernetes/2.18.1/docs/resources/secret) | resource |
| [kubernetes_secret.infocamere-service-secrets](https://registry.terraform.io/providers/hashicorp/kubernetes/2.18.1/docs/resources/secret) | resource |
| [kubernetes_secret.mail](https://registry.terraform.io/providers/hashicorp/kubernetes/2.18.1/docs/resources/secret) | resource |
| [kubernetes_secret.mail-not-pec](https://registry.terraform.io/providers/hashicorp/kubernetes/2.18.1/docs/resources/secret) | resource |
| [kubernetes_secret.mongo-credentials](https://registry.terraform.io/providers/hashicorp/kubernetes/2.18.1/docs/resources/secret) | resource |
| [kubernetes_secret.national-registry-secrets](https://registry.terraform.io/providers/hashicorp/kubernetes/2.18.1/docs/resources/secret) | resource |
| [kubernetes_secret.onboarding-interceptor-apim-internal](https://registry.terraform.io/providers/hashicorp/kubernetes/2.18.1/docs/resources/secret) | resource |
| [kubernetes_secret.onboarding-interceptor-event-secrets](https://registry.terraform.io/providers/hashicorp/kubernetes/2.18.1/docs/resources/secret) | resource |
| [kubernetes_secret.postgres](https://registry.terraform.io/providers/hashicorp/kubernetes/2.18.1/docs/resources/secret) | resource |
| [kubernetes_secret.product-external-api](https://registry.terraform.io/providers/hashicorp/kubernetes/2.18.1/docs/resources/secret) | resource |
| [kubernetes_secret.selc-application-insights](https://registry.terraform.io/providers/hashicorp/kubernetes/2.18.1/docs/resources/secret) | resource |
| [kubernetes_secret.selc-redis-credentials](https://registry.terraform.io/providers/hashicorp/kubernetes/2.18.1/docs/resources/secret) | resource |
| [kubernetes_secret.social-login](https://registry.terraform.io/providers/hashicorp/kubernetes/2.18.1/docs/resources/secret) | resource |
| [kubernetes_secret.uservice-party-management](https://registry.terraform.io/providers/hashicorp/kubernetes/2.18.1/docs/resources/secret) | resource |
| [kubernetes_secret.uservice-party-process](https://registry.terraform.io/providers/hashicorp/kubernetes/2.18.1/docs/resources/secret) | resource |
| [kubernetes_secret_v1.apim_service_account_default_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/2.18.1/docs/resources/secret_v1) | resource |
| [kubernetes_secret_v1.azure_devops_service_account_default_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/2.18.1/docs/resources/secret_v1) | resource |
| [kubernetes_service_account.apim_service_account](https://registry.terraform.io/providers/hashicorp/kubernetes/2.18.1/docs/resources/service_account) | resource |
| [kubernetes_service_account.azure_devops](https://registry.terraform.io/providers/hashicorp/kubernetes/2.18.1/docs/resources/service_account) | resource |
| [kubernetes_service_account.in_cluster_app_service_account](https://registry.terraform.io/providers/hashicorp/kubernetes/2.18.1/docs/resources/service_account) | resource |
| [null_resource.upload_assets](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.upload_one_trust](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [azuread_group.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azuread/2.33.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/2.33.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/2.33.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_security](https://registry.terraform.io/providers/hashicorp/azuread/2.33.0/docs/data-sources/group) | data source |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_insights) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_dns_zone.public](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/dns_zone) | data source |
| [azurerm_key_vault.kv_domain](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.apim_backend_access_token](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_cluster) | data source |
| [azurerm_log_analytics_workspace.log_analytics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_private_dns_zone.internal](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [kubernetes_secret.apim_service_account_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/2.18.1/docs/data-sources/secret) | data source |
| [kubernetes_secret.azure_devops_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/2.18.1/docs/data-sources/secret) | data source |
| [terraform_remote_state.core](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aks_name"></a> [aks\_name](#input\_aks\_name) | AKS cluster name | `string` | n/a | yes |
| <a name="input_aks_resource_group_name"></a> [aks\_resource\_group\_name](#input\_aks\_resource\_group\_name) | AKS cluster resource name | `string` | n/a | yes |
| <a name="input_api_gateway_url"></a> [api\_gateway\_url](#input\_api\_gateway\_url) | n/a | `string` | n/a | yes |
| <a name="input_aruba_sign_service"></a> [aruba\_sign\_service](#input\_aruba\_sign\_service) | n/a | `map(string)` | n/a | yes |
| <a name="input_configmaps_common"></a> [configmaps\_common](#input\_configmaps\_common) | n/a | `map(string)` | n/a | yes |
| <a name="input_configmaps_hub-spid-login-ms"></a> [configmaps\_hub-spid-login-ms](#input\_configmaps\_hub-spid-login-ms) | n/a | `map(string)` | n/a | yes |
| <a name="input_configmaps_interop-be-party-process"></a> [configmaps\_interop-be-party-process](#input\_configmaps\_interop-be-party-process) | ConfigMaps & Secrets | `map(string)` | n/a | yes |
| <a name="input_configmaps_ms_core"></a> [configmaps\_ms\_core](#input\_configmaps\_ms\_core) | n/a | `map(string)` | n/a | yes |
| <a name="input_configmaps_national_registries"></a> [configmaps\_national\_registries](#input\_configmaps\_national\_registries) | n/a | `map(string)` | n/a | yes |
| <a name="input_default_service_port"></a> [default\_service\_port](#input\_default\_service\_port) | n/a | `number` | `8080` | no |
| <a name="input_dns_zone_internal_prefix"></a> [dns\_zone\_internal\_prefix](#input\_dns\_zone\_internal\_prefix) | The dns subdomain. | `string` | `null` | no |
| <a name="input_dns_zone_prefix"></a> [dns\_zone\_prefix](#input\_dns\_zone\_prefix) | The dns subdomain. | `string` | `"selfcare"` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `"pagopa.it"` | no |
| <a name="input_geo-taxonomies"></a> [geo-taxonomies](#input\_geo-taxonomies) | n/a | `map(string)` | n/a | yes |
| <a name="input_ingress_load_balancer_hostname"></a> [ingress\_load\_balancer\_hostname](#input\_ingress\_load\_balancer\_hostname) | n/a | `string` | n/a | yes |
| <a name="input_ingress_load_balancer_ip"></a> [ingress\_load\_balancer\_ip](#input\_ingress\_load\_balancer\_ip) | n/a | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input\_instance) | One of beta, prod01, prod02 | `string` | n/a | yes |
| <a name="input_jwt_audience"></a> [jwt\_audience](#input\_jwt\_audience) | configs/secrets | `string` | n/a | yes |
| <a name="input_jwt_issuer"></a> [jwt\_issuer](#input\_jwt\_issuer) | SPID | `string` | `"SPID"` | no |
| <a name="input_jwt_social_expire"></a> [jwt\_social\_expire](#input\_jwt\_social\_expire) | n/a | `string` | n/a | yes |
| <a name="input_jwt_token_exchange_duration"></a> [jwt\_token\_exchange\_duration](#input\_jwt\_token\_exchange\_duration) | n/a | `string` | `"PT15S"` | no |
| <a name="input_k8s_kube_config_path_prefix"></a> [k8s\_kube\_config\_path\_prefix](#input\_k8s\_kube\_config\_path\_prefix) | n/a | `string` | `"~/.kube"` | no |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_location_string"></a> [location\_string](#input\_location\_string) | One of West Europe, North Europe | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | Specifies the name of the Log Analytics Workspace. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_resource_group_name"></a> [log\_analytics\_workspace\_resource\_group\_name](#input\_log\_analytics\_workspace\_resource\_group\_name) | The name of the resource group in which the Log Analytics workspace is located in. | `string` | n/a | yes |
| <a name="input_monitor_resource_group_name"></a> [monitor\_resource\_group\_name](#input\_monitor\_resource\_group\_name) | Monitor resource group name | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_reloader_helm"></a> [reloader\_helm](#input\_reloader\_helm) | reloader helm chart configuration | <pre>object({<br>    chart_version = string,<br>    image_name    = string,<br>    image_tag     = string<br>  })</pre> | n/a | yes |
| <a name="input_reverse_proxy_ip"></a> [reverse\_proxy\_ip](#input\_reverse\_proxy\_ip) | AKS external ip. Also the ingress-nginx-controller external ip. Value known after installing the ingress controller. | `string` | `"127.0.0.1"` | no |
| <a name="input_reverse_proxy_rtd"></a> [reverse\_proxy\_rtd](#input\_reverse\_proxy\_rtd) | AKS external ip. Also the ingress-nginx-controller external ip. Value known after installing the ingress controller. | `string` | `"127.0.0.1"` | no |
| <a name="input_spid_testenv_url"></a> [spid\_testenv\_url](#input\_spid\_testenv\_url) | n/a | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "CreatedBy": "Terraform"<br>}</pre> | no |
| <a name="input_terraform_remote_state_core"></a> [terraform\_remote\_state\_core](#input\_terraform\_remote\_state\_core) | n/a | <pre>object({<br>    resource_group_name  = string,<br>    storage_account_name = string,<br>    container_name       = string,<br>    key                  = string<br>  })</pre> | n/a | yes |
| <a name="input_tls_cert_check_helm"></a> [tls\_cert\_check\_helm](#input\_tls\_cert\_check\_helm) | tls cert helm chart configuration | <pre>object({<br>    chart_version = string,<br>    image_name    = string,<br>    image_tag     = string<br>  })</pre> | n/a | yes |
| <a name="input_token_expiration_minutes"></a> [token\_expiration\_minutes](#input\_token\_expiration\_minutes) | n/a | `number` | `540` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azure_devops_sa_cacrt"></a> [azure\_devops\_sa\_cacrt](#output\_azure\_devops\_sa\_cacrt) | n/a |
| <a name="output_azure_devops_sa_token"></a> [azure\_devops\_sa\_token](#output\_azure\_devops\_sa\_token) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
