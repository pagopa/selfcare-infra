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
