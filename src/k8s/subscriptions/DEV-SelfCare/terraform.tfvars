env       = "dev"
env_short = "d"

aks_name                = "selc-d-aks"
aks_resource_group_name = "selc-d-aks-rg"

# ingress
ingress_replica_count    = "2"
ingress_load_balancer_ip = "10.1.1.250"

# Gateway
api_gateway_url  = "https://api.dev.selfcare.pagopa.it"
cdn_frontend_url = "https://dev.selfcare.pagopa.it"
cdn_storage_url  = "https://selcdcheckoutsa.z6.web.core.windows.net"
spid_testenv_url = "https://selc-d-spid-testenv.westeurope.azurecontainer.io"

# jwt exchange duration
jwt_token_exchange_duration = "PT15M"

# Billing Token Exchange audience and url
token_exchange_billing_audience = "dev.portalefatturazione.pagopa.it"
token_exchange_billing_url      = "https://dev.portalefatturazione.pagopa.it/auth?selfcareToken=<IdentityToken>"

# session jwt audience
jwt_audience = "api.dev.selfcare.pagopa.it"

jwt_social_expire = "10000000"

configmaps_national_registries = {
  NATIONAL_REGISTRIES_URL = "https://api-selcpg.dev.notifichedigitali.it/national-registries-private"
}

configmaps_ms_core = {
  USER_REGISTRY_MANAGEMENT_URL         = "https://api.uat.pdv.pagopa.it/user-registry/v1"
  MAIL_ONBOARDING_CONFIRMATION_LINK    = "https://dev.selfcare.pagopa.it/onboarding/confirm?jwt="
  MAIL_ONBOARDING_REJECTION_LINK       = "https://dev.selfcare.pagopa.it/onboarding/cancel?jwt="
  MAIL_ONBOARDING_URL                  = "https://dev.selfcare.pagopa.it/onboarding/"
  PRODUCT_MANAGEMENT_URL               = "https://api.dev.selfcare.pagopa.it/external/v1"
  SIGNATURE_VALIDATION_ENABLED         = "false"
  CONFIRM_TOKEN_TIMEOUT                = "90 seconds"
  ONBOARDING_SEND_EMAIL_TO_INSTITUTION = "false"
  SELFCARE_ADMIN_NOTIFICATION_URL      = "https://dev.selfcare.pagopa.it/dashboard/admin/onboarding/"
  GEO_TAXONOMY_URL                     = "https://api.pdnd.pagopa.it/geo-tax"
  PAGOPA_SIGNATURE_ONBOARDING_ENABLED  = "false"
}

# configs/secrets

configmaps_hub-spid-login-ms = {
  APPLICATIONINSIGHTS_ROLE_NAME                     = "hub-spid-login-ms"
  APPLICATIONINSIGHTS_INSTRUMENTATION_LOGGING_LEVEL = "OFF"

  USER_REGISTRY_URL = "https://api.uat.pdv.pagopa.it/user-registry/v1"

  # SPID
  ORG_ISSUER = "https://selfcare.pagopa.it"

  CIE_URL          = "https://preproduzione.idserver.servizicie.interno.gov.it/idp/shibboleth?Metadata"
  SERVER_PORT      = "8080"
  IDP_METADATA_URL = "https://api.is.eng.pagopa.it/idp-keys/spid/latest"
}

configmaps_common = {
  USERVICE_USER_REGISTRY_URL             = "https://api.uat.pdv.pagopa.it/user-registry/v1"
  ENABLE_CONFIDENTIAL_FILTER             = "FALSE"
  ENABLE_SINGLE_LINE_STACK_TRACE_LOGGING = "true"
}

aruba_sign_service = {
  ARUBA_SIGN_SERVICE_BASE_URL                  = "https://arss.demo.firma-automatica.it:443/ArubaSignService/ArubaSignService"
  ARUBA_SIGN_SERVICE_IDENTITY_TYPE_OTP_AUTH    = "demoprod"
  ARUBA_SIGN_SERVICE_IDENTITY_DELEGATED_DOMAIN = "demoprod"
}

geo-taxonomies = {
  GEO_TAXONOMIES_URL = "https://api.pdnd.pagopa.it/geo-tax"
}

anac-ftp = {
  ANAC_FTP_IP        = "93.43.119.85"
  ANAC_FTP_PORT      = 22
  ANAC_FTP_USER      = "PagoPA_user"
  ANAC_FTP_DIRECTORY = "/mnt/RegistroGestoriPiattaforme/Collaudo/"
}

external-interceptor-url = {
  PROD_FD_URL = "https://fid00001fe.siachain.sv.sia.eu:30008"
}

# tls_cert_check_helm = {
#   chart_version = "1.21.0"
#   image_name    = "ghcr.io/pagopa/infra-ssl-check"
#   image_tag     = "v1.2.2@sha256:22f4b53177cc8891bf10cbd0deb39f60e1cd12877021c3048a01e7738f63e0f9"
# }

# tls_checker_https_endpoints_to_check = [
#   {
#     https_endpoint = "api.selfcare.pagopa.it",
#     alert_name     = "api.selfcare.pagopa.it",
#     alert_enabled  = true,
#     helm_present   = true,
#   },
# ]


location_string = "West Europe"

monitor_resource_group_name = "selc-d-monitor-rg"

tls_cert_check_helm = {
  chart_version = "1.21.0"
  image_name    = "ghcr.io/pagopa/infra-ssl-check"
  image_tag     = "v1.2.2@sha256:22f4b53177cc8891bf10cbd0deb39f60e1cd12877021c3048a01e7738f63e0f9"
}

tls_checker_https_endpoints_to_check = [
  {
    https_endpoint = "api.dev.selfcare.pagopa.it",
    alert_name     = "api-dev-selfcare-pagopa-it",
    alert_enabled  = true,
    helm_present   = true,
  },
  {
    https_endpoint = "selc.internal.dev.selfcare.pagopa.it",
    alert_name     = "selc.internal.dev.selfcare.pagopa.it",
    alert_enabled  = true,
    helm_present   = true,
  }
]

secrets_tls_certificates = [
  "selc-internal-dev-selfcare-pagopa-it"
]

ingress_health = {
  host        = "selc.internal.dev.selfcare.pagopa.it"
  secret_name = "selc-internal-dev-selfcare-pagopa-it"
}
