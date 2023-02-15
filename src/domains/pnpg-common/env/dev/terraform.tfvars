prefix         = "selc"
env_short      = "d"
env            = "dev"
domain         = "pnpg"
location       = "westeurope"
location_short = "weu"
instance       = "dev"

dns_zone_prefix = "dev.selfcare"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "CSTAR"
  Source      = "https://github.com/pagopa/selfcare-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
  Application = "PNPG"
}

### External resources

monitor_resource_group_name                 = "selc-d-monitor-rg"
log_analytics_workspace_name                = "selc-d-law"
log_analytics_workspace_resource_group_name = "selc-d-monitor-rg"
