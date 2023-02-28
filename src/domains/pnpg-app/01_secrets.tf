data "azurerm_kubernetes_cluster" "aks" {
  name                = local.aks_name
  resource_group_name = local.aks_resource_group_name
}

############################################################

locals {
  aks_api_url = var.env_short == "d" ? data.azurerm_kubernetes_cluster.aks.fqdn : data.azurerm_kubernetes_cluster.aks.private_fqdn
}

resource "azurerm_key_vault_secret" "appinsights-instrumentation-key" {
  key_vault_id = data.azurerm_key_vault.kv_domain.id
  name         = "appinsights-instrumentation-key"
  value        = data.azurerm_application_insights.application_insights.connection_string
  content_type = "text/plain"
}
