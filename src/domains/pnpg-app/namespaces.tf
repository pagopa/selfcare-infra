resource "kubernetes_namespace" "ingress" {
  metadata {
    name = "ingress"
  }
}

resource "kubernetes_namespace" "selc" {
  metadata {
    name = "selc"
  }
}

resource "kubernetes_namespace" "health" {
  metadata {
    name = "health"
  }
}
