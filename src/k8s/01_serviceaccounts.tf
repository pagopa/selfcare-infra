resource "kubernetes_service_account" "azure_devops" {
  metadata {
    name      = "azure-devops"
    namespace = "kube-system"
  }
  automount_service_account_token = false
}

resource "kubernetes_cluster_role" "cluster_deployer" {
  metadata {
    name = "cluster-deployer"
  }

  # required to run helm
  rule {
    api_groups = ["", "extensions", "apps", "policy"]
    resources  = ["deployments", "replicasets", "horizontalpodautoscalers", "services", "pods", "jobs", "scheduledjobs", "crontabs", "configmaps", "secrets", "poddisruptionbudgets"]
    verbs      = ["get", "list", "watch", "create", "update", "patch", "delete"]
  }

  # required to run helm
  rule {
    api_groups = ["networking.k8s.io"]
    resources  = ["ingresses"]
    verbs      = ["get", "list", "watch", "create", "update", "patch", "delete"]
  }
}

resource "kubernetes_role_binding" "deployer_binding" {
  depends_on = [
    kubernetes_namespace.selc
  ]

  for_each = toset(var.rbac_namespaces)

  metadata {
    name      = "deployer-binding"
    namespace = each.key
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-deployer"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "azure-devops"
    namespace = "kube-system"
  }
}

resource "kubernetes_cluster_role" "helm_system_deployer" {
  metadata {
    name = "helm-system-deployer"
  }

  # required to run helm
  rule {
    api_groups = [""]
    resources  = ["services"]
    verbs      = ["get", "list"]
  }
}

resource "kubernetes_role_binding" "helm_system_deployer_binding" {
  depends_on = [
    kubernetes_namespace.selc
  ]

  for_each = toset(["kube-system"])

  metadata {
    name      = "helm-system-deployer-binding"
    namespace = each.key
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "helm-system-deployer"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "azure-devops"
    namespace = "kube-system"
  }
}

data "kubernetes_secret" "azure_devops_secret" {
  metadata {
    name      = kubernetes_service_account.azure_devops.default_secret_name
    namespace = "kube-system"
  }
  binary_data = {
    "ca.crt" = ""
    "token"  = ""
  }
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "azure_devops_sa_token" {
  depends_on   = [kubernetes_service_account.azure_devops]
  name         = "${var.env}-selfcare-aks-azure-devops-sa-token"
  value        = data.kubernetes_secret.azure_devops_secret.binary_data["token"] # base64 value
  content_type = "text/plain"

  key_vault_id = local.key_vault_id
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "azure_devops_sa_cacrt" {
  depends_on   = [kubernetes_service_account.azure_devops]
  name         = "${var.env}-selfcare-aks-azure-devops-sa-cacrt"
  value        = data.kubernetes_secret.azure_devops_secret.binary_data["ca.crt"] # base64 value
  content_type = "text/plain"

  key_vault_id = local.key_vault_id
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "aks_apiserver_url" {
  name         = "${var.env}-selfcare-aks-apiserver-url"
  value        = "https://${data.azurerm_kubernetes_cluster.aks.private_fqdn}:443"
  content_type = "text/plain"

  key_vault_id = local.key_vault_id
}
