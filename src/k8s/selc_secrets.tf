resource "kubernetes_secret" "hub-spid-login-ms" {
  metadata {
    name      = "hub-spid-login-ms"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = {
    APPINSIGHTS_INSTRUMENTATIONKEY = local.appinsights_instrumentation_key
    JWT_TOKEN_PRIVATE_KEY          = module.key_vault_secrets_query.values["jwt-private-key"].value

    METADATA_PUBLIC_CERT  = module.key_vault_secrets_query.values["agid-spid-cert"].value        # TODO actually manually populated, but to try to automate in gitops
    METADATA_PRIVATE_CERT = module.key_vault_secrets_query.values["agid-spid-private-key"].value # TODO actually manually populated, but to try to automate in gitops

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
    REDIS_PORT     = "6380"
  }

  type = "Opaque"
}

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

resource "kubernetes_secret" "mongo-credentials" {
  metadata {
    name      = "mongo-credentials"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = {
    DB_CONNECTION_URI = module.key_vault_secrets_query.values["mongodb-connection-string"].value
  }

  type = "Opaque"
}

resource "kubernetes_secret" "postgres-credentials" {
  metadata {
    name      = "postgres-credentials"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = {
    #principal database name
    POSTGRES_DB_NAME = "selc"
    #principal database hostname or ip
    POSTGRES_HOST = local.postgres_hostname
    #principal database username
    POSTGRES_USERNAME = format("%s@%s", module.key_vault_secrets_query.values["db-selc-login"].value, local.postgres_hostname)
    #principal database password
    POSTGRES_PASSWORD = module.key_vault_secrets_query.values["db-selc-user-password"].value
    #replica database name
    POSTGRES_REPLICA_DB_NAME = "selc"
    #replica database hostname or ip
    POSTGRES_REPLICA_HOST = local.postgres_replica_hostname
    #replica database username
    POSTGRES_REPLICA_USERNAME = format("%s@%s", module.key_vault_secrets_query.values["db-selc-login"].value, var.enable_postgres_replica ? local.postgres_replica_hostname : local.postgres_hostname)
    #replica database password
    POSTGRES_REPLICA_PASSWORD = module.key_vault_secrets_query.values["db-selc-user-password"].value
  }

  type = "Opaque"
}