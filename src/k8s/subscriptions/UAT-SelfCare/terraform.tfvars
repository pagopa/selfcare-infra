env       = "uat"
env_short = "u"

# ingress
ingress_replica_count    = "2"
ingress_load_balancer_ip = "10.1.0.250"

# Gateway
api_gateway_url  = "https://api.uat.selfcare.pagopa.it"
cdn_frontend_url = "https://uat.selfcare.pagopa.it"


# hub-spid-login-ms
configmaps_hub-spid-login-ms = {
  APPLICATIONINSIGHTS_ROLE_NAME                     = "hub-spid-login-ms"
  APPLICATIONINSIGHTS_INSTRUMENTATION_LOGGING_LEVEL = "OFF"

  # SPID
  ORG_ISSUER = "https://uat.selfcare.pagopa.it" # TODO to verify
}
