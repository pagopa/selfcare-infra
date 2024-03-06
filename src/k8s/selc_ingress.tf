locals {
  cors = {
    origins = join(",", concat(
      [
        format("https://%s", var.api_gateway_url),
        format("https://%s", var.cdn_frontend_url),
      ],
      var.env_short != "p"
      ? [
        "https://localhost:3000",
        "http://localhost:3000",
        "https://localhost:3001",
        "http://localhost:3001",
      format("https://%s", var.spid_testenv_url)]
      : []
    )),
    headers = join(",", [
      // default headers
      "DNT",
      "X-CustomHeader",
      "Keep-Alive",
      "User-Agent",
      "X-Requested-With",
      "If-Modified-Since",
      "Cache-Control",
      "Content-Type",
      "Authorization",
      // application headers
      "x-selc-institutionid"
    ])
  }
}

resource "kubernetes_ingress_v1" "selc_ingress" {
  depends_on = [helm_release.ingress]

  metadata {
    name      = "${kubernetes_namespace.selc.metadata[0].name}-ingress"
    namespace = kubernetes_namespace.selc.metadata[0].name
    annotations = {
      "kubernetes.io/ingress.class"                    = "nginx"
      "nginx.ingress.kubernetes.io/rewrite-target"     = "/$1"
      "nginx.ingress.kubernetes.io/ssl-redirect"       = "false"
      "nginx.ingress.kubernetes.io/use-regex"          = "true"
      "nginx.ingress.kubernetes.io/enable-cors"        = "true"
      "nginx.ingress.kubernetes.io/cors-allow-headers" = local.cors.headers
      "nginx.ingress.kubernetes.io/cors-allow-origin"  = local.cors.origins
    }
  }

  spec {
    rule {
      host = var.ingress_health.host
      http {

        path {
          backend {
            service {
              name = "hub-spid-login-ms"
              port {
                number = var.default_service_port
              }
            }
          }
          path = "/spid/v1/(.*)"
        }

        path {
          backend {
            service {
              name = "hub-spid-login-ms-agid"
              port {
                number = var.default_service_port
              }
            }
          }
          path = "/spid-login/v1/(.*)"
        }

      }
    }
    tls {
      hosts       = [var.ingress_health.host]
      secret_name = var.ingress_health.secret_name
    }
  }
}
