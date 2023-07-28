data "azurerm_key_vault_secret" "alert_error_notification_email" {
  name         = "alert-error-notification-email"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "alert_error_notification_slack" {
  name         = "alert-error-notification-slack"
  key_vault_id = module.key_vault.id
}



# -----------------------------------------------------------------------

resource "azurerm_resource_group" "monitor_rg" {
  name     = "${local.project}-monitor-rg"
  location = var.location

  tags = var.tags
}

resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = "${local.project}-law"
  location            = azurerm_resource_group.monitor_rg.location
  resource_group_name = azurerm_resource_group.monitor_rg.name
  sku                 = var.law_sku
  retention_in_days   = var.law_retention_in_days
  daily_quota_gb      = var.law_daily_quota_gb

  tags = var.tags
}

# Application insights
resource "azurerm_application_insights" "application_insights" {
  name                = "${local.project}-appinsights"
  location            = azurerm_resource_group.monitor_rg.location
  resource_group_name = azurerm_resource_group.monitor_rg.name
  application_type    = "other"

  workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id

  tags = var.tags
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "application_insights_key" {
  name         = "appinsights-instrumentation-key"
  value        = azurerm_application_insights.application_insights.instrumentation_key
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

#
# Actions Groups
#
resource "azurerm_monitor_action_group" "error_action_group" {
  resource_group_name = azurerm_resource_group.monitor_rg.name
  name                = "${var.prefix}${var.env_short}error"
  short_name          = "${var.prefix}${var.env_short}error"

  email_receiver {
    name                    = "email"
    email_address           = data.azurerm_key_vault_secret.alert_error_notification_email.value
    use_common_alert_schema = true
  }

  email_receiver {
    name                    = "slack"
    email_address           = data.azurerm_key_vault_secret.alert_error_notification_slack.value
    use_common_alert_schema = true
  }

  tags = var.tags
}

resource "azurerm_monitor_action_group" "selfcare_status_dev" {
  count = var.env_short == "d" ? 1 : 0

  resource_group_name = azurerm_resource_group.monitor_rg.name
  name                = local.action_group_selfcare_dev_name
  short_name          = local.action_group_selfcare_dev_name

  email_receiver {
    name                    = "email"
    email_address           = module.secrets_selfcare_status_dev[0].values["alert-selfcare-status-dev-email"].value
    use_common_alert_schema = true
  }

  email_receiver {
    name                    = "slack"
    email_address           = module.secrets_selfcare_status_dev[0].values["alert-selfcare-status-dev-slack"].value
    use_common_alert_schema = true
  }

  tags = var.tags
}

resource "azurerm_monitor_action_group" "selfcare_status_uat" {
  count = var.env_short == "u" ? 1 : 0

  resource_group_name = azurerm_resource_group.monitor_rg.name
  name                = local.action_group_selfcare_uat_name
  short_name          = local.action_group_selfcare_uat_name

  email_receiver {
    name                    = "email"
    email_address           = module.secrets_selfcare_status_uat[0].values["alert-selfcare-status-uat-email"].value
    use_common_alert_schema = true
  }

  email_receiver {
    name                    = "slack"
    email_address           = module.secrets_selfcare_status_uat[0].values["alert-selfcare-status-uat-slack"].value
    use_common_alert_schema = true
  }

  tags = var.tags
}

resource "azurerm_monitor_action_group" "email" {
  name                = "PagoPA"
  resource_group_name = azurerm_resource_group.monitor_rg.name
  short_name          = "PagoPA"

  email_receiver {
    name                    = "sendtooperations"
    email_address           = data.azurerm_key_vault_secret.monitor_notification_email.value
    use_common_alert_schema = true
  }

  tags = var.tags
}

resource "azurerm_monitor_action_group" "slack" {
  name                = "SlackPagoPA"
  resource_group_name = azurerm_resource_group.monitor_rg.name
  short_name          = "SlackPagoPA"

  email_receiver {
    name                    = "sendtoslack"
    email_address           = data.azurerm_key_vault_secret.monitor_notification_slack_email.value
    use_common_alert_schema = true
  }

  tags = var.tags
}

#
# Web Test
#
## web availability test
locals {

  test_urls = [
    # https://api.selfcare.pagopa.it/health
    {
      host                 = trimsuffix(azurerm_dns_a_record.dns_a_api.fqdn, "."),
      path                 = "/health",
      expected_http_status = 404
    },
    # https://selfcare.pagopa.it/auth/login
    ## CDN custom domains ##
    {
      host                 = trimsuffix(module.checkout_cdn.fqdn, "."),
      path                 = "/auth/login",
      expected_http_status = 200
    },
    # https://api-pnpg.selfcare.pagopa.it/health
    {
      host                 = trimsuffix(azurerm_dns_a_record.public_api_pnpg.fqdn, "."),
      path                 = "/health",
      expected_http_status = 404
    },
  ]

}

module "web_test_api" {
  for_each = { for v in local.test_urls : v.host => v if v != null }
  source   = "git::https://github.com/pagopa/azurerm.git//application_insights_web_test_preview?ref=v4.17.0"

  subscription_id                   = data.azurerm_subscription.current.subscription_id
  name                              = "${each.value.host}-test"
  location                          = azurerm_resource_group.monitor_rg.location
  resource_group                    = azurerm_resource_group.monitor_rg.name
  application_insight_name          = azurerm_application_insights.application_insights.name
  application_insight_id            = azurerm_application_insights.application_insights.id
  request_url                       = "https://${each.value.host}${each.value.path}"
  ssl_cert_remaining_lifetime_check = 7
  expected_http_status              = each.value.expected_http_status

  actions = [
    {
      action_group_id = azurerm_monitor_action_group.email.id,
    },
    {
      action_group_id = azurerm_monitor_action_group.slack.id,
    },
  ]

}

resource "azurerm_dashboard" "monitoring-dashboard" {
  name                = "${local.project}-monitoring-dashboard"
  resource_group_name = azurerm_resource_group.monitor_rg.name
  location            = azurerm_resource_group.monitor_rg.location
  tags                = var.tags

  dashboard_properties = templatefile("${path.module}/dashboards/monitoring.json.tpl",
    {
      subscription_id = data.azurerm_subscription.current.subscription_id
      prefix          = "${var.prefix}-${var.env_short}"
  })
}
