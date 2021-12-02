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
    MONGODB_CONNECTION_URI    = module.key_vault_secrets_query.values["mongodb-connection-string"].value
    MONGODB_NAME_SELC_PRODUCT = local.mongodb_name_selc_product
  }

  type = "Opaque"
}

resource "kubernetes_secret" "postgres" {
  metadata {
    name      = "postgres"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = {
    #principal database name
    POSTGRES_DB = "selc"
    #principal database hostname or ip
    POSTGRES_HOST = local.postgres_hostname
    #principal database hostname or ip
    POSTGRES_PORT = "5432"
    #replica database name
    POSTGRES_REPLICA_DB = "selc"
    #replica database hostname or ip
    POSTGRES_REPLICA_HOST = local.postgres_replica_hostname
    #replica database hostname or ip
    POSTGRES_REPLICA_PORT = "5432"
  }

  type = "Opaque"
}

resource "kubernetes_secret" "mail" {
  metadata {
    name      = "mail"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = {
    SMTP_SERVER = "smtps.pec.aruba.it"
    SMTP_PORT   = 465
    SMTP_USR    = module.key_vault_secrets_query.values["smtp-usr"].value
    SMTP_PSW    = module.key_vault_secrets_query.values["smtp-psw"].value
    DESTINATION_MAILS = module.key_vault_secrets_query.values["smtp-usr"].value
  }

  type = "Opaque"
}

resource "kubernetes_secret" "contracts-storage" {
  metadata {
    name      = "contracts-storage"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = {
    STORAGE_TYPE               = "BlobStorage"
    STORAGE_CONTAINER          = local.contracts_storage_container
    STORAGE_ENDPOINT           = "core.windows.net"
    STORAGE_APPLICATION_ID     = local.contracts_storage_account_name
    STORAGE_APPLICATION_SECRET = module.key_vault_secrets_query.values["contracts-storage-access-key"].value
  }

  type = "Opaque"
}

resource "kubernetes_secret" "b4f-dashboard" {
  metadata {
    name      = "b4f-dashboard"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = {
    BLOB_STORAGE_CONN_STRING = module.key_vault_secrets_query.values["web-storage-connection-string"].value
  }

  type = "Opaque"
}

resource "kubernetes_secret" "uservice-attribute-registry-management" {
  metadata {
    name      = "uservice-attribute-registry-management"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = {
    POSTGRES_USR = format("%s@%s", "ATTRIBUTE_REGISTRY_USER", local.postgres_hostname)
    POSTGRES_PSW = module.key_vault_secrets_query.values["postgres-attribute-registry-user-password"].value
  }

  type = "Opaque"
}

resource "kubernetes_secret" "uservice-party-management" {
  metadata {
    name      = "uservice-party-management"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = {
    POSTGRES_USR = format("%s@%s", "PARTY_USER", local.postgres_hostname)
    POSTGRES_PSW = module.key_vault_secrets_query.values["postgres-party-user-password"].value
  }

  type = "Opaque"
}