data "azuread_group" "adgroup_externals" {
  display_name = format("%s-adgroup-externals", local.project)
}

data "azuread_group" "adgroup_developers" {
  display_name = format("%s-adgroup-developers", local.project)
}

data "azuread_group" "adgroup_security" {
  display_name = format("%s-adgroup-security", local.project)
}

data "azuread_group" "adgroup_operations" {
  display_name = format("%s-adgroup-operations", local.project)
}

data "azuread_group" "adgroup_technical_project_managers" {
  display_name = format("%s-adgroup-technical-project-managers", local.project)
}

resource "kubernetes_cluster_role" "view_extra" {
  metadata {
    name = "view-extra"
  }

  dynamic "rule" {
    for_each = var.env_short == "d" ? [""] : []

    content {
      api_groups = [""]
      resources  = ["pods/attach", "pods/exec", "pods/portforward", "pods/proxy", "secrets", "services/proxy"]
      verbs      = ["get", "list", "watch"]
    }
  }

  dynamic "rule" {
    for_each = var.env_short == "d" ? [""] : []
    content {
      api_groups = [""]
      resources  = ["pods/attach", "pods/exec", "pods/portforward", "pods/proxy"]
      verbs      = ["create", "delete", "deletecollection", "patch", "update"]
    }
  }
}

resource "kubernetes_cluster_role_binding" "view_extra_binding" {
  metadata {
    name = "view-extra-binding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.view_extra.metadata[0].name
  }

  subject {
    kind      = "Group"
    name      = data.azuread_group.adgroup_security.object_id
    namespace = "kube-system"
  }

  subject {
    kind      = "Group"
    name      = data.azuread_group.adgroup_developers.object_id
    namespace = "kube-system"
  }

  subject {
    kind      = "Group"
    name      = data.azuread_group.adgroup_externals.object_id
    namespace = "kube-system"
  }

  subject {
    kind      = "Group"
    name      = data.azuread_group.adgroup_operations.object_id
    namespace = "kube-system"
  }

  subject {
    kind      = "Group"
    name      = data.azuread_group.adgroup_technical_project_managers.object_id
    namespace = "kube-system"
  }
}

resource "kubernetes_cluster_role" "edit_extra" {
  metadata {
    name = "edit-extra"
  }

  rule {
    api_groups = ["rbac.authorization.k8s.io"]
    resources  = ["*"]
    verbs      = ["get", "list"]
  }
}

resource "kubernetes_cluster_role_binding" "edit_extra_binding" {
  metadata {
    name = "edit-extra-binding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.edit_extra.metadata[0].name
  }

  subject {
    kind      = "Group"
    name      = data.azuread_group.adgroup_developers.object_id
    namespace = "kube-system"
  }
}

resource "kubernetes_cluster_role_binding" "edit_binding" {
  metadata {
    name = "edit-binding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "edit"
  }

  subject {
    kind      = "Group"
    name      = data.azuread_group.adgroup_developers.object_id
    namespace = "kube-system"
  }
}

resource "kubernetes_cluster_role_binding" "view_binding" {
  metadata {
    name = "view-binding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "view"
  }

  subject {
    kind      = "Group"
    name      = data.azuread_group.adgroup_developers.object_id
    namespace = "kube-system"
  }

  subject {
    kind      = "Group"
    name      = data.azuread_group.adgroup_security.object_id
    namespace = "kube-system"
  }

  subject {
    kind      = "Group"
    name      = data.azuread_group.adgroup_externals.object_id
    namespace = "kube-system"
  }

  subject {
    kind      = "Group"
    name      = data.azuread_group.adgroup_operations.object_id
    namespace = "kube-system"
  }

  subject {
    kind      = "Group"
    name      = data.azuread_group.adgroup_technical_project_managers.object_id
    namespace = "kube-system"
  }
}

# role required by interop services

resource "kubernetes_role" "pod_reader" {
  metadata {
    name      = "pod-reader"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  rule {
    api_groups = [""]
    resources  = ["pods"]
    verbs      = ["get", "watch", "list"]
  }
}

resource "kubernetes_role_binding" "pod_reader" {
  metadata {
    name      = "pod-reader"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "pod-reader"
  }
  subject {
    kind = "User"
    name = format("system:serviceaccount:%s:default", kubernetes_namespace.selc.metadata[0].name)
  }
}


# service account required by apim in order to authenticate with microservices
resource "kubernetes_service_account" "apim_service_account" {
  metadata {
    name      = "apim"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }
}

data "kubernetes_secret" "apim_service_account_secret" {
  metadata {
    name      = kubernetes_service_account.apim_service_account.default_secret_name
    namespace = kubernetes_service_account.apim_service_account.metadata.namespace
  }
  binary_data = {
    "ca.crt" = ""
    "token"  = ""
  }
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "apim_service_account_access_token" {
  name         = "apim-backend-access-token"
  value        = data.kubernetes_secret.apim_service_account_secret.binary_data.token
  content_type = "text/plain"

  key_vault_id = local.key_vault_id
}

# service_account required by internal microservices authentication
resource "kubernetes_service_account" "in_cluster_app_service_account" {
  metadata {
    name      = "in-cluster-app"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }
}

# role binding required by internal microservices in order to call k8s tokenreview API
resource "kubernetes_role_binding" "tokenreview_role_binding" {
  metadata {
    name      = "role-tokenreview-binding"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "system:auth-delegator"
  }
  subject {
    kind = "ServiceAccount"
    name = kubernetes_service_account.in_cluster_app_service_account.metadata[0].name
    namespace = kubernetes_service_account.in_cluster_app_service_account.metadata[0].namespace
  }
}
