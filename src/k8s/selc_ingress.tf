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
    :[]
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

resource "kubernetes_ingress" "selc_ingress" {
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
      http {

        path {
          backend {
            service_name = "hub-spid-login-ms"
            service_port = var.default_service_port
          }
          path = "/spid/v1/(.*)"
        }

        path {
          backend {
            service_name = "b4f-dashboard"
            service_port = var.default_service_port
          }
          path = "/dashboard/v1/(.*)"
        }

        path {
          backend {
            service_name = "ms-product"
            service_port = var.default_service_port
          }
          path = "/ms-product/(.*)"
        }

      }
    }
  }
}

resource "kubernetes_ingress" "selc_pdnd_ingress" {
  depends_on = [helm_release.ingress]

  metadata {
    name      = "${kubernetes_namespace.selc.metadata[0].name}-pdnd-ingress"
    namespace = kubernetes_namespace.selc.metadata[0].name
    annotations = {
      "kubernetes.io/ingress.class"                    = "nginx"
      "nginx.ingress.kubernetes.io/rewrite-target"     = "/pdnd-interop-uservice-$1/0.1/$2"
      "nginx.ingress.kubernetes.io/ssl-redirect"       = "false"
      "nginx.ingress.kubernetes.io/use-regex"          = "true"
      "nginx.ingress.kubernetes.io/enable-cors"        = "true"
      "nginx.ingress.kubernetes.io/cors-allow-headers" = "*"
      "nginx.ingress.kubernetes.io/cors-allow-headers" = local.cors.headers
      "nginx.ingress.kubernetes.io/cors-allow-origin"  = local.cors.origins
    }
  }

  spec {
    rule {
      http {
        path {
          backend {
            service_name = "pdnd-interop-uservice-party-process"
            service_port = 8088
          }
          path = "/(party-process)/v1/(.*)"
        }

        path {
          backend {
            service_name = "pdnd-interop-uservice-party-management"
            service_port = 8088
          }
          path = "/(party-management)/v1/(.*)"
        }

        path {
          backend {
            service_name = "pdnd-interop-uservice-party-registry-proxy"
            service_port = 8088
          }
          path = "/(party-registry-proxy)/v1/(.*)"
        }
      }
    }
  }
}

