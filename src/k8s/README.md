<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=0.15.3 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | = 2.5.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | = 2.79.1 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.2.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.11.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_key_vault_secrets_query"></a> [key\_vault\_secrets\_query](#module\_key\_vault\_secrets\_query) | git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query | v1.0.58 |

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault_secret.apim_service_account_access_token](https://registry.terraform.io/providers/hashicorp/azurerm/2.79.1/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.azure_devops_sa_cacrt](https://registry.terraform.io/providers/hashicorp/azurerm/2.79.1/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.azure_devops_sa_token](https://registry.terraform.io/providers/hashicorp/azurerm/2.79.1/docs/resources/key_vault_secret) | resource |
| [helm_release.ingress](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_cluster_role.cluster_deployer](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role) | resource |
| [kubernetes_cluster_role.edit_extra](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role) | resource |
| [kubernetes_cluster_role.helm_system_deployer](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role) | resource |
| [kubernetes_cluster_role.view_extra](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role) | resource |
| [kubernetes_cluster_role_binding.edit_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding) | resource |
| [kubernetes_cluster_role_binding.edit_extra_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding) | resource |
| [kubernetes_cluster_role_binding.tokenreview_role_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding) | resource |
| [kubernetes_cluster_role_binding.view_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding) | resource |
| [kubernetes_cluster_role_binding.view_extra_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding) | resource |
| [kubernetes_config_map.common](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [kubernetes_config_map.hub-spid-login-ms](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [kubernetes_config_map.inner-service-url](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [kubernetes_config_map.jwt](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [kubernetes_config_map.jwt-exchange](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [kubernetes_deployment.health](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment) | resource |
| [kubernetes_ingress_v1.health_ingress](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/ingress_v1) | resource |
| [kubernetes_ingress_v1.selc_ingress](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/ingress_v1) | resource |
| [kubernetes_namespace.health](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.ingress](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.selc](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_role.pod_reader](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role) | resource |
| [kubernetes_role_binding.deployer_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding) | resource |
| [kubernetes_role_binding.helm_system_deployer_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding) | resource |
| [kubernetes_role_binding.pod_reader](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding) | resource |
| [kubernetes_secret.b4f-dashboard](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_secret.cdn-storage](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_secret.common-secrets](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_secret.contracts-storage](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_secret.event-secrets](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_secret.hub-spid-login-ms](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_secret.mail](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_secret.mail-not-pec](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_secret.mongo-credentials](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_secret.postgres](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_secret.product-external-api](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_secret.selc-application-insights](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_secret.selc-redis-credentials](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_secret.uservice-party-management](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_secret.uservice-party-process](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_service.health](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service) | resource |
| [kubernetes_service_account.apim_service_account](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account) | resource |
| [kubernetes_service_account.azure_devops](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account) | resource |
| [kubernetes_service_account.in_cluster_app_service_account](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account) | resource |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/2.5.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/2.5.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_operations](https://registry.terraform.io/providers/hashicorp/azuread/2.5.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_security](https://registry.terraform.io/providers/hashicorp/azuread/2.5.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_technical_project_managers](https://registry.terraform.io/providers/hashicorp/azuread/2.5.0/docs/data-sources/group) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.79.1/docs/data-sources/client_config) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.79.1/docs/data-sources/subscription) | data source |
| [kubernetes_secret.apim_service_account_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/secret) | data source |
| [kubernetes_secret.azure_devops_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/secret) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api-version_uservice-party-management"></a> [api-version\_uservice-party-management](#input\_api-version\_uservice-party-management) | uservice versions | `string` | n/a | yes |
| <a name="input_api-version_uservice-party-process"></a> [api-version\_uservice-party-process](#input\_api-version\_uservice-party-process) | n/a | `string` | n/a | yes |
| <a name="input_api-version_uservice-party-registry-proxy"></a> [api-version\_uservice-party-registry-proxy](#input\_api-version\_uservice-party-registry-proxy) | n/a | `string` | n/a | yes |
| <a name="input_api_gateway_url"></a> [api\_gateway\_url](#input\_api\_gateway\_url) | gateway | `string` | n/a | yes |
| <a name="input_cdn_frontend_url"></a> [cdn\_frontend\_url](#input\_cdn\_frontend\_url) | n/a | `string` | n/a | yes |
| <a name="input_cdn_storage_url"></a> [cdn\_storage\_url](#input\_cdn\_storage\_url) | n/a | `string` | n/a | yes |
| <a name="input_configmaps_common"></a> [configmaps\_common](#input\_configmaps\_common) | n/a | `map(string)` | n/a | yes |
| <a name="input_configmaps_hub-spid-login-ms"></a> [configmaps\_hub-spid-login-ms](#input\_configmaps\_hub-spid-login-ms) | n/a | `map(string)` | n/a | yes |
| <a name="input_default_service_port"></a> [default\_service\_port](#input\_default\_service\_port) | n/a | `number` | `8080` | no |
| <a name="input_enable_postgres_replica"></a> [enable\_postgres\_replica](#input\_enable\_postgres\_replica) | Enable connection to postgres replica | `bool` | `false` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_ingress_load_balancer_ip"></a> [ingress\_load\_balancer\_ip](#input\_ingress\_load\_balancer\_ip) | n/a | `string` | n/a | yes |
| <a name="input_ingress_replica_count"></a> [ingress\_replica\_count](#input\_ingress\_replica\_count) | n/a | `string` | n/a | yes |
| <a name="input_jwt_audience"></a> [jwt\_audience](#input\_jwt\_audience) | configs/secrets | `string` | n/a | yes |
| <a name="input_jwt_token_exchange_duration"></a> [jwt\_token\_exchange\_duration](#input\_jwt\_token\_exchange\_duration) | tfsec:ignore:general-secrets-no-plaintext-exposure | `string` | `"PT15S"` | no |
| <a name="input_k8s_apiserver_host"></a> [k8s\_apiserver\_host](#input\_k8s\_apiserver\_host) | n/a | `string` | n/a | yes |
| <a name="input_k8s_apiserver_insecure"></a> [k8s\_apiserver\_insecure](#input\_k8s\_apiserver\_insecure) | n/a | `bool` | `false` | no |
| <a name="input_k8s_apiserver_port"></a> [k8s\_apiserver\_port](#input\_k8s\_apiserver\_port) | n/a | `number` | `443` | no |
| <a name="input_k8s_kube_config_path"></a> [k8s\_kube\_config\_path](#input\_k8s\_kube\_config\_path) | n/a | `string` | `"~/.kube/config"` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | `"westeurope"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | `"selc"` | no |
| <a name="input_rbac_namespaces"></a> [rbac\_namespaces](#input\_rbac\_namespaces) | n/a | `list(string)` | <pre>[<br>  "selc"<br>]</pre> | no |
| <a name="input_spid_testenv_url"></a> [spid\_testenv\_url](#input\_spid\_testenv\_url) | n/a | `string` | `null` | no |
| <a name="input_token_expiration_minutes"></a> [token\_expiration\_minutes](#input\_token\_expiration\_minutes) | n/a | `number` | `540` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azure_devops_sa_cacrt"></a> [azure\_devops\_sa\_cacrt](#output\_azure\_devops\_sa\_cacrt) | n/a |
| <a name="output_azure_devops_sa_token"></a> [azure\_devops\_sa\_token](#output\_azure\_devops\_sa\_token) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

