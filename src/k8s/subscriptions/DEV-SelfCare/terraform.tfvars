env       = "dev"
env_short = "d"

# ingress
ingress_replica_count    = "2"
ingress_load_balancer_ip = "10.1.0.250"

# Gateway
api_gateway_url  = "https://api.dev.selfcare.pagopa.it"
cdn_frontend_url = "https://dev.selfcare.pagopa.it"
cdn_storage_url  = "https://selcdcheckoutsa.z6.web.core.windows.net"
spid_testenv_url = "https://selc-d-spid-testenv.westeurope.azurecontainer.io"

# uservice versions
api-version_uservice-attribute-registry-management = "0.1"
api-version_uservice-party-management              = "0.1"
api-version_uservice-party-process                 = "0.1"
api-version_uservice-party-registry-proxy          = "0.1"

# configs/secrets

configmaps_hub-spid-login-ms = {
  APPLICATIONINSIGHTS_ROLE_NAME                     = "hub-spid-login-ms"
  APPLICATIONINSIGHTS_INSTRUMENTATION_LOGGING_LEVEL = "OFF"

  USER_REGISTRY_URL = "https://api.dev.userregistry.pagopa.it/user-registry-management/v1/users"

  # SPID
  ORG_ISSUER = "https://selfcare.pagopa.it"
}

configmaps_ms-product = {
  JAVA_TOOL_OPTIONS                                 = "-javaagent:/applicationinsights-agent.jar"
  APPLICATIONINSIGHTS_ROLE_NAME                     = "ms-product"
  APPLICATIONINSIGHTS_INSTRUMENTATION_LOGGING_LEVEL = "OFF"
}

configmaps_b4f-dashboard = {
  JAVA_TOOL_OPTIONS                                 = "-javaagent:/applicationinsights-agent.jar"
  APPLICATIONINSIGHTS_ROLE_NAME                     = "b4f-dashboard"
  APPLICATIONINSIGHTS_INSTRUMENTATION_LOGGING_LEVEL = "OFF"
}

configmaps_b4f-onboarding = {
  JAVA_TOOL_OPTIONS                                 = "-javaagent:/applicationinsights-agent.jar"
  APPLICATIONINSIGHTS_ROLE_NAME                     = "b4f-onboarding"
  APPLICATIONINSIGHTS_INSTRUMENTATION_LOGGING_LEVEL = "OFF"
}

configmaps_uservice-attribute-registry-management = {
  JAVA_OPTS                                         = "-javaagent:/applicationinsights-agent.jar"
  APPLICATIONINSIGHTS_INSTRUMENTATION_LOGGING_LEVEL = "OFF"
}

configmaps_uservice-party-management = {
  JAVA_OPTS                                         = "-javaagent:/applicationinsights-agent.jar"
  APPLICATIONINSIGHTS_INSTRUMENTATION_LOGGING_LEVEL = "OFF"
}

configmaps_uservice-party-process = {
  JAVA_OPTS                                         = "-javaagent:/applicationinsights-agent.jar"
  APPLICATIONINSIGHTS_INSTRUMENTATION_LOGGING_LEVEL = "OFF"
  USER_REGISTRY_MANAGEMENT_URL                      = "https://api.dev.userregistry.pagopa.it/user-registry-management/v1"
  MAIL_ONBOARDING_CONFIRMATION_LINK                 = "https://dev.selfcare.pagopa.it/onboarding/confirm?jwt="
  MAIL_ONBOARDING_REJECTION_LINK                    = "https://dev.selfcare.pagopa.it/onboarding/cancel?jwt="
}

configmaps_uservice-party-registry-proxy = {
  JAVA_OPTS                                         = "-javaagent:/applicationinsights-agent.jar"
  APPLICATIONINSIGHTS_INSTRUMENTATION_LOGGING_LEVEL = "OFF"
}
