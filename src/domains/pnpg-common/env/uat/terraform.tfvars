prefix         = "selc"
env_short      = "u"
env            = "uat"
domain         = "pnpg"
location       = "westeurope"
location_short = "weu"
instance       = "uat"

dns_zone_prefix = "uat.selfcare"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Uat"
  Owner       = "CSTAR"
  Source      = "https://github.com/pagopa/selfcare-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
  Application = "PNPG"
}

### External resources

monitor_resource_group_name                 = "selc-u-monitor-rg"
log_analytics_workspace_name                = "selc-u-law"
log_analytics_workspace_resource_group_name = "selc-u-monitor-rg"
