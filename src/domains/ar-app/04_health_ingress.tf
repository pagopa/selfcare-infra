resource "kubernetes_ingress_v1" "health_ingress" {

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
            service {
              name = "health"
              port {
                number = var.default_service_port
              }
            }
          }
          path = "/health(.*)"
        }
      }
    }
  }
}