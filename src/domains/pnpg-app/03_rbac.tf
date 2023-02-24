# service account required by apim in order to authenticate with microservices
resource "kubernetes_service_account" "apim_service_account" {
  metadata {
    name      = local.apim_service_account_name
    namespace = var.domain
  }
}

resource "kubernetes_secret_v1" "apim_service_account_default_secret" {
  metadata {
    name      = local.apim_service_account_secret_name
    namespace = var.domain
    annotations = {
      "kubernetes.io/service-account.name" = local.apim_service_account_name
    }
  }

  type = "kubernetes.io/service-account-token"

  depends_on = [
    kubernetes_service_account.apim_service_account
  ]
}

data "kubernetes_secret" "apim_service_account_secret" {
  metadata {
    name      = local.apim_service_account_secret_name
    namespace = var.domain
  }
  binary_data = {
    "ca.crt" = ""
    "token"  = ""
  }

  depends_on = [
    kubernetes_secret_v1.apim_service_account_default_secret
  ]
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "apim_service_account_access_token" {
  name         = "apim-backend-access-token"
  value        = base64decode(data.kubernetes_secret.apim_service_account_secret.binary_data.token)
  content_type = "JWT"

  key_vault_id = data.azurerm_key_vault.kv_domain.id

  depends_on = [
    data.kubernetes_secret.apim_service_account_secret
  ]
}

# service_account required by internal microservices authentication
resource "kubernetes_service_account" "in_cluster_app_service_account" {
  metadata {
    name      = "in-cluster-app"
    namespace = var.domain
  }
}

# role binding required by internal microservices in order to call k8s tokenreview API
resource "kubernetes_cluster_role_binding" "tokenreview_role_binding" {
  metadata {
    name = "role-tokenreview-binding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "system:auth-delegator"
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.in_cluster_app_service_account.metadata[0].name
    namespace = kubernetes_service_account.in_cluster_app_service_account.metadata[0].namespace
  }
}
