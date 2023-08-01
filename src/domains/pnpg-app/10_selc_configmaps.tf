resource "kubernetes_config_map" "inner-service-url" {
  metadata {
    name      = "inner-service-url"
    namespace = var.domain
  }

  data = {
    HUB_SPID_LOGIN_URL                = "http://hub-spid-login-ms:8080"
    HUB-SOCIAL-LOGIN_URL              = "http://hub-social-login:8080"
    B4F_DASHBOARD_URL                 = "http://b4f-dashboard:8080"
    B4F_ONBOARDING_URL                = "http://b4f-onboarding:8080"
    MS_CORE_URL                       = "http://ms-core:8080"
    MS_PRODUCT_URL                    = "http://ms-product:8080"
    MS_NOTIFICATION_MANAGER_URL       = "http://ms-notification-manager:8080"
    MS_USER_GROUP_URL                 = "http://ms-user-group:8080"
    MS_CORE_URL                       = "http://ms-core:8080"
    USERVICE_PARTY_PROCESS_URL        = "http://ms-core:8080"
    USERVICE_PARTY_MANAGEMENT_URL     = "http://ms-core:8080"
    USERVICE_PARTY_REGISTRY_PROXY_URL = "http://ms-party-registry-proxy:8080"
    MOCK_SERVER                       = "http://mock-server:1080/selfcaremock/ic/ce/wspa/wspa/rest/"
    NATIONAL_REGISTRIES_CLIENT_READ_TIMEOUT : 50000
  }
}

resource "kubernetes_config_map" "jwt" {
  metadata {
    name      = "jwt"
    namespace = var.domain
  }

  data = {
    JWT_TOKEN_KID        = module.key_vault_secrets_query.values["jwt-kid"].value
    JWT_TOKEN_PUBLIC_KEY = module.key_vault_secrets_query.values["jwt-public-key"].value
    JWT_TOKEN_AUDIENCE   = var.jwt_audience
    JWT_ISSUER           = var.jwt_issuer
    WELL_KNOWN_URL       = "${local.cdn_storage_url}/.well-known/jwks.json"
  }
}

resource "kubernetes_config_map" "jwt-exchange" {
  metadata {
    name      = "jwt-exchange"
    namespace = var.domain
  }

  data = {
    JWT_TOKEN_EXCHANGE_DURATION   = var.jwt_token_exchange_duration
    JWT_TOKEN_EXCHANGE_KID        = module.key_vault_secrets_query.values["jwt-exchange-kid"].value
    JWT_TOKEN_EXCHANGE_PUBLIC_KEY = module.key_vault_secrets_query.values["jwt-exchange-public-key"].value
    WELL_KNOWN_URL                = "${local.cdn_storage_url}/.well-known/jwks.json"
  }
}

resource "kubernetes_config_map" "jwt-social" {
  metadata {
    name      = "jwt-social"
    namespace = var.domain
  }

  data = {
    JWT_SOCIAL_EXPIRE    = var.jwt_social_expire
    EMAIL_ALLOWED_DOMAIN = "@pagopa.it,@pagopa.com,@gmail.com"
  }
}

resource "kubernetes_config_map" "hub-spid-login-ms" {
  metadata {
    name      = "hub-spid-login-ms"
    namespace = var.domain
  }

  data = merge({
    JAVA_TOOL_OPTIONS = ""

    # SPID
    ORG_URL          = "https://www.pagopa.it"
    ACS_BASE_URL     = "${var.api_gateway_url}/spid/v1"
    ORG_DISPLAY_NAME = "PagoPA S.p.A"
    ORG_NAME         = "PagoPA"

    AUTH_N_CONTEXT = "https://www.spid.gov.it/SpidL2"

    ENDPOINT_ACS      = "/acs"
    ENDPOINT_ERROR    = var.env_short == "p" ? "https://imprese.notifichedigitali.it/auth/login/error" : "https://imprese.${var.env}.notifichedigitali.it/auth/login/error"
    ENDPOINT_SUCCESS  = var.env_short == "p" ? "https://imprese.notifichedigitali.it/auth/login/success" : "https://imprese.${var.env}.notifichedigitali.it/auth/login/success"
    ENDPOINT_LOGIN    = "/login"
    ENDPOINT_METADATA = "/metadata"
    ENDPOINT_LOGOUT   = "/logout"

    SPID_ATTRIBUTES    = "name,familyName,fiscalNumber"
    SPID_VALIDATOR_URL = "https://validator.spid.gov.it"

    REQUIRED_ATTRIBUTES_SERVICE_NAME = "Portale Notifiche Digitali Imprese"
    ENABLE_FULL_OPERATOR_METADATA    = true
    COMPANY_EMAIL                    = "pagopa@pec.governo.it"
    COMPANY_FISCAL_CODE              = 15376371009
    COMPANY_IPA_CODE                 = "PagoPA3"
    COMPANY_NAME                     = "PagoPA"
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

    ENABLE_SPID_ACCESS_LOGS          = "true"
    SPID_LOGS_PUBLIC_KEY             = module.key_vault_secrets_query.values["spid-logs-encryption-public-key"].value
    SPID_LOGS_STORAGE_KIND           = "azurestorage"
    SPID_LOGS_STORAGE_CONTAINER_NAME = "selc-${var.env_short}-logs-blob"

    },
    var.configmaps_hub-spid-login-ms,
    var.spid_testenv_url != null ? { SPID_TESTENV_URL = var.spid_testenv_url } : {}
  )
}

resource "kubernetes_config_map" "interop-be-party-process" {
  metadata {
    name      = "interop-be-party-process"
    namespace = var.domain
  }

  data = merge({
    APPLICATIONINSIGHTS_ROLE_NAME : "interop-be-party-process"
    MAIL_TEMPLATE_PATH : "contracts/template/mail/1.0.0.json"
    MAIL_TEMPLATE_COMPLETE_PATH : "contracts/template/mail/onboarding-complete/1.0.0.json"
    MAIL_TEMPLATE_NOTIFICATION_PATH : "contracts/template/mail/onboarding-notification/1.0.0.json"
    MAIL_TEMPLATE_REJECT_PATH : "contracts/template/mail/onboarding-refused/1.0.0.json"
    # URL of the european List Of Trusted List see https://esignature.ec.europa.eu/efda/tl-browser/#/screen/tl/EU
    EU_LIST_OF_TRUSTED_LISTS_URL : "https://ec.europa.eu/tools/lotl/eu-lotl.xml"
    # URL of the Official Journal URL where the EU trusted certificates are listed see https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=uriserv:OJ.C_.2019.276.01.0001.01.ENG
    EU_OFFICIAL_JOURNAL_URL : "https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=uriserv:OJ.C_.2019.276.01.0001.01.ENG"
    SELFCARE_URL : "https://selfcare.pagopa.it"
    PAGOPA_LOGO_URL : "resources/logo.png"

    JAVA_OPTS : "-javaagent:/applicationinsights-agent.jar"
    APPLICATIONINSIGHTS_INSTRUMENTATION_LOGGING_LEVEL : "OFF"
    REQUIRED_CONTACT_POINT_NR : "1"
    SIGNATURE_VALIDATION_ENABLED : "false"
    CONFIRM_TOKEN_TIMEOUT : "90 seconds"
    ONBOARDING_SEND_EMAIL_TO_INSTITUTION : "false"


    # PagoPa signature feature
    PAGOPA_SIGNATURE_ENABLED : "true"
    # Used only if the certifate doesn't contain it
    PAGOPA_SIGNATURE_SIGNER : "PagoPA S.p.A."
    ARUBA_SIGN_SERVICE_BASE_URL : "https://arss.demo.firma-automatica.it:443/ArubaSignService/ArubaSignService"
    ARUBA_SIGN_SERVICE_IDENTITY_TYPE_OTP_AUTH : "demoprod"
    ARUBA_SIGN_SERVICE_IDENTITY_OTP_PWD : "dsign"
    ARUBA_SIGN_SERVICE_IDENTITY_DELEGATED_DOMAIN : "demoprod"
    PAGOPA_SIGNATURE_LOCATION : "Roma"
    PAGOPA_SIGNATURE_ONBOARDING_REASON_TEMPLATE : "Firma contratto adesione prodotto"

    # module.key_vault_secrets_query.values["jwt-exchange-kid"].value
    },
    var.configmaps_interop-be-party-process
  )

}
resource "kubernetes_config_map" "selfcare-core" {
  metadata {
    name      = "selfcare-core"
    namespace = var.domain
  }

  data = merge({
    MAIL_TEMPLATE_PATH              = "resources/templates/email/onboarding_1.0.0.json"
    MAIL_TEMPLATE_COMPLETE_PATH     = "contracts/template/mail/onboarding-complete/1.0.0.json"
    MAIL_TEMPLATE_NOTIFICATION_PATH = "contracts/template/mail/onboarding-notification/1.0.0.json"
    MAIL_TEMPLATE_AUTOCOMPLETE_PATH = "contracts/template/mail/import-massivo-io/1.0.0.json"
    MAIL_TEMPLATE_REJECT_PATH       = "contracts/template/mail/onboarding-refused/1.0.0.json"
    # URL of the european List Of Trusted List see https://esignature.ec.europa.eu/efda/tl-browser/#/screen/tl/EU
    EU_LIST_OF_TRUSTED_LISTS_URL = "https://ec.europa.eu/tools/lotl/eu-lotl.xml"
    # URL of the Official Journal URL where the EU trusted certificates are listed see https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=uriserv:OJ.C_.2019.276.01.0001.01.ENG
    EU_OFFICIAL_JOURNAL_URL = "https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=uriserv:OJ.C_.2019.276.01.0001.01.ENG"
    SELFCARE_URL            = "https://selfcare.pagopa.it"
    PAGOPA_LOGO_URL         = "resources/logo.png"

    # module.key_vault_secrets_query.values["jwt-exchange-kid"].value
    },
    var.configmaps_ms_core
  )
}

resource "kubernetes_config_map" "common" {
  metadata {
    name      = "common"
    namespace = var.domain
  }

  data = merge({
    ENV_TARGET                   = upper(var.env)
    PUBLIC_FILE_STORAGE_BASE_URL = local.cdn_storage_url
    },
    var.configmaps_common
  )
}

resource "kubernetes_config_map" "aruba-sign-service" {
  metadata {
    name      = "aruba-sign-service"
    namespace = var.domain
  }

  data = merge({
    ARUBA_SIGN_SERVICE_IDENTITY_OTP_PWD = "dsign"
    },
    var.aruba_sign_service
  )
}

resource "kubernetes_config_map" "infocamere-service" {
  metadata {
    name      = "infocamere-service"
    namespace = var.domain
  }

  data = {
    INFO_CAMERE_URL                            = "https://icapiscl.infocamere.it/ic/ce/wspa/wspa/rest/"
    INFO_CAMERE_AUTHENTICATION_ENDPOINT        = "authentication"
    INFO_CAMERE_INSTITUTIONS_BY_LEGAL_ENDPOINT = "listaLegaleRappresentante/{taxId}"
  }
}

resource "kubernetes_config_map" "geo-taxonomies" {
  metadata {
    name      = "geo-taxonomies"
    namespace = var.domain
  }

  data = var.geo-taxonomies
}



resource "kubernetes_config_map" "national-registries-service" {
  metadata {
    name      = "national-registries-service"
    namespace = var.domain
  }

  data = var.configmaps_national_registries

}
