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

# Billing Token Exchange audience and url
token_exchange_billing_audience = "portalefatturazione.pagopa.it"
token_exchange_billing_url      = "https://portalefatturazione.pagopa.it/auth?selfcareToken=<IdentityToken>"

# session jwt audience
jwt_audience = "api.selfcare.pagopa.it"

jwt_social_expire = "10000000"

configmaps_national_registries = {
  NATIONAL_REGISTRIES_URL = "https://api-selcpg.notifichedigitali.it/national-registries-private"
}

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
  ORG_ISSUER = "https://selfcare.pagopa.it/pub-op-full/"

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

anac-ftp = {
  ANAC_FTP_IP        = "93.43.119.85"
  ANAC_FTP_PORT      = 22
  ANAC_FTP_USER      = "PagoPA_user"
  ANAC_FTP_DIRECTORY = "/mnt/RegistroGestoriPiattaforme/Collaudo/"
}

external-interceptor-url = {
  PROD_FD_URL = "https://portale.fideiussionidigitali.it"
}


location_string = "West Europe"

monitor_resource_group_name = "selc-p-monitor-rg"

tls_cert_check_helm = {
  chart_version = "1.21.0"
  image_name    = "ghcr.io/pagopa/infra-ssl-check"
  image_tag     = "v1.2.2@sha256:22f4b53177cc8891bf10cbd0deb39f60e1cd12877021c3048a01e7738f63e0f9"
}

tls_checker_https_endpoints_to_check = [
  {
    https_endpoint = "api.selfcare.pagopa.it",
    alert_name     = "api-selfcare-pagopa-it",
    alert_enabled  = true,
    helm_present   = true,
  },
  {
    https_endpoint = "selc.internal.selfcare.pagopa.it",
    alert_name     = "selc.internal.selfcare.pagopa.it",
    alert_enabled  = true,
    helm_present   = true,
  }
]

secrets_tls_certificates = [
  "selc-internal-selfcare-pagopa-it"
]

ingress_health = {
  host        = "selc.internal.selfcare.pagopa.it"
  secret_name = "selc-internal-selfcare-pagopa-it"
}
