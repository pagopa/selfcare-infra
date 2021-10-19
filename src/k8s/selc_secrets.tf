resource "kubernetes_secret" "hub-spid-login-ms" {
  metadata {
    name      = "hub-spid-login-ms"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = {
    APPINSIGHTS_INSTRUMENTATIONKEY = local.appinsights_instrumentation_key
    JWT_TOKEN_PRIVATE_KEY = module.key_vault_secrets_query.values["jwt-private-key"].value

    METADATA_PUBLIC_CERT  = var.agid_spid_public_cert != null ? data.azurerm_key_vault_secret.agid_spid_cert[0].value : tls_self_signed_cert.spid_self.cert_pem
    METADATA_PRIVATE_CERT = var.agid_spid_private_key != null ? data.azurerm_key_vault_secret.agid_spid_private_key[0].value : tls_private_key.spid.private_key_pem

  }

  type = "Opaque"
}

resource "kubernetes_secret" "selc-redis-credentials" {
  metadata {
    name      = "redis-credentials"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = {
    REDIS_URL      = local.redis_url
    REDIS_PASSWORD = module.key_vault_secrets_query.values["redis-primary-access-key"].value
    REDIS_PORT     = "6379"
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
