#tfsec:ignore:azure-keyvault-ensure-secret-expiry
resource "azurerm_key_vault_secret" "appinsights-instrumentation-key" {
  key_vault_id = data.azurerm_key_vault.kv_domain.id
  name         = "appinsights-instrumentation-key"
  value        = data.azurerm_application_insights.application_insights.connection_string
  content_type = "text/plain"
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "azure_devops_aks_apiserver_url" {
  depends_on   = [kubernetes_service_account.azure_devops]
  name         = "${var.aks_name}-apiserver-url"
  value        = "https://${data.azurerm_kubernetes_cluster.aks.private_fqdn}:443"
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv_domain.id
}
