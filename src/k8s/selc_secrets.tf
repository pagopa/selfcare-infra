resource "kubernetes_secret" "hub-spid-login-ms" {
  metadata {
    name      = "hub-spid-login-ms"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = {
    APPINSIGHTS_INSTRUMENTATIONKEY = local.appinsights_instrumentation_key
    JWT_TOKEN_PRIVATE_KEY          = module.key_vault_secrets_query.values["jwt-private-key"].value
    JWT_TOKEN_KID                  = module.key_vault_secrets_query.values["jwt-kid"].value

    METADATA_PUBLIC_CERT  = module.key_vault_secrets_query.values["agid-spid-cert"].value
    METADATA_PRIVATE_CERT = module.key_vault_secrets_query.values["agid-spid-private-key"].value

    USER_REGISTRY_API_KEY = module.key_vault_secrets_query.values["user-registry-api-key"].value

    SPID_LOGS_STORAGE_CONNECTION_STRING = module.key_vault_secrets_query.values["logs-storage-connection-string"].value
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
    MONGODB_CONNECTION_URI       = module.key_vault_secrets_query.values["mongodb-connection-string"].value
    MONGODB_NAME_SELC_PRODUCT    = local.mongodb_name_selc_product
    MONGODB_NAME_SELC_USER_GROUP = local.mongodb_name_selc_user_group
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

  data = merge({
    SMTP_HOST           = "smtps.pec.aruba.it"
    SMTP_PORT           = 465
    SMTP_SSL            = true
    SMTP_USR            = module.key_vault_secrets_query.values["smtp-usr"].value
    SMTP_PSW            = module.key_vault_secrets_query.values["smtp-psw"].value
    MAIL_SENDER_ADDRESS = module.key_vault_secrets_query.values["smtp-usr"].value
    },
    var.env_short != "p"
    ? {
      DESTINATION_MAILS = "pectest@pec.pagopa.it"
    }
    : {}
  )

  type = "Opaque"
}

resource "kubernetes_secret" "mail-not-pec" {
  metadata {
    name      = "mail-not-pec"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = {
    MAIL_SERVER_HOST     = "smtp.gmail.com"
    MAIL_SERVER_PORT     = 587
    MAIL_SERVER_USERNAME = module.key_vault_secrets_query.values["smtp-not-pec-usr"].value
    MAIL_SERVER_PASSWORD = module.key_vault_secrets_query.values["smtp-not-pec-psw"].value
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
    STORAGE_CREDENTIAL_ID      = local.contracts_storage_account_name
    STORAGE_CREDENTIAL_SECRET  = module.key_vault_secrets_query.values["contracts-storage-access-key"].value
  }

  type = "Opaque"
}

resource "kubernetes_secret" "cdn-storage" {
  metadata {
    name      = "cdn-storage"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = {
    BLOB_STORAGE_CONN_STRING = module.key_vault_secrets_query.values["web-storage-connection-string"].value
    BLOB_CONTAINER_REF       = "$web"
    BLOBSTORAGE_PUBLIC_HOST  = replace(var.cdn_storage_url, "/https?:\\/\\//", "")
    BLOBSTORAGE_PUBLIC_URL   = var.cdn_storage_url
    CDN_PUBLIC_URL           = var.cdn_frontend_url
  }

  type = "Opaque"
}

resource "kubernetes_secret" "b4f-dashboard" {
  metadata {
    name      = "b4f-dashboard"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = {
    BLOB_STORAGE_CONN_STRING       = module.key_vault_secrets_query.values["web-storage-connection-string"].value
    JWT_TOKEN_EXCHANGE_PRIVATE_KEY = module.key_vault_secrets_query.values["jwt-exchange-private-key"].value
  }

  type = "Opaque"
}

resource "kubernetes_secret" "product-external-api" {
  metadata {
    name      = "product-external-api"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = {
    EXTERNAL_API_KEY  = module.key_vault_secrets_query.values["external-api-key"].value
    EXTERNAL_API_USER = module.key_vault_secrets_query.values["external-user-api"].value
  }

  type = "Opaque"
}

resource "kubernetes_secret" "uservice-party-process" {
  metadata {
    name      = "uservice-party-process"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = {
    USER_REGISTRY_API_KEY = module.key_vault_secrets_query.values["user-registry-api-key"].value
    ONBOARDING_INSTITUTION_ALTERNATIVE_EMAIL = module.key_vault_secrets_query.values["party-test-institution-email"].value
    #"  pectest@pec.pagopa.it  text/plain
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

resource "kubernetes_secret" "common-secrets" {
  metadata {
    name      = "common-secrets"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = {
    USERVICE_USER_REGISTRY_API_KEY = module.key_vault_secrets_query.values["user-registry-api-key"].value
  }

  type = "Opaque"
}

resource "kubernetes_secret" "event-secrets" {
  metadata {
    name      = "event-secrets"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = {
    KAFKA_BROKER            = "${local.project}-eventhub-ns.servicebus.windows.net:9093"
    KAFKA_SECURITY_PROTOCOL = "SASL_SSL"
    KAFKA_SASL_MECHANISM    = "PLAIN"

    KAFKA_CONTRACTS_TOPIC                        = "SC-Contracts"
    KAFKA_CONTRACTS_SELFCARE_WO_SASL_JAAS_CONFIG = "org.apache.kafka.common.security.plain.PlainLoginModule required username=\"$ConnectionString\" password=\"${module.key_vault_secrets_query.values["eventhub-SC-Contracts-selfcare-wo-connection-string"].value}\";"
  }

  type = "Opaque"
}
