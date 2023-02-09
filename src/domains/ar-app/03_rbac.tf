resource "kubernetes_cluster_role" "view_extra" {
  metadata {
    name = "view-extra"
  }

  dynamic "rule" {
    for_each = var.env_short == "d" ? [""] : []

    content {
      api_groups = [""]
      resources  = ["pods/attach", "pods/exec", "pods/portforward", "pods/proxy", "secrets", "services/proxy"]
      verbs      = ["Get", "List", "Watch"]
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
    verbs      = ["Get", "List"]
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
    namespace = kubernetes_namespace.domain_namespace.metadata[0].name
  }

  rule {
    api_groups = [""]
    resources  = ["pods"]
    verbs      = ["Get", "Watch", "List"]
  }
}

resource "kubernetes_role_binding" "pod_reader" {
  metadata {
    name      = "pod-reader"
    namespace = kubernetes_namespace.domain_namespace.metadata[0].name
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "pod-reader"
  }
  subject {
    kind = "User"
    name = format("system:serviceaccount:%s:default", kubernetes_namespace.domain_namespace.metadata[0].name)
  }
}