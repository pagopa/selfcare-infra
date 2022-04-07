resource "kubernetes_config_map" "inner-service-url" {
  metadata {
    name      = "inner-service-url"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = {
    HUB_SPID_LOGIN_URL                = "http://hub-spid-login-ms:8080"
    B4F_DASHBOARD_URL                 = "http://b4f-dashboard:8080"
    B4F_ONBOARDING_URL                = "http://b4f-onboarding:8080"
    MS_PRODUCT_URL                    = "http://ms-product:8080"
    MS_NOTIFICATION_MANAGER_URL       = "http://ms-notification-manager:8080"
    MS_USER_GROUP_URL                 = "http://ms-user-group:8080"
    USERVICE_PARTY_PROCESS_URL        = format("http://interop-be-party-process:8088/party-process/%s", var.api-version_uservice-party-process)
    USERVICE_PARTY_MANAGEMENT_URL     = format("http://interop-be-party-management:8088/party-management/%s", var.api-version_uservice-party-management)
    USERVICE_PARTY_REGISTRY_PROXY_URL = format("http://interop-be-party-registry-proxy:8088/party-registry-proxy/%s", var.api-version_uservice-party-registry-proxy)
    USERVICE_PARTY_MOCK_REGISTRY_URL  = format("http://interop-be-party-mock-registry:8088/party-mock-registry/%s", var.api-version_uservice-party-mock-registry)
  }
}

resource "kubernetes_config_map" "jwt" {
  metadata {
    name      = "jwt"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = {
    JWT_TOKEN_KID        = module.key_vault_secrets_query.values["jwt-kid"].value
    JWT_TOKEN_PUBLIC_KEY = module.key_vault_secrets_query.values["jwt-public-key"].value
    JWT_TOKEN_AUDIENCE   = var.jwt_audience
    WELL_KNOWN_URL       = format("%s/.well-known/jwks.json", var.cdn_storage_url)
  }
}

resource "kubernetes_config_map" "jwt-exchange" {
  metadata {
    name      = "jwt-exchange"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = {
    JWT_TOKEN_EXCHANGE_DURATION   = var.jwt_token_exchange_duration
    JWT_TOKEN_EXCHANGE_KID        = module.key_vault_secrets_query.values["jwt-exchange-kid"].value
    JWT_TOKEN_EXCHANGE_PUBLIC_KEY = module.key_vault_secrets_query.values["jwt-exchange-public-key"].value
    WELL_KNOWN_URL                = format("%s/.well-known/jwks.json", var.cdn_storage_url)
  }
}

resource "kubernetes_config_map" "hub-spid-login-ms" {
  metadata {
    name      = "hub-spid-login-ms"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = merge({
    JAVA_TOOL_OPTIONS = ""

    # SPID
    ORG_URL          = "https://pagopa.gov.it"
    ACS_BASE_URL     = format("%s/spid/v1", var.api_gateway_url)
    ORG_DISPLAY_NAME = "PagoPA S.p.A"
    ORG_NAME         = "PagoPA"

    AUTH_N_CONTEXT = "https://www.spid.gov.it/SpidL2"

    ENDPOINT_ACS      = "/acs"
    ENDPOINT_ERROR    = format("%s/auth/login/error", var.cdn_frontend_url)
    ENDPOINT_SUCCESS  = format("%s/auth/login/success", var.cdn_frontend_url)
    ENDPOINT_LOGIN    = "/login"
    ENDPOINT_METADATA = "/metadata"
    ENDPOINT_LOGOUT   = "/logout"

    SPID_ATTRIBUTES    = "name,familyName,fiscalNumber,email"
    SPID_VALIDATOR_URL = "https://validator.spid.gov.it"

    REQUIRED_ATTRIBUTES_SERVICE_NAME = "Selfcare Portal"
    ENABLE_FULL_OPERATOR_METADATA    = true
    COMPANY_EMAIL                    = "pagopa@pec.governo.it"
    COMPANY_FISCAL_CODE              = 15376371009
    COMPANY_IPA_CODE                 = "PagoPA"
    COMPANY_NAME                     = "PagoPA S.p.A"
    COMPANY_VAT_NUMBER               = "IT15376371009"

    ENABLE_JWT                         = "true"
    INCLUDE_SPID_USER_ON_INTROSPECTION = "true"

    # TOKEN_EXPIRATION requires seconds
    TOKEN_EXPIRATION = var.token_expiration_minutes * 60
    JWT_TOKEN_ISSUER = "SPID"

    # ADE
    ENABLE_ADE_AA = "false"

    APPINSIGHTS_DISABLED = "false"

    ENABLE_USER_REGISTRY = "true"

    JWT_TOKEN_AUDIENCE = var.jwt_audience

    },
    var.configmaps_hub-spid-login-ms,
    var.spid_testenv_url != null ? { SPID_TESTENV_URL = var.spid_testenv_url } : {}
  )
}

resource "kubernetes_config_map" "common" {
  metadata {
    name      = "common"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = merge({
    ENV_TARGET                   = upper(var.env)
    PUBLIC_FILE_STORAGE_BASE_URL = var.cdn_storage_url
    },
    var.configmaps_common
  )
}
