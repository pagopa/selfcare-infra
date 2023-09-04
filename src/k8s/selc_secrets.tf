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
    SMTP_HOST                 = "smtps.pec.aruba.it"
    SMTP_PORT                 = 465
    SMTP_SSL                  = true
    SMTP_USR                  = module.key_vault_secrets_query.values["smtp-usr"].value
    SMTP_PSW                  = module.key_vault_secrets_query.values["smtp-psw"].value
    MAIL_SENDER_ADDRESS       = module.key_vault_secrets_query.values["smtp-usr"].value
    AWS_SES_ACCESS_KEY_ID     = module.key_vault_secrets_query.values["aws-ses-access-key-id"].value
    AWS_SES_SECRET_ACCESS_KEY = module.key_vault_secrets_query.values["aws-ses-secret-access-key"].value
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
    STORAGE_TEMPLATE_URL       = format("https://selc%scheckoutsa.z6.web.core.windows.net", var.env_short)
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
    STORAGE_CONTAINER        = local.contracts_storage_container
    BLOB_STORAGE_CONN_STRING = module.key_vault_secrets_query.values["contracts-storage-connection-string"].value
    EXTERNAL_API_KEY         = module.key_vault_secrets_query.values["external-api-key"].value
    EXTERNAL_API_USER        = module.key_vault_secrets_query.values["external-user-api"].value
  }

  type = "Opaque"
}

resource "kubernetes_secret" "uservice-party-process" {
  metadata {
    name      = "uservice-party-process"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = {
    USER_REGISTRY_API_KEY                    = module.key_vault_secrets_query.values["user-registry-api-key"].value
    ONBOARDING_INSTITUTION_ALTERNATIVE_EMAIL = module.key_vault_secrets_query.values["party-test-institution-email"].value
    ADDRESS_EMAIL_NOTIFICATION_ADMIN         = module.key_vault_secrets_query.values["portal-admin-operator-email"].value
    #"  pectest@pec.pagopa.it  text/plain
  }

  type = "Opaque"
}

resource "kubernetes_secret" "social-login" {
  metadata {
    name      = "social-login"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = {
    GOOGLE_CLIENT_SECRET = module.key_vault_secrets_query.values["google-client-secret"].value
    GOOGLE_CLIENT_ID     = module.key_vault_secrets_query.values["google-client-id"].value
    JWT_SECRET           = module.key_vault_secrets_query.values["jwt-secret"].value
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
    KAFKA_USER_TOPIC                             = "SC-Users"
    KAFKA_USERS_SELFCARE_WO_SASL_JAAS_CONFIG     = "org.apache.kafka.common.security.plain.PlainLoginModule required username=\"$ConnectionString\" password=\"${module.key_vault_secrets_query.values["eventhub-SC-Users-selfcare-wo-connection-string"].value}\";"
  }

  type = "Opaque"
}

resource "kubernetes_secret" "onboarding-interceptor-event-secrets" {
  metadata {
    name      = "onboarding-interceptor-event-secrets"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = {
    KAFKA_BROKER            = "${local.project}-eventhub-ns.servicebus.windows.net:9093"
    KAFKA_SECURITY_PROTOCOL = "SASL_SSL"
    KAFKA_SASL_MECHANISM    = "PLAIN"

    KAFKA_CONTRACTS_TOPIC                        = "SC-Contracts"
    KAFKA_CONTRACTS_SELFCARE_RO_SASL_JAAS_CONFIG = "org.apache.kafka.common.security.plain.PlainLoginModule required username=\"$ConnectionString\" password=\"${module.key_vault_secrets_query.values["eventhub-SC-Contracts-interceptor-connection-string"].value}\";"
  }

  type = "Opaque"
}

resource "kubernetes_secret" "external-interceptor-event-secrets" {
  metadata {
    name      = "external-interceptor-event-secrets"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = {
    KAFKA_BROKER            = "${local.project}-eventhub-ns.servicebus.windows.net:9093"
    KAFKA_SECURITY_PROTOCOL = "SASL_SSL"
    KAFKA_SASL_MECHANISM    = "PLAIN"

    KAFKA_CONTRACTS_TOPIC                        = "SC-Contracts"
    KAFKA_FD_TOPIC                               = "Selfcare-FD"
    KAFKA_USERS_TOPIC                            = "SC-Users"
    KAFKA_CONTRACTS_SELFCARE_RO_SASL_JAAS_CONFIG = "org.apache.kafka.common.security.plain.PlainLoginModule required username=\"$ConnectionString\" password=\"${module.key_vault_secrets_query.values["eventhub-SC-Contracts-interceptor-connection-string"].value}\";"
    KAFKA_USERS_SELFCARE_RO_SASL_JAAS_CONFIG     = "org.apache.kafka.common.security.plain.PlainLoginModule required username=\"$ConnectionString\" password=\"${module.key_vault_secrets_query.values["eventhub-SC-Users-external-interceptor-connection-string"].value}\";"
    KAFKA_SELFCARE_FD_WO_SASL_JAAS_CONFIG        = "org.apache.kafka.common.security.plain.PlainLoginModule required username=\"$ConnectionString\" password=\"${module.key_vault_secrets_query.values["eventhub-Selfcare-FD-external-interceptor-wo-connection-string"].value}\";"
    KAFKA_SC_CONTRACTS_SAP_WO_SASL_JAAS_CONFIG   = "org.apache.kafka.common.security.plain.PlainLoginModule required username=\"$ConnectionString\" password=\"${module.key_vault_secrets_query.values["eventhub-SC-Contracts-sap-external-interceptor-wo-connection-string"].value}\";"
  }

}

resource "kubernetes_secret" "external-interceptor" {
  metadata {
    name      = "external-interceptor"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = {
    FD_TOKEN_GRANT_TYPE    = module.key_vault_secrets_query.values["prod-fd-grant-type"].value
    FD_TOKEN_CLIENT_ID     = module.key_vault_secrets_query.values["prod-fd-client-id"].value
    FD_TOKEN_CLIENT_SECRET = module.key_vault_secrets_query.values["prod-fd-client-secret"].value
  }
}

resource "kubernetes_secret" "onboarding-interceptor-apim-internal" {
  metadata {
    name      = "onboarding-interceptor-apim-internal"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = {
    SELFCARE_APIM_INTERNAL_API_KEY = module.key_vault_secrets_query.values["onboarding-interceptor-apim-internal"].value
  }

  type = "Opaque"
}

resource "kubernetes_secret" "external-interceptor-apim-internal" {
  metadata {
    name      = "external-interceptor-apim-internal"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = {
    SELFCARE_APIM_INTERNAL_API_KEY = module.key_vault_secrets_query.values["external-interceptor-apim-internal"].value
    K8S_AUTHORIZATION_TOKEN        = module.key_vault_secrets_query.values["apim-backend-access-token"].value
  }

  type = "Opaque"
}


resource "kubernetes_secret" "aruba-sign-service-secrets" {
  metadata {
    name      = "aruba-sign-service-secrets"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = {
    ARUBA_SIGN_SERVICE_IDENTITY_USER               = module.key_vault_secrets_query.values["aruba-sign-service-user"].value
    ARUBA_SIGN_SERVICE_IDENTITY_DELEGATED_USER     = module.key_vault_secrets_query.values["aruba-sign-service-delegated-user"].value
    ARUBA_SIGN_SERVICE_IDENTITY_DELEGATED_PASSWORD = module.key_vault_secrets_query.values["aruba-sign-service-delegated-psw"].value
  }

  type = "Opaque"
}

resource "kubernetes_secret" "infocamere-service-secrets" {
  metadata {
    name      = "infocamere-service-secrets"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = {
    INFO_CAMERE_CLIENT_ID          = module.key_vault_secrets_query.values["infocamere-client-id"].value
    INFO_CAMERE_SECRET_PUBLIC_KEY  = module.key_vault_secrets_query.values["infocamere-secret-public-key"].value
    INFO_CAMERE_SECRET_PRIVATE_KEY = module.key_vault_secrets_query.values["infocamere-secret-private-key"].value
    INFO_CAMERE_SECRET_CERTIFICATE = module.key_vault_secrets_query.values["infocamere-secret-certificate"].value
  }

  type = "Opaque"
}

resource "kubernetes_secret" "national-registry-secrets" {
  metadata {
    name      = "national-registry-secrets"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = {
    NATIONAL_REGISTRY_API_KEY = module.key_vault_secrets_query.values["national-registry-api-key"].value
  }

  type = "Opaque"
}

resource "kubernetes_secret" "geotaxonomy-secrets" {
  metadata {
    name      = "geotaxonomy-secrets"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = {
    GEOTAXONOMY_API_KEY = module.key_vault_secrets_query.values["geotaxonomy-api-key"].value
  }

  type = "Opaque"
}

resource "kubernetes_secret" "pagopa-backoffice-secrets" {
  metadata {
    name      = "pagopa-backoffice-secrets"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = {
    BACKOFFICE_PAGO_PA_API_KEY = module.key_vault_secrets_query.values["pagopa-backoffice-api-key"].value
  }

  type = "Opaque"
}

resource "kubernetes_secret" "support-secrets" {
  metadata {
    name      = "support-secrets"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = {
    SUPPORT_API_KEY = module.key_vault_secrets_query.values["zendesk-support-api-key"].value
  }

  type = "Opaque"
}

