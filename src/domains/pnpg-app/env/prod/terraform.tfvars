prefix          = "selc"
env_short       = "p"
env             = "prod"
domain          = "pnpg"
location        = "westeurope"
location_string = "West Europe"
location_short  = "weu"
instance        = "prod01"

tags = {
  CreatedBy   = "Terraform"
  Environment = "PROD"
  Owner       = "Selfcare"
  Source      = "https://github.com/pagopa/selfcare-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources

monitor_resource_group_name                 = "selc-p-monitor-rg"
log_analytics_workspace_name                = "selc-p-law"
log_analytics_workspace_resource_group_name = "selc-p-monitor-rg"

### Aks

aks_name                = "selc-p-weu-prod01-aks"
aks_resource_group_name = "selc-p-weu-prod01-aks-rg"

ingress_load_balancer_ip       = "10.11.100.250"
ingress_load_balancer_hostname = "prod01.pnpg.internal.selfcare.pagopa.it"
reverse_proxy_be_io            = "10.1.0.250"

#
# Dns
#
dns_zone_internal_prefix = "internal.selfcare"
external_domain          = "pagopa.it"

reloader_helm = {
  chart_version = "v0.0.118"
  image_name    = "stakater/reloader"
  image_tag     = "v0.0.118@sha256:2d423cab8d0e83d1428ebc70c5c5cafc44bd92a597bff94007f93cddaa607b02"
}

# chart releases: https://github.com/pagopa/aks-microservice-chart-blueprint/releases
# image tags: https://github.com/pagopa/infra-ssl-check/releases
tls_cert_check_helm = {
  chart_version = "2.0.0"
  image_name    = "ghcr.io/pagopa/infra-ssl-check"
  image_tag     = "v1.3.4@sha256:c3d45736706c981493b6216451fc65e99a69d5d64409ccb1c4ca93fef57c921d"
}

# Gateway
api_gateway_url = "https://api-pnpg.selfcare.pagopa.it"
# cdn_frontend_url = "https://selfcare.pagopa.it"
# cdn_storage_url  = "https://selcdcheckoutsa.z6.web.core.windows.net"
spid_testenv_url = "https://selc-p-pnpg-spid-testenv.westeurope.azurecontainer.io"

# uservice versions
api-version_uservice-party-management     = "0.1"
api-version_uservice-party-process        = "0.1"
api-version_uservice-party-registry-proxy = "v1"

# jwt exchange duration
jwt_token_exchange_duration = "PT15M"

# session jwt audience
jwt_audience      = "imprese.notifichedigitali.it"
jwt_issuer        = "SPID"
jwt_social_expire = "10000000"

configmaps_interop-be-party-process = {
  USER_REGISTRY_MANAGEMENT_URL : "https://api-pnpg.pdv.pagopa.it/user-registry/v1"
  MAIL_ONBOARDING_CONFIRMATION_LINK : "https://selfcare.pagopa.it/onboarding/confirm?jwt="
  MAIL_ONBOARDING_REJECTION_LINK : "https://selfcare.pagopa.it/onboarding/cancel?jwt="
  PRODUCT_MANAGEMENT_URL : "https://api-pnpg.selfcare.pagopa.it/external/v1"
  SELFCARE_ADMIN_NOTIFICATION_URL : "https://selfcare.pagopa.it/dashboard/admin/onboarding/"
  GEO_TAXONOMY_URL : "https://api.pdnd.pagopa.it/geo-tax"
  MAIL_ONBOARDING_URL : "https://selfcare.pagopa.it/onboarding/"
}

configmaps_ms_core = {
  USER_REGISTRY_MANAGEMENT_URL         = "https://api.pdv.pagopa.it/user-registry/v1"
  MAIL_ONBOARDING_CONFIRMATION_LINK    = "https://selfcare.pagopa.it/onboarding/confirm?jwt="
  MAIL_ONBOARDING_REJECTION_LINK       = "https://selfcare.pagopa.it/onboarding/cancel?jwt="
  PRODUCT_MANAGEMENT_URL               = "https://api-pnpg.selfcare.pagopa.it/external/v1"
  SIGNATURE_VALIDATION_ENABLED         = "false"
  CONFIRM_TOKEN_TIMEOUT                = "90 seconds"
  ONBOARDING_SEND_EMAIL_TO_INSTITUTION = "false"
  SELFCARE_ADMIN_NOTIFICATION_URL      = "https://selfcare.pagopa.it/dashboard/admin/onboarding/"
  GEO_TAXONOMY_URL                     = "https://api.pdnd.pagopa.it/geo-tax"
}

# configs/secrets

configmaps_hub-spid-login-ms = {
  APPLICATIONINSIGHTS_ROLE_NAME                     = "hub-spid-login-ms"
  APPLICATIONINSIGHTS_INSTRUMENTATION_LOGGING_LEVEL = "OFF"

  USER_REGISTRY_URL = "https://api.pdv.pagopa.it/user-registry/v1"

  # SPID
  ORG_ISSUER = "https://imprese.notifichedigitali.it"

  CIE_URL          = "https://preproduzione.idserver.servizicie.interno.gov.it/idp/shibboleth?Metadata"
  SERVER_PORT      = "8080"
  IDP_METADATA_URL = "https://api.is.eng.pagopa.it/idp-keys/spid/latest"
}

configmaps_common = {
  USERVICE_USER_REGISTRY_URL             = "https://api.pdv.pagopa.it/user-registry/v1"
  ENABLE_CONFIDENTIAL_FILTER             = "FALSE"
  ENABLE_SINGLE_LINE_STACK_TRACE_LOGGING = "true"
}

aruba_sign_service = {
  ARUBA_SIGN_SERVICE_BASE_URL                  = "https://arss.demo.firma-automatica.it:443/ArubaSignService/ArubaSignService"
  ARUBA_SIGN_SERVICE_IDENTITY_TYPE_OTP_AUTH    = "demoprod"
  ARUBA_SIGN_SERVICE_IDENTITY_DELEGATED_DOMAIN = "demoprod"
}

geo-taxonomies = {
  GEO_TAXONOMIES_URL = "https://api-pnpg.selfcare.pagopa.it/external"
}


terraform_remote_state_core = {
  resource_group_name  = "terraform-state-rg"
  storage_account_name = "tfinfprodselfcare"
  container_name       = "terraform-state"
  key                  = "domain-pnpg-common.terraform.tfstate"
}
