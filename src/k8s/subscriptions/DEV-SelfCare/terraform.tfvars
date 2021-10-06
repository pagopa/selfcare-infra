env       = "dev"
env_short = "d"

# ingress
ingress_replica_count    = "2"
ingress_load_balancer_ip = "10.1.0.250"

# hub-spid-login-ms
configmaps_hub-spid-login-ms = {
  JAVA_TOOL_OPTIONS                                 = "-javaagent:/applicationinsights-agent.jar"
  APPLICATIONINSIGHTS_ROLE_NAME                     = "hub-spid-login-ms"
  APPLICATIONINSIGHTS_INSTRUMENTATION_LOGGING_LEVEL = "OFF"
}