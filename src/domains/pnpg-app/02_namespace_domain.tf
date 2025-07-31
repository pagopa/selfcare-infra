resource "kubernetes_namespace" "domain_namespace" {
  metadata {
    name = var.domain
  }
}

# module "domain_pod_identity" {
#   source              = "github.com/pagopa/terraform-azurerm-v4.git//kubernetes_pod_identity?ref=v6.6.0"
#   resource_group_name = local.aks_resource_group_name
#   location            = var.location
#   tenant_id           = data.azurerm_subscription.current.tenant_id
#   cluster_name        = local.aks_name

#   identity_name = "${var.domain}-pod-identity"
#   namespace     = kubernetes_namespace.domain_namespace.metadata[0].name
#   key_vault_id  = data.azurerm_key_vault.kv_domain.id

#   secret_permissions = ["Get"]
# }

resource "helm_release" "reloader" {
  name       = "reloader"
  repository = "https://stakater.github.io/stakater-charts"
  chart      = "reloader"
  version    = var.reloader_helm.chart_version
  namespace  = kubernetes_namespace.domain_namespace.metadata[0].name

  set {
    name  = "reloader.watchGlobally"
    value = "false"
  }
  set {
    name  = "reloader.deployment.image.name"
    value = var.reloader_helm.image_name
  }
  set {
    name  = "reloader.deployment.image.tag"
    value = var.reloader_helm.image_tag
  }
}
