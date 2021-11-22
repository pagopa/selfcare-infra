resource "kubernetes_config_map" "inner-service-url" {
  metadata {
    name      = "inner-service-url"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = {
    HUB_SPID_LOGIN_URL                         = "http://hub-spid-login-ms:8080"
    B4F_DASHBOARD_URL                          = "http://b4f-dashboard:8080"
    MS_PRODUCT_URL                             = "http://ms-product:8080"
    USERVICE_PARTY_PROCESS_URL                 = "https://api.dev.selfcare.pagopa.it/party-process/v1" // TODO when mock not more required "http://pdnd-interop-uservice-party-process:8088/pdnd-interop-uservice-party-process/0.1"
    USERVICE_PARTY_MANAGEMENT_URL              = "https://api.dev.selfcare.pagopa.it/party-management/v1" // TODO when mock not more required "http://pdnd-interop-uservice-party-management:8088/pdnd-interop-uservice-party-management/0.1"
    USERVICE_PARTY_REGISTRY_PROXY_URL          = "https://api.dev.selfcare.pagopa.it/party-registry-proxy/v1" // TODO when mock not more required "http://pdnd-interop-uservice-party-registry-proxy:8088/pdnd-interop-uservice-party-registry-proxy/0.1"
    USERVICE_ATTRIBUTE_REGISTRY_MANAGEMENT_URL = "https://api.dev.selfcare.pagopa.it/attribute-registry-management/v1" // TODO when mock not more required "http://pdnd-interop-uservice-party-registry-proxy:8088/pdnd-interop-uservice-attribute-registry-management/0.1"
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
    ENDPOINT_ERROR    = "/error"
    ENDPOINT_SUCCESS  = format("%s/auth/login/success", var.cdn_frontend_url)
    ENDPOINT_LOGIN    = "/login"
    ENDPOINT_METADATA = "/metadata"
    ENDPOINT_LOGOUT   = "/logout"

    SPID_ATTRIBUTES    = "address,email,name,familyName,fiscalNumber,mobilePhone"
    SPID_VALIDATOR_URL = "https://validator.spid.gov.it"

    REQUIRED_ATTRIBUTES_SERVICE_NAME = "Selfcare Portal"
    ENABLE_FULL_OPERATOR_METADATA    = true
    COMPANY_EMAIL                    = "pagopa@pec.governo.it"
    COMPANY_FISCAL_CODE              = 15376371009
    COMPANY_IPA_CODE                 = "PagoPA"
    COMPANY_NAME                     = "PagoPA S.p.A"
    COMPANY_VAT_NUMBER               = 15376371009

    ENABLE_JWT                         = "true"
    INCLUDE_SPID_USER_ON_INTROSPECTION = "true"

    TOKEN_EXPIRATION = "3600"
    JWT_TOKEN_ISSUER = "SPID"

    # ADE
    ENABLE_ADE_AA = "false"

    # application insights key
    APPINSIGHTS_DISABLED = true
    },
    var.configmaps_hub-spid-login-ms,
    var.spid_testenv_url != null? {SPID_TESTENV_URL = var.spid_testenv_url}:{}
  )
}

resource "kubernetes_config_map" "ms-product" {
  metadata {
    name      = "ms-product"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = merge({
    JWT_TOKEN_PUBLIC_KEY = module.key_vault_secrets_query.values["jwt-public-key"].value
    MONGODB_NAME         = local.mongodb_name_selc_product
  },
  var.configmaps_ms-product
  )
}

resource "kubernetes_config_map" "b4f-dashboard" {
  metadata {
    name      = "b4f-dashboard"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = merge({
    JWT_TOKEN_PUBLIC_KEY = module.key_vault_secrets_query.values["jwt-public-key"].value
  },
  var.configmaps_b4f-dashboard
  )
}

resource "kubernetes_config_map" "uservice-attribute-registry-management" {
  metadata {
    name      = "uservice-attribute-registry-management"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = merge({
    APPLICATIONINSIGHTS_ROLE_NAME = "uservice-attribute-registry-management"
    POSTGRES_SCHEMA               = "attribute_registry"
  },
  var.configmaps_uservice-attribute-registry-management
  )
}

resource "kubernetes_config_map" "uservice-party-management" {
  metadata {
    name      = "uservice-party-management"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = merge({
    APPLICATIONINSIGHTS_ROLE_NAME = "uservice-party-management"
    POSTGRES_SCHEMA               = "party"
  },
  var.configmaps_uservice-party-management
  )
}

resource "kubernetes_config_map" "uservice-party-process" {
  metadata {
    name      = "uservice-party-process"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = merge({
    APPLICATIONINSIGHTS_ROLE_NAME = "uservice-party-process"
    MANAGER_PRODUCT_ROLES         = "ADMIN"//TODO
    DELEGATE_PRODUCT_ROLES        = "ADMIN"//TODO
    OPERATOR_PRODUCT_ROLES        = "ADMIN_REF,TECH_REF"//TODO
    PARTY_MANAGEMENT_URL          = format("http://pdnd-interop-uservice-party-management:8088/pdnd-interop-uservice-party-management/%s", var.api-version_uservice-party-management)
    PARTY_PROXY_URL               = format("http://pdnd-interop-uservice-party-registry-proxy:8088/pdnd-interop-uservice-party-registry-proxy/%s", var.api-version_uservice-party-registry-proxy)
    ATTRIBUTE_REGISTRY_URL        = format("http://pdnd-interop-uservice-attribute-registry-management:8088/pdnd-interop-uservice-attribute-registry-management/%s", var.api-version_uservice-attribute-registry-management)
  },
  var.configmaps_uservice-party-process
  )
}

resource "kubernetes_config_map" "uservice-party-registry-proxy" {
  metadata {
    name      = "uservice-party-registry-proxy"
    namespace = kubernetes_namespace.selc.metadata[0].name
  }

  data = merge({
    APPLICATIONINSIGHTS_ROLE_NAME = "uservice-party-registry-proxy"
  },
  var.configmaps_uservice-party-registry-proxy
  )
}
