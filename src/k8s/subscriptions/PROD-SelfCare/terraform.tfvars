env       = "prod"
env_short = "p"

# ingress
ingress_replica_count    = "2"
ingress_load_balancer_ip = "10.1.0.250"

# Gateway
api_gateway_url  = "https://api.selfcare.pagopa.it"
cdn_frontend_url = "https://selfcare.pagopa.it"
cdn_storage_url  = "https://selcpcheckoutsa.z6.web.core.windows.net"

# uservice versions
api-version_uservice-party-management     = "0.1"
api-version_uservice-party-process        = "0.1"
api-version_uservice-party-registry-proxy = "0.1"

# session jwt audience
jwt_audience = "https://api.selfcare.pagopa.it"

# configs/secrets

configmaps_hub-spid-login-ms = {
  APPLICATIONINSIGHTS_ROLE_NAME                     = "hub-spid-login-ms"
  APPLICATIONINSIGHTS_INSTRUMENTATION_LOGGING_LEVEL = "OFF"

  USER_REGISTRY_URL = "https://api.userregistry.pagopa.it/user-registry-management/v1"

  # SPID
  ORG_ISSUER = "https://selfcare.pagopa.it"
}

configmaps_uservice-attribute-registry-management = {
  JAVA_OPTS                                         = "-javaagent:/applicationinsights-agent.jar"
  APPLICATIONINSIGHTS_INSTRUMENTATION_LOGGING_LEVEL = "OFF"
}

configmaps_uservice-party-process = {
  JAVA_OPTS                                         = "-javaagent:/applicationinsights-agent.jar"
  APPLICATIONINSIGHTS_INSTRUMENTATION_LOGGING_LEVEL = "OFF"
  USER_REGISTRY_MANAGEMENT_URL                      = "https://api.userregistry.pagopa.it/user-registry-management/v1"
  MAIL_ONBOARDING_CONFIRMATION_LINK                 = "https://selfcare.pagopa.it/onboarding/confirm?jwt="
  MAIL_ONBOARDING_REJECTION_LINK                    = "https://selfcare.pagopa.it/onboarding/cancel?jwt="
  SIGNATURE_VALIDATION_ENABLED                      = true
}

configmaps_uservice-party-registry-proxy = {
  JAVA_OPTS                                         = "-javaagent:/applicationinsights-agent.jar"
  APPLICATIONINSIGHTS_INSTRUMENTATION_LOGGING_LEVEL = "OFF"
}

configmaps_common = {
  USERVICE_USER_REGISTRY_URL = "https://api.userregistry.pagopa.it/user-registry-management/v1"
  ENABLE_CONFIDENTIAL_FILTER = "TRUE"
}
