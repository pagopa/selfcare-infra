prefix         = "selc"
env_short      = "p"
env            = "prod"
domain         = "pnpg"
location       = "westeurope"
location_short = "weu"
instance       = "prod"

dns_zone_prefix = "selfcare"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "CSTAR"
  Source      = "https://github.com/pagopa/selfcare-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
  Application = "PNPG"
}

### External resources

monitor_resource_group_name                 = "selc-p-monitor-rg"
log_analytics_workspace_name                = "selc-p-law"
log_analytics_workspace_resource_group_name = "selc-p-monitor-rg"

