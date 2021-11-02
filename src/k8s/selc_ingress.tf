resource "kubernetes_ingress" "selc_ingress" {
  depends_on = [helm_release.ingress]

  metadata {
    name      = "${kubernetes_namespace.selc.metadata[0].name}-ingress"
    namespace = kubernetes_namespace.selc.metadata[0].name
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
            service_name = "hub-spid-login-ms"
            service_port = var.default_service_port
          }
          path = "/hub-spid-login-ms/(.*)"
        }

        path {
          backend {
            service_name = "b4f-dashboard"
            service_port = var.default_service_port
          }
          path = "/b4f-dashboard/(.*)"
        }

        path {
          backend {
            service_name = "uservice-party-process"
            service_port = 8088
          }
          path = "/uservice-party-process/(.*)"
        }

        path {
          backend {
            service_name = "uservice-party-management"
            service_port = 8088
          }
          path = "/uservice-party-management/(.*)"
        }

        path {
          backend {
            service_name = "uservice-party-registry-proxy"
            service_port = 8088
          }
          path = "/uservice-party-registry-proxy/(.*)"
        }

      }
    }
  }
}
