resource "kubernetes_secret" "hub-spid-login-ms" {
  metadata {
    name      = "hub-spid-login-ms"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = {
    APPLICATIONINSIGHTS_CONNECTION_STRING = local.appinsights_instrumentation_key
  }

  type = "Opaque"
}

# not yet used by any deployment, but maybe useful for the future
resource "kubernetes_secret" "selc-application-insights" {
  metadata {
    name      = "application-insights"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = {
    APPLICATIONINSIGHTS_CONNECTION_STRING = local.appinsights_instrumentation_key
  }

  type = "Opaque"
}
