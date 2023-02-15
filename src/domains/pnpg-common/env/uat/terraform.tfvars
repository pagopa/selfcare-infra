prefix         = "cstar"
env_short      = "u"
env            = "uat"
domain         = "pnpg"
location       = "westeurope"
location_short = "weu"
instance       = "uat"

dns_zone_prefix = "uat.cstar"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Uat"
  Owner       = "CSTAR"
  Source      = "https://github.com/pagopa/cstar-infrastructure"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
  Application = "IdPay"
}

terraform_remote_state_core = {
  resource_group_name  = "io-infra-rg"
  storage_account_name = "cstarinfrastterraformuat"
  container_name       = "azurestate"
  key                  = "terraform.tfstate"
}

#
# CIDRs
#
cidr_pnpg_subnet_redis = ["10.1.139.0/24"]

rtd_keyvault = {
  name           = "cstar-u-rtd-kv"
  resource_group = "cstar-u-rtd-sec-rg"
}

cosmos_mongo_db_params = {
  enabled      = true
  capabilities = ["EnableMongo", "EnableServerless"]
  offer_type   = "Standard"
  consistency_policy = {
    consistency_level       = "Strong"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }
  server_version                   = "4.0"
  main_geo_location_zone_redundant = false
  enable_free_tier                 = false

  additional_geo_locations          = []
  private_endpoint_enabled          = false
  public_network_access_enabled     = true
  is_virtual_network_filter_enabled = false

  backup_continuous_enabled = false

}

cosmos_mongo_db_transaction_params = {
  enable_serverless  = true
  enable_autoscaling = true
  max_throughput     = 1000
  throughput         = 1000
}

service_bus_namespace = {
  sku = "Standard"
}

### External resources

monitor_resource_group_name                 = "cstar-u-monitor-rg"
log_analytics_workspace_name                = "cstar-u-law"
log_analytics_workspace_resource_group_name = "cstar-u-monitor-rg"

##Eventhub
ehns_sku_name = "Standard"

eventhubs_pnpg_00 = [
  {
    name              = "pnpg-onboarding-outcome"
    partitions        = 3
    message_retention = 1
    consumers         = ["pnpg-onboarding-outcome-consumer-group", "pnpg-initiative-onboarding-statistics-group"]
    keys = [
      {
        name   = "pnpg-onboarding-outcome-producer"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "pnpg-onboarding-outcome-consumer"
        listen = true
        send   = false
        manage = false
      }
    ]
  },
  {
    name              = "pnpg-onboarding-notification"
    partitions        = 3
    message_retention = 1
    consumers         = ["pnpg-onboarding-notification-consumer-group"]
    keys = [
      {
        name   = "pnpg-onboarding-notification-producer"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "pnpg-onboarding-notification-consumer"
        listen = true
        send   = false
        manage = false
      }
    ]
  },
  {
    name              = "pnpg-checkiban-evaluation"
    partitions        = 3
    message_retention = 1
    consumers         = ["pnpg-checkiban-evaluation-consumer-group", "pnpg-rewards-notification-checkiban-req-group"]
    keys = [
      {
        name   = "pnpg-checkiban-evaluation-producer"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "pnpg-checkiban-evaluation-consumer"
        listen = true
        send   = false
        manage = false
      }
    ]
  },
  {
    name              = "pnpg-checkiban-outcome"
    partitions        = 3
    message_retention = 1
    consumers         = ["pnpg-checkiban-outcome-consumer-group", "pnpg-rewards-notification-checkiban-out-group"]
    keys = [
      {
        name   = "pnpg-checkiban-outcome-producer"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "pnpg-checkiban-outcome-consumer"
        listen = true
        send   = false
        manage = false
      }
    ]
  },
  {
    name              = "pnpg-timeline"
    partitions        = 3
    message_retention = 1
    consumers         = ["pnpg-timeline-consumer-group"]
    keys = [
      {
        name   = "pnpg-timeline-producer"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "pnpg-timeline-consumer"
        listen = true
        send   = false
        manage = false
      }
    ]
  },
  {
    name              = "pnpg-notification-request"
    partitions        = 3
    message_retention = 1
    consumers         = ["pnpg-notification-request-group"]
    keys = [
      {
        name   = "pnpg-notification-request-producer"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "pnpg-notification-request-consumer"
        listen = true
        send   = false
        manage = false
      }
    ]
  },
  {
    name              = "pnpg-onboarding-ranking-request"
    partitions        = 3
    message_retention = 1
    consumers         = ["pnpg-onboarding-ranking-request-consumer-group"]
    keys = [
      {
        name   = "pnpg-onboarding-ranking-request-producer"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "pnpg-onboarding-ranking-request-consumer"
        listen = true
        send   = false
        manage = false
      }
    ]
  },
]


eventhubs_pnpg_01 = [
  {
    name              = "pnpg-transaction"
    partitions        = 3
    message_retention = 1
    consumers         = ["pnpg-transaction-consumer-group", "pnpg-transaction-wallet-consumer-group", "pnpg-rewards-notification-transaction-group", "pnpg-initiative-rewards-statistics-group"]
    keys = [
      {
        name   = "pnpg-transaction-producer"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "pnpg-transaction-consumer"
        listen = true
        send   = false
        manage = false
      }
    ]
  },
  {
    name              = "pnpg-rule-update"
    partitions        = 3
    message_retention = 1
    consumers         = ["pnpg-beneficiary-rule-update-consumer-group", "pnpg-reward-calculator-rule-consumer-group", "pnpg-rewards-notification-rule-consumer-group"]
    keys = [
      {
        name   = "pnpg-rule-update-producer"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "pnpg-rule-update-consumer"
        listen = true
        send   = false
        manage = false
      }
    ]
  },
  {
    name              = "pnpg-hpan-update"
    partitions        = 3
    message_retention = 1
    consumers         = ["pnpg-reward-calculator-hpan-update-consumer-group"]
    keys = [
      {
        name   = "pnpg-hpan-update-producer"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "pnpg-hpan-update-consumer"
        listen = true
        send   = false
        manage = false
      }
    ]
  },
  {
    name              = "pnpg-hpan-update-outcome"
    partitions        = 3
    message_retention = 1
    consumers         = ["pnpg-hpan-update-outcome-consumer-group"]
    keys = [
      {
        name   = "pnpg-hpan-update-outcome-producer"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "pnpg-hpan-update-outcome-consumer"
        listen = true
        send   = false
        manage = false
      }
    ]
  },
  {
    name              = "pnpg-transaction-user-id-splitter"
    partitions        = 3
    message_retention = 1
    consumers         = ["pnpg-reward-calculator-consumer-group"]
    keys = [
      {
        name   = "pnpg-transaction-user-id-splitter-producer"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "pnpg-transaction-user-id-splitter-consumer"
        listen = true
        send   = false
        manage = false
      }
    ]
  },
  {
    name              = "pnpg-errors"
    partitions        = 3
    message_retention = 1
    consumers         = ["pnpg-errors-recovery-group"]
    keys = [
      {
        name   = "pnpg-errors-producer"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "pnpg-errors-consumer"
        listen = true
        send   = false
        manage = false
      }
    ]
  },
  {
    name              = "pnpg-reward-notification-storage-events"
    partitions        = 3
    message_retention = 1
    consumers         = ["pnpg-reward-notification-storage-group"]
    keys = [
      {
        name   = "pnpg-reward-notification-storage-producer"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "pnpg-reward-notification-storage-consumer"
        listen = true
        send   = false
        manage = false
      }
    ]
  },
  {
    name              = "pnpg-reward-notification-response"
    partitions        = 3
    message_retention = 1
    consumers         = ["pnpg-reward-notification-response-group"]
    keys = [
      {
        name   = "pnpg-reward-notification-response-producer"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "pnpg-reward-notification-response-consumer"
        listen = true
        send   = false
        manage = false
      }
    ]
  },
]

### handle resource enable
enable = {
  pnpg = {
    eventhub_pnpg_00 = true
  }
}
