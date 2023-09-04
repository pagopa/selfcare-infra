env       = "prod"
env_short = "p"

aks_name                = "selc-p-aks"
aks_resource_group_name = "selc-p-aks-rg"

# ingress
ingress_replica_count    = "2"
ingress_load_balancer_ip = "10.1.1.250"

# Gateway
api_gateway_url  = "https://api.selfcare.pagopa.it"
cdn_frontend_url = "https://selfcare.pagopa.it"
cdn_storage_url  = "https://selcpcheckoutsa.z6.web.core.windows.net"

# uservice versions
api-version_uservice-party-management     = "0.1"
api-version_uservice-party-process        = "0.1"
api-version_uservice-party-registry-proxy = "v1"

# session jwt audience
jwt_audience = "api.selfcare.pagopa.it"

jwt_social_expire = "10000000"

configmaps_ms_core = {
  USER_REGISTRY_MANAGEMENT_URL         = "https://api.pdv.pagopa.it/user-registry/v1"
  MAIL_ONBOARDING_CONFIRMATION_LINK    = "https://selfcare.pagopa.it/onboarding/confirm?jwt="
  MAIL_ONBOARDING_REJECTION_LINK       = "https://selfcare.pagopa.it/onboarding/cancel?jwt="
  MAIL_ONBOARDING_URL                  = "https://selfcare.pagopa.it/onboarding/"
  PRODUCT_MANAGEMENT_URL               = "https://api.selfcare.pagopa.it/external/v1"
  SIGNATURE_VALIDATION_ENABLED         = "true"
  CONFIRM_TOKEN_TIMEOUT                = "90 seconds"
  ONBOARDING_SEND_EMAIL_TO_INSTITUTION = "true"
  SELFCARE_ADMIN_NOTIFICATION_URL      = "https://selfcare.pagopa.it/dashboard/admin/onboarding/"
  GEO_TAXONOMY_URL                     = "https://api.pdnd.pagopa.it/geo-tax"
  PAGOPA_SIGNATURE_ONBOARDING_ENABLED  = "true"
}


# configs/secrets

configmaps_hub-spid-login-ms = {
  APPLICATIONINSIGHTS_ROLE_NAME                     = "hub-spid-login-ms"
  APPLICATIONINSIGHTS_INSTRUMENTATION_LOGGING_LEVEL = "OFF"

  USER_REGISTRY_URL = "https://api.pdv.pagopa.it/user-registry/v1"

  # SPID
  ORG_ISSUER = "https://selfcare.pagopa.it"

  CIE_URL          = "https://api.is.eng.pagopa.it/idp-keys/cie/latest"
  SERVER_PORT      = "8080"
  IDP_METADATA_URL = "https://api.is.eng.pagopa.it/idp-keys/spid/latest"
}

configmaps_common = {
  USERVICE_USER_REGISTRY_URL             = "https://api.pdv.pagopa.it/user-registry/v1"
  ENABLE_CONFIDENTIAL_FILTER             = "TRUE"
  ENABLE_SINGLE_LINE_STACK_TRACE_LOGGING = "true"
}

aruba_sign_service = {
  ARUBA_SIGN_SERVICE_BASE_URL                  = "https://asbr-pagopa.arubapec.it/ArubaSignService/ArubaSignService"
  ARUBA_SIGN_SERVICE_IDENTITY_TYPE_OTP_AUTH    = "faPagoPa"
  ARUBA_SIGN_SERVICE_IDENTITY_DELEGATED_DOMAIN = "faPagoPa"
}

geo-taxonomies = {
  GEO_TAXONOMIES_URL = "https://api.dev.selfcare.pagopa.it/external"
}

external-interceptor-url = {
  PROD_FD_URL = ""
}
