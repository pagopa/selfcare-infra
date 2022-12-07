env       = "prod"
env_short = "p"

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

ms_core = {
  USER_REGISTRY_MANAGEMENT_URL         = "https://api.pdv.pagopa.it/user-registry/v1"
  MAIL_ONBOARDING_CONFIRMATION_LINK    = "https://selfcare.pagopa.it/onboarding/confirm?jwt="
  MAIL_ONBOARDING_REJECTION_LINK       = "https://selfcare.pagopa.it/onboarding/cancel?jwt="
  PRODUCT_MANAGEMENT_URL               = "https://api.selfcare.pagopa.it/external/v1"
  SIGNATURE_VALIDATION_ENABLED         = "true"
  CONFIRM_TOKEN_TIMEOUT                = "90 seconds"
  ONBOARDING_SEND_EMAIL_TO_INSTITUTION = "true"
  SELFCARE_ADMIN_NOTIFICATION_URL      = "https://selfcare.pagopa.it/dashboard/admin/onboarding/"
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
