resource "kubernetes_secret" "hub-spid-login-ms" {
  metadata {
    name      = "hub-spid-login-ms"
    namespace = var.domain
  }

  data = {
    # APPINSIGHTS_INSTRUMENTATIONKEY = local.appinsights_instrumentation_key
    JWT_TOKEN_PRIVATE_KEY = module.key_vault_secrets_query.values["jwt-private-key"].value
    JWT_TOKEN_KID         = module.key_vault_secrets_query.values["jwt-kid"].value

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
    namespace = var.domain
  }

  data = {
    # REDIS_URL      = local.redis_url
    REDIS_PASSWORD = module.key_vault_secrets_query.values["redis-primary-access-key"].value
    REDIS_PORT     = "6380"
    REDIS_URL      = local.redis_url
  }

  type = "Opaque"
}

resource "kubernetes_secret" "selc-application-insights" {
  metadata {
    name      = "application-insights"
    namespace = var.domain
  }

  data = {
    APPLICATIONINSIGHTS_CONNECTION_STRING = data.azurerm_application_insights.application_insights.connection_string
    APPINSIGHTS_INSTRUMENTATIONKEY        = data.azurerm_application_insights.application_insights.instrumentation_key
  }

  type = "Opaque"
}

resource "kubernetes_secret" "mongo-credentials" {
  metadata {
    name      = "mongo-credentials"
    namespace = var.domain
  }

  data = {
    MONGODB_CONNECTION_URI       = module.key_vault_secrets_query.values["mongodb-connection-string"].value
    MONGODB_NAME_SELC_MSCORE     = local.mongodb_name_selc_core
    MONGODB_NAME_SELC_USER_GROUP = local.mongodb_name_selc_user_group
  }

  type = "Opaque"
}

resource "kubernetes_secret" "mail" {
  metadata {
    name      = "mail"
    namespace = var.domain
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
    namespace = var.domain
  }

  data = {
    MAIL_SERVER_HOST          = "smtp.gmail.com"
    MAIL_SERVER_PORT          = 587
    MAIL_SERVER_USERNAME      = module.key_vault_secrets_query.values["smtp-not-pec-usr"].value
    MAIL_SERVER_PASSWORD      = module.key_vault_secrets_query.values["smtp-not-pec-psw"].value
    AWS_SES_ACCESS_KEY_ID     = module.key_vault_secrets_query.values["aws-ses-access-key-id"].value
    AWS_SES_SECRET_ACCESS_KEY = module.key_vault_secrets_query.values["aws-ses-secret-access-key"].value
    AWS_SES_REGION            = "eu-south-1"
  }

  type = "Opaque"
}

resource "kubernetes_secret" "contracts-storage" {
  metadata {
    name      = "contracts-storage"
    namespace = var.domain
  }

  data = {
    STORAGE_TYPE               = "BlobStorage"
    STORAGE_CONTAINER          = "$web"
    STORAGE_ENDPOINT           = "core.windows.net"
    STORAGE_APPLICATION_ID     = local.contracts_storage_account_name
    STORAGE_APPLICATION_SECRET = module.key_vault_secrets_query.values["contracts-storage-access-key"].value
    STORAGE_CREDENTIAL_ID      = "selc${var.env_short}weupnpgcheckoutsa"
    STORAGE_CREDENTIAL_SECRET  = module.key_vault_secrets_query.values["contracts-storage-access-key"].value
    STORAGE_TEMPLATE_URL       = format("https://selc%sweupnpgcheckoutsa.z6.web.core.windows.net", var.env_short)
  }

  type = "Opaque"
}

resource "kubernetes_secret" "cdn-storage" {
  metadata {
    name      = "cdn-storage"
    namespace = var.domain
  }

  data = {
    BLOB_STORAGE_CONN_STRING = module.key_vault_secrets_query.values["cdn-storage-blob-connection-string"].value
    BLOB_CONTAINER_REF       = "$web"
    BLOBSTORAGE_PUBLIC_HOST  = replace(local.cdn_storage_url, "/https?:\\/\\//", "")
    BLOBSTORAGE_PUBLIC_URL   = local.cdn_storage_url
    CDN_PUBLIC_URL           = local.cdn_fqdn_url
  }

  type = "Opaque"
}

resource "kubernetes_secret" "b4f-dashboard" {
  metadata {
    name      = "b4f-dashboard"
    namespace = var.domain
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
    namespace = var.domain
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
    namespace = var.domain
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
    namespace = var.domain
  }

  data = {
    GOOGLE_CLIENT_SECRET = module.key_vault_secrets_query.values["google-client-secret"].value
    GOOGLE_CLIENT_ID     = module.key_vault_secrets_query.values["google-client-id"].value
    JWT_SECRET           = module.key_vault_secrets_query.values["jwt-secret"].value
  }

  type = "Opaque"
}


resource "kubernetes_secret" "common-secrets" {
  metadata {
    name      = "common-secrets"
    namespace = var.domain
  }

  data = {
    USERVICE_USER_REGISTRY_API_KEY = module.key_vault_secrets_query.values["user-registry-api-key"].value
    # can be remove after mmigration of onboarding-backend to container apps
    USER-REGISTRY-API-KEY = module.key_vault_secrets_query.values["user-registry-api-key"].value
  }

  type = "Opaque"
}

resource "kubernetes_secret" "onboarding-interceptor-apim-internal" {
  metadata {
    name      = "onboarding-interceptor-apim-internal"
    namespace = var.domain
  }

  data = {
    SELFCARE_APIM_INTERNAL_API_KEY = module.key_vault_secrets_query.values["onboarding-interceptor-apim-internal"].value
  }

  type = "Opaque"
}

resource "kubernetes_secret" "aruba-sign-service-secrets" {
  metadata {
    name      = "aruba-sign-service-secrets"
    namespace = var.domain
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
    namespace = var.domain
  }

  data = {
    INFO_CAMERE_CLIENT_ID          = module.key_vault_secrets_query.values["infocamere-client-id"].value
    INFO_CAMERE_SECRET_PUBLIC_KEY  = module.key_vault_secrets_query.values["infocamere-secret-public-key"].value
    INFO_CAMERE_SECRET_PRIVATE_KEY = module.key_vault_secrets_query.values["infocamere-secret-private-key"].value
    INFO_CAMERE_SECRET_CERTIFICATE = module.key_vault_secrets_query.values["infocamere-secret-certificate"].value
  }

  type = "Opaque"
}

resource "kubernetes_secret" "onboarding-interceptor-event-secrets" {
  metadata {
    name      = "onboarding-interceptor-event-secrets"
    namespace = var.domain
  }

  data = {
    # KAFKA_BROKER            = "${local.project}-eventhub-ns.servicebus.windows.net:9093"
    # KAFKA_SECURITY_PROTOCOL = "SASL_SSL"
    # KAFKA_SASL_MECHANISM    = "PLAIN"

    # KAFKA_CONTRACTS_TOPIC                        = "SC-Contracts"
    # KAFKA_CONTRACTS_SELFCARE_RO_SASL_JAAS_CONFIG = "org.apache.kafka.common.security.plain.PlainLoginModule required username=\"$ConnectionString\" password=\"${module.key_vault_secrets_query.values["eventhub-SC-Contracts-interceptor-connection-string"].value}\";"
  }

  type = "Opaque"
}

resource "kubernetes_secret" "event-secrets" {
  metadata {
    name      = "event-secrets"
    namespace = var.domain
  }

  data = {
    # KAFKA_BROKER            = "${local.project}-eventhub-ns.servicebus.windows.net:9093"
    # KAFKA_SECURITY_PROTOCOL = "SASL_SSL"
    # KAFKA_SASL_MECHANISM    = "PLAIN"

    # KAFKA_CONTRACTS_TOPIC                        = "SC-Contracts"
    # KAFKA_CONTRACTS_SELFCARE_WO_SASL_JAAS_CONFIG = "org.apache.kafka.common.security.plain.PlainLoginModule required username=\"$ConnectionString\" password=\"${module.key_vault_secrets_query.values["eventhub-SC-Contracts-selfcare-wo-connection-string"].value}\";"
  }

  type = "Opaque"
}

resource "kubernetes_secret" "national-registry-secrets" {
  metadata {
    name      = "national-registry-secrets"
    namespace = var.domain
  }

  data = {
    NATIONAL_REGISTRY_API_KEY = module.key_vault_secrets_query.values["national-registry-api-key"].value
  }

  type = "Opaque"
}

resource "kubernetes_secret" "product-storage" {
  metadata {
    name      = "product-storage"
    namespace = var.domain
  }

  data = {
    BLOB-STORAGE-PRODUCT-CONNECTION-STRING = module.key_vault_secrets_query.values["blob-storage-product-connection-string"].value
  }

  type = "Opaque"
}

resource "kubernetes_secret" "support-secrets" {
  metadata {
    name      = "support-secrets"
    namespace = var.domain
  }

  data = {
    SUPPORT_API_KEY = module.key_vault_secrets_query.values["zendesk-support-api-key"].value
  }

  type = "Opaque"
}

resource "kubernetes_secret" "anac-ftp-secret" {
  metadata {
    name      = "anac-ftp-secret"
    namespace = var.domain
  }

  data = {
    ANAC_FTP_PASSWORD   = module.key_vault_secrets_query.values["anac-ftp-password"].value
    ANAC_FTP_KNOWN_HOST = module.key_vault_secrets_query.values["anac-ftp-known-host"].value
  }

  type = "Opaque"
}
