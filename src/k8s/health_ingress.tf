resource "kubernetes_ingress" "health_ingress" {
  metadata {
    name      = "${kubernetes_namespace.health.metadata[0].name}-ingress"
    namespace = kubernetes_namespace.health.metadata[0].name
    annotations = {
      "kubernetes.io/ingress.class"                = "nginx"
      "nginx.ingress.kubernetes.io/rewrite-target" = "/$1"
      "nginx.ingress.kubernetes.io/ssl-redirect"   = "false"
      "nginx.ingress.kubernetes.io/use-regex"      = "true"
    }
  }

  spec {
    rule {
      http {
        path {
          backend {
            service_name = "health"
            service_port = var.default_service_port
          }
          path = "/health(.*)"
        }
      }
    }
  }
}
