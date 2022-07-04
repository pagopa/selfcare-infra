env       = "uat"
env_short = "u"

# ingress
ingress_replica_count    = "2"
ingress_load_balancer_ip = "10.1.1.250"

# Gateway
api_gateway_url  = "https://api.uat.selfcare.pagopa.it"
cdn_frontend_url = "https://uat.selfcare.pagopa.it"
cdn_storage_url  = "https://selcucheckoutsa.z6.web.core.windows.net"
spid_testenv_url = "https://selc-u-spid-testenv.westeurope.azurecontainer.io"

# uservice versions
api-version_uservice-party-management     = "0.1"
api-version_uservice-party-process        = "0.1"
api-version_uservice-party-registry-proxy = "0.1"

# session jwt audience
jwt_audience = "api.uat.selfcare.pagopa.it"

# configs/secrets

configmaps_hub-spid-login-ms = {
  APPLICATIONINSIGHTS_ROLE_NAME                     = "hub-spid-login-ms"
  APPLICATIONINSIGHTS_INSTRUMENTATION_LOGGING_LEVEL = "OFF"

  USER_REGISTRY_URL = "https://api.uat.pdv.pagopa.it/user-registry/v1"

  # SPID
  ORG_ISSUER = "https://selfcare.pagopa.it"
}

configmaps_common = {
  USERVICE_USER_REGISTRY_URL             = "https://api.uat.pdv.pagopa.it/user-registry/v1"
  ENABLE_CONFIDENTIAL_FILTER             = "TRUE"
  ENABLE_SINGLE_LINE_STACK_TRACE_LOGGING = "true"
}
