prefix          = "selc"
env_short       = "d"
env             = "dev"
domain          = "pnpg"
location        = "westeurope"
location_string = "West Europe"
location_short  = "weu"
instance        = "dev01"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "Selfcare"
  Source      = "https://github.com/pagopa/selfcare-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources

monitor_resource_group_name                 = "selc-d-monitor-rg"
log_analytics_workspace_name                = "selc-d-law"
log_analytics_workspace_resource_group_name = "selc-d-monitor-rg"

### Aks

aks_name                = "selc-d-weu-dev01-aks"
aks_resource_group_name = "selc-d-weu-dev01-aks-rg"

ingress_load_balancer_ip       = "10.11.100.250"
ingress_load_balancer_hostname = "dev01.pnpg.internal.dev.selfcare.pagopa.it"
reverse_proxy_be_io            = "10.1.0.250"
# This is the k8s ingress controller ip. It must be in the aks subnet range.
reverse_proxy_ip = "10.11.100.250"
#
# Dns
#
dns_zone_internal_prefix = "internal.dev.selfcare"
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
api_gateway_url = "https://api-pnpg.dev.selfcare.pagopa.it"
# cdn_frontend_url = "https://dev.selfcare.pagopa.it"
# cdn_storage_url  = "https://selcdcheckoutsa.z6.web.core.windows.net"
spid_testenv_url = "https://selc-d-pnpg-spid-testenv.westeurope.azurecontainer.io"

# uservice versions
api-version_uservice-party-management     = "0.1"
api-version_uservice-party-process        = "0.1"
api-version_uservice-party-registry-proxy = "v1"

# jwt exchange duration
jwt_token_exchange_duration = "PT15M"

# session jwt audience
jwt_audience      = "api-pnpg.dev.selfcare.pagopa.it"
jwt_issuer        = "SPID"
jwt_social_expire = "10000000"

configmaps_interop-be-party-process = {
  USER_REGISTRY_MANAGEMENT_URL : "https://api-pnpg.uat.pdv.pagopa.it/user-registry/v1"
  MAIL_ONBOARDING_CONFIRMATION_LINK : "https://dev.selfcare.pagopa.it/onboarding/confirm?jwt="
  MAIL_ONBOARDING_REJECTION_LINK : "https://dev.selfcare.pagopa.it/onboarding/cancel?jwt="
  PRODUCT_MANAGEMENT_URL : "https://api-pnpg.dev.selfcare.pagopa.it/external/v1"
  SELFCARE_ADMIN_NOTIFICATION_URL : "https://dev.selfcare.pagopa.it/dashboard/admin/onboarding/"
  GEO_TAXONOMY_URL : "https://api.pdnd.pagopa.it/geo-tax"
  MAIL_ONBOARDING_URL : "https://dev.selfcare.pagopa.it/onboarding/"
}

configmaps_national_registries = {
  NATIONAL_REGISTRIES_URL = "https://api-selcpg.dev.notifichedigitali.it/national-registries-private"
}

configmaps_ms_core = {
  USER_REGISTRY_MANAGEMENT_URL         = "https://api.uat.pdv.pagopa.it/user-registry/v1"
  MAIL_ONBOARDING_CONFIRMATION_LINK    = "https://dev.selfcare.pagopa.it/onboarding/confirm?jwt="
  MAIL_ONBOARDING_REJECTION_LINK       = "https://dev.selfcare.pagopa.it/onboarding/cancel?jwt="
  PRODUCT_MANAGEMENT_URL               = "https://api-pnpg.dev.selfcare.pagopa.it/external/v1"
  SIGNATURE_VALIDATION_ENABLED         = "false"
  CONFIRM_TOKEN_TIMEOUT                = "90 seconds"
  ONBOARDING_SEND_EMAIL_TO_INSTITUTION = "false"
  SELFCARE_ADMIN_NOTIFICATION_URL      = "https://dev.selfcare.pagopa.it/dashboard/admin/onboarding/"
  GEO_TAXONOMY_URL                     = "https://api.pdnd.pagopa.it/geo-tax"
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
  GEO_TAXONOMIES_URL = "https://api-pnpg.dev.selfcare.pagopa.it/external"
}


terraform_remote_state_core = {
  resource_group_name  = "terraform-state-rg"
  storage_account_name = "tfinfdevselfcare"
  container_name       = "terraform-state"
  key                  = "domain-pnpg-common.terraform.tfstate"
}
