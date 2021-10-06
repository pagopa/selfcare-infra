resource "kubernetes_config_map" "hub-spid-login-ms" {
  metadata {
    name      = "hub-spid-login-ms"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = merge({
    JAVA_TOOL_OPTIONS                   = ""
    },
    var.configmaps_hub-spid-login-ms
  )
}