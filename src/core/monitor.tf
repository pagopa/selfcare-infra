data "azurerm_key_vault_secret" "alert_error_notification_email" {
  name         = "alert-error-notification-email"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "alert_error_notification_slack" {
  name         = "alert-error-notification-slack"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "monitor_notification_opsgenie" {
  name         = "monitor-notification-opsgenie"
  key_vault_id = module.key_vault.id
}

# -----------------------------------------------------------------------
resource "azurerm_resource_group" "dashboards" {
  name     = "dashboards"
  location = var.location
  tags     = var.tags
}

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

  lifecycle {
    ignore_changes = [
      sku
    ]
  }
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
  count = var.env_short == "p" ? 1 : 0

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

  webhook_receiver {
    name                    = "opsgenie"
    service_uri             = data.azurerm_key_vault_secret.monitor_notification_opsgenie.value
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

  test_urls_map = {
    # https://api.selfcare.pagopa.it/health
    "apigw-selfcare" = {
      host                              = trimsuffix(azurerm_dns_a_record.dns_a_api.fqdn, "."),
      path                              = "/external/status",
      frequency                         = 300
      expected_http_status              = 200
      ssl_cert_remaining_lifetime_check = 7
      opsgenie                          = true
    },
    # https://api-pnpg.selfcare.pagopa.it/health
    "apigw-pnpg-selfcare" = {
      host                              = trimsuffix(azurerm_dns_a_record.public_api_pnpg.fqdn, "."),
      path                              = "/external/status",
      frequency                         = 300,
      expected_http_status              = 200,
      ssl_cert_remaining_lifetime_check = 7,
      opsgenie                          = true
    },
    ## CDN custom domains ##
    # https://selfcare.pagopa.it/auth/login
    "login-selfcare" = {
      host                              = trimsuffix(module.checkout_cdn.fqdn, "."),
      path                              = "/auth/login",
      frequency                         = 900,
      expected_http_status              = 200,
      ssl_cert_remaining_lifetime_check = 7,
      opsgenie                          = true
    },
    "login-pnpg" = {
      host                              = "imprese.notifichedigitali.it",
      path                              = "/auth/login",
      frequency                         = 900,
      expected_http_status              = 200,
      ssl_cert_remaining_lifetime_check = 7,
      opsgenie                          = true
    },
    "Spid-registry" = {
      host                              = "registry.spid.gov.it",
      path                              = "/metadata/idp/spid-entities-idps.xml",
      frequency                         = 900,
      expected_http_status              = 200,
      ssl_cert_remaining_lifetime_check = 1,
      opsgenie                          = false
    },
    "CIE-selc" = {
      # CIE https://app-backend.io.italia.it/login?authLevel=SpidL2&entityID=xx_servizicie
      host                              = trimsuffix(azurerm_dns_a_record.dns_a_api.fqdn, "."),
      path                              = "/spid-login/v1/login?authLevel=SpidL2&entityID=xx_servizicie",
      frequency                         = 900
      expected_http_status              = 200,
      ssl_cert_remaining_lifetime_check = 1,
      opsgenie                          = false
    },
    "SpidL2-arubaid-selc" = {
      # SpidL2-arubaid https://app-backend.io.italia.it/login?authLevel=SpidL2&entityID=arubaid
      host                              = trimsuffix(azurerm_dns_a_record.dns_a_api.fqdn, "."),
      path                              = "/spid-login/v1/login?authLevel=SpidL2&entityID=arubaid",
      frequency                         = 900
      expected_http_status              = 200,
      ssl_cert_remaining_lifetime_check = 1,
      opsgenie                          = false
    },
    "SpidL2-infocertid-selc" = {
      # SpidL2-infocertid https://app-backend.io.italia.it/login?authLevel=SpidL2&entityID=infocertid
      host                              = trimsuffix(azurerm_dns_a_record.dns_a_api.fqdn, "."),
      path                              = "/spid-login/v1/login?authLevel=SpidL2&entityID=infocertid",
      frequency                         = 900
      expected_http_status              = 200,
      ssl_cert_remaining_lifetime_check = 1,
      opsgenie                          = false
    },
    "SpidL2-lepidaid-selc" = {
      # SpidL2-lepidaid https://app-backend.io.italia.it/login?authLevel=SpidL2&entityID=lepidaid
      host                              = trimsuffix(azurerm_dns_a_record.dns_a_api.fqdn, "."),
      path                              = "/spid-login/v1/login?authLevel=SpidL2&entityID=lepidaid",
      frequency                         = 900
      expected_http_status              = 200,
      ssl_cert_remaining_lifetime_check = 1,
      opsgenie                          = false
    },
    "SpidL2-namirialid-selc" = {
      # SpidL2-namirialid https://app-backend.io.italia.it/login?authLevel=SpidL2&entityID=namirialid
      host                              = trimsuffix(azurerm_dns_a_record.dns_a_api.fqdn, "."),
      path                              = "/spid-login/v1/login?authLevel=SpidL2&entityID=namirialid",
      frequency                         = 900
      expected_http_status              = 200,
      ssl_cert_remaining_lifetime_check = 1,
      opsgenie                          = false
    },
    "SpidL2-posteid-selc" = {
      # SpidL2-posteid https://app-backend.io.italia.it/login?authLevel=SpidL2&entityID=posteid
      host                              = trimsuffix(azurerm_dns_a_record.dns_a_api.fqdn, "."),
      path                              = "/spid-login/v1/login?authLevel=SpidL2&entityID=posteid",
      frequency                         = 900
      expected_http_status              = 200,
      ssl_cert_remaining_lifetime_check = 1,
      opsgenie                          = false
    },
    "SpidL2-sielteid-selc" = {
      # SpidL2-sielteid https://app-backend.io.italia.it/login?authLevel=SpidL2&entityID=sielteid
      host                              = trimsuffix(azurerm_dns_a_record.dns_a_api.fqdn, "."),
      path                              = "/spid-login/v1/login?authLevel=SpidL2&entityID=sielteid",
      frequency                         = 900
      expected_http_status              = 200,
      ssl_cert_remaining_lifetime_check = 1,
      opsgenie                          = false
    },
    "SpidL2-spiditalia-selc" = {
      # SpidL2-spiditalia https://app-backend.io.italia.it/login?authLevel=SpidL2&entityID=spiditalia
      host                              = trimsuffix(azurerm_dns_a_record.dns_a_api.fqdn, "."),
      path                              = "/spid-login/v1/login?authLevel=SpidL2&entityID=spiditalia",
      frequency                         = 900
      expected_http_status              = 200,
      ssl_cert_remaining_lifetime_check = 1,
      opsgenie                          = false
    },
    "SpidL2-etna-selc" = {
      # SpidL2-etna https://app-backend.io.italia.it/login?authLevel=SpidL2&entityID=ehtid
      name                              = "SpidL2-etna",
      host                              = trimsuffix(azurerm_dns_a_record.dns_a_api.fqdn, "."),
      path                              = "/spid-login/v1/login?authLevel=SpidL2&entityID=ehtid",
      frequency                         = 900
      expected_http_status              = 200,
      ssl_cert_remaining_lifetime_check = 1,
      opsgenie                          = false
    },
    "SpidL2-infocamere-selc" = {
      # SpidL2-infocamere https://app-backend.io.italia.it/login?authLevel=SpidL2&entityID=infocamereid
      host                              = trimsuffix(azurerm_dns_a_record.dns_a_api.fqdn, "."),
      path                              = "/spid-login/v1/login?authLevel=SpidL2&entityID=infocamereid",
      frequency                         = 900
      expected_http_status              = 200,
      ssl_cert_remaining_lifetime_check = 1,
      opsgenie                          = false
    },
    "SpidL2-intesiid-selc" = {
      # SpidL2-infocamere https://app-backend.io.italia.it/login?authLevel=SpidL2&entityID=intesiid
      host                              = trimsuffix(azurerm_dns_a_record.dns_a_api.fqdn, "."),
      path                              = "/spid-login/v1/login?authLevel=SpidL2&entityID=intesiid",
      frequency                         = 900
      expected_http_status              = 200,
      ssl_cert_remaining_lifetime_check = 1,
      opsgenie                          = false
    },
    "SpidL2-timid-selc" = {
      # SpidL2-infocamere https://app-backend.io.italia.it/login?authLevel=SpidL2&entityID=timid
      host                              = trimsuffix(azurerm_dns_a_record.dns_a_api.fqdn, "."),
      path                              = "/spid-login/v1/login?authLevel=SpidL2&entityID=timid",
      frequency                         = 900
      expected_http_status              = 200,
      ssl_cert_remaining_lifetime_check = 1,
      opsgenie                          = false
    },
    "SpidL2-teamsystemid-selc" = {
      # SpidL2-infocamere https://app-backend.io.italia.it/login?authLevel=SpidL2&entityID=teamsystemid
      host                              = trimsuffix(azurerm_dns_a_record.dns_a_api.fqdn, "."),
      path                              = "/spid-login/v1/login?authLevel=SpidL2&entityID=teamsystemid",
      frequency                         = 900
      expected_http_status              = 200,
      ssl_cert_remaining_lifetime_check = 1,
      opsgenie                          = false
    },
    "CIE-pnpg" = {
      # CIE https://app-backend.io.italia.it/login?authLevel=SpidL2&entityID=xx_servizicie
      host                              = trimsuffix(azurerm_dns_a_record.public_api_pnpg.fqdn, "."),
      path                              = "/spid/v1/login?authLevel=SpidL2&entityID=xx_servizicie",
      frequency                         = 900
      expected_http_status              = 200,
      ssl_cert_remaining_lifetime_check = 1,
      opsgenie                          = false
    },
    "SpidL2-arubaid-pnpg" = {
      # SpidL2-arubaid https://app-backend.io.italia.it/login?authLevel=SpidL2&entityID=arubaid
      host                              = trimsuffix(azurerm_dns_a_record.public_api_pnpg.fqdn, "."),
      path                              = "/spid/v1/login?authLevel=SpidL2&entityID=arubaid",
      frequency                         = 900
      expected_http_status              = 200,
      ssl_cert_remaining_lifetime_check = 1,
      opsgenie                          = false
    },
    "SpidL2-infocertid-pnpg" = {
      # SpidL2-infocertid https://app-backend.io.italia.it/login?authLevel=SpidL2&entityID=infocertid
      host                              = trimsuffix(azurerm_dns_a_record.public_api_pnpg.fqdn, "."),
      path                              = "/spid/v1/login?authLevel=SpidL2&entityID=infocertid",
      frequency                         = 900
      expected_http_status              = 200,
      ssl_cert_remaining_lifetime_check = 1,
      opsgenie                          = false
    },
    "SpidL2-lepidaid-pnpg" = {
      # SpidL2-lepidaid https://app-backend.io.italia.it/login?authLevel=SpidL2&entityID=lepidaid
      host                              = trimsuffix(azurerm_dns_a_record.public_api_pnpg.fqdn, "."),
      path                              = "/spid/v1/login?authLevel=SpidL2&entityID=lepidaid",
      frequency                         = 900
      expected_http_status              = 200,
      ssl_cert_remaining_lifetime_check = 1,
      opsgenie                          = false
    },
    "SpidL2-namirialid-pnpg" = {
      # SpidL2-namirialid https://app-backend.io.italia.it/login?authLevel=SpidL2&entityID=namirialid
      host                              = trimsuffix(azurerm_dns_a_record.public_api_pnpg.fqdn, "."),
      path                              = "/spid/v1/login?authLevel=SpidL2&entityID=namirialid",
      frequency                         = 900
      expected_http_status              = 200,
      ssl_cert_remaining_lifetime_check = 1,
      opsgenie                          = false
    },
    "SpidL2-posteid-pnpg" = {
      # SpidL2-posteid https://app-backend.io.italia.it/login?authLevel=SpidL2&entityID=posteid
      host                              = trimsuffix(azurerm_dns_a_record.public_api_pnpg.fqdn, "."),
      path                              = "/spid/v1/login?authLevel=SpidL2&entityID=posteid",
      frequency                         = 900
      expected_http_status              = 200,
      ssl_cert_remaining_lifetime_check = 1,
      opsgenie                          = false
    },
    "SpidL2-sielteid-pnpg" = {
      # SpidL2-sielteid https://app-backend.io.italia.it/login?authLevel=SpidL2&entityID=sielteid
      host                              = trimsuffix(azurerm_dns_a_record.public_api_pnpg.fqdn, "."),
      path                              = "/spid/v1/login?authLevel=SpidL2&entityID=sielteid",
      frequency                         = 900
      expected_http_status              = 200,
      ssl_cert_remaining_lifetime_check = 1,
      opsgenie                          = false
    },
    "SpidL2-spiditalia-pnpg" = {
      # SpidL2-spiditalia https://app-backend.io.italia.it/login?authLevel=SpidL2&entityID=spiditalia
      host                              = trimsuffix(azurerm_dns_a_record.public_api_pnpg.fqdn, "."),
      path                              = "/spid/v1/login?authLevel=SpidL2&entityID=spiditalia",
      frequency                         = 900
      expected_http_status              = 200,
      ssl_cert_remaining_lifetime_check = 1,
      opsgenie                          = false
    },
    "SpidL2-etna-pnpg" = {
      # SpidL2-etna https://app-backend.io.italia.it/login?authLevel=SpidL2&entityID=ehtid
      name                              = "SpidL2-etna",
      host                              = trimsuffix(azurerm_dns_a_record.public_api_pnpg.fqdn, "."),
      path                              = "/login?authLevel=SpidL2&entityID=ehtid",
      frequency                         = 900
      expected_http_status              = 200,
      ssl_cert_remaining_lifetime_check = 1,
      opsgenie                          = false
    },
    "SpidL2-infocamere-pnpg" = {
      # SpidL2-infocamere https://app-backend.io.italia.it/login?authLevel=SpidL2&entityID=infocamereid
      host                              = trimsuffix(azurerm_dns_a_record.public_api_pnpg.fqdn, "."),
      path                              = "/spid/v1/login?authLevel=SpidL2&entityID=infocamereid",
      frequency                         = 900
      expected_http_status              = 200,
      ssl_cert_remaining_lifetime_check = 1,
      opsgenie                          = false
    },
    "SpidL2-intesiid-pnpg" = {
      # SpidL2-infocamere https://app-backend.io.italia.it/login?authLevel=SpidL2&entityID=intesiid
      host                              = trimsuffix(azurerm_dns_a_record.dns_a_api.fqdn, "."),
      path                              = "/spid/v1/login?authLevel=SpidL2&entityID=intesiid",
      frequency                         = 900
      expected_http_status              = 200,
      ssl_cert_remaining_lifetime_check = 1,
      opsgenie                          = false
    },
    "SpidL2-timid-pnpg" = {
      # SpidL2-infocamere https://app-backend.io.italia.it/login?authLevel=SpidL2&entityID=timid
      host                              = trimsuffix(azurerm_dns_a_record.dns_a_api.fqdn, "."),
      path                              = "/spid/v1/login?authLevel=SpidL2&entityID=timid",
      frequency                         = 900
      expected_http_status              = 200,
      ssl_cert_remaining_lifetime_check = 1,
      opsgenie                          = false
    },
    "SpidL2-teamsystemid-pnpg" = {
      # SpidL2-infocamere https://app-backend.io.italia.it/login?authLevel=SpidL2&entityID=teamsystemid
      host                              = trimsuffix(azurerm_dns_a_record.dns_a_api.fqdn, "."),
      path                              = "/spid/v1/login?authLevel=SpidL2&entityID=teamsystemid",
      frequency                         = 900
      expected_http_status              = 200,
      ssl_cert_remaining_lifetime_check = 1,
      opsgenie                          = false
    },
  }

  test_urls_map_internal = {
    # https://api.selfcare.pagopa.it/external/status
    "apigw-selfcare" = {
      host                              = trimsuffix(azurerm_dns_a_record.dns_a_api.fqdn, "."),
      path                              = "/external/status",
      frequency                         = 900,
      expected_http_status              = 200,
      ssl_cert_remaining_lifetime_check = 7,
      opsgenie                          = false
    },
    # https://api-pnpg.selfcare.pagopa.it/external/status
    "apigw-pnpg-selfcare" = {
      host                              = trimsuffix(azurerm_dns_a_record.public_api_pnpg.fqdn, "."),
      path                              = "/external/status",
      frequency                         = 900,
      expected_http_status              = 200,
      ssl_cert_remaining_lifetime_check = 7,
      opsgenie                          = false
    },
    ## CDN custom domains ##
    # https://selfcare.pagopa.it/auth/login
    "login-selfcare" = {
      host                              = trimsuffix(module.checkout_cdn.fqdn, "."),
      path                              = "/auth/login",
      frequency                         = 900,
      expected_http_status              = 200,
      ssl_cert_remaining_lifetime_check = 7,
      opsgenie                          = false
    },
    "TestEnv-selfcare" = {
      host                              = trimsuffix(azurerm_dns_a_record.dns_a_api.fqdn, "."),
      path                              = "/spid-login/v1/login?entityID=xx_testenv2&authLevel=SpidL2",
      frequency                         = 900,
      expected_http_status              = 308,
      ssl_cert_remaining_lifetime_check = 7,
      opsgenie                          = false
    },
    "TestEnv-pnpg" = {
      host                              = trimsuffix(azurerm_dns_a_record.public_api_pnpg.fqdn, "."),
      path                              = "/spid/v1/login?entityID=xx_testenv2&authLevel=SpidL2",
      frequency                         = 900,
      expected_http_status              = 308,
      ssl_cert_remaining_lifetime_check = 7,
      opsgenie                          = false
    }
  }
}

module "web_test_api" {
  ###??? TBFIX
  for_each = var.env_short == "p" ? local.test_urls_map : local.test_urls_map_internal
  # for_each = { for v in local.test_urls : v.host => v if v != null }

  source = "github.com/pagopa/terraform-azurerm-v3.git//application_insights_web_test_preview?ref=v7.50.1"

  subscription_id                   = data.azurerm_subscription.current.subscription_id
  name                              = "${each.key}-test"
  location                          = azurerm_resource_group.monitor_rg.location
  resource_group                    = azurerm_resource_group.monitor_rg.name
  application_insight_name          = azurerm_application_insights.application_insights.name
  application_insight_id            = azurerm_application_insights.application_insights.id
  request_url                       = "https://${each.value.host}${each.value.path}"
  ssl_cert_remaining_lifetime_check = each.value.ssl_cert_remaining_lifetime_check
  expected_http_status              = each.value.expected_http_status
  frequency                         = each.value.frequency
  alert_description                 = "Web availability check alert triggered when it fails. Runbook: https://pagopa.atlassian.net/wiki/spaces/SCP/pages/823722319/Web+Availability+Test+-+TLS+Probe+Check"

  actions = var.env_short == "p" && each.value.opsgenie ? [
    {
      action_group_id    = azurerm_monitor_action_group.error_action_group[0].id
      webhook_properties = null
    }
    ] : [
    {
      action_group_id    = azurerm_monitor_action_group.slack.id
      webhook_properties = null
    },
    {
      action_group_id    = azurerm_monitor_action_group.email.id
      webhook_properties = null
    }
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



resource "azurerm_monitor_metric_alert" "functions_exceptions" {
  count = var.env_short == "d" ? 0 : 1

  name                = local.alert_functions_exceptions_name
  resource_group_name = azurerm_resource_group.monitor_rg.name
  scopes              = [azurerm_application_insights.application_insights.id]
  description         = "Action will be triggered when Functions throw some exceptions."
  auto_mitigate       = false

  criteria {
    metric_namespace = "Microsoft.Insights/Components"
    metric_name      = "exceptions/count"
    aggregation      = "Count"
    operator         = "GreaterThan"
    threshold        = 2

    dimension {
      name     = "cloud/roleName"
      operator = "Include"
      values   = local.alert_functions_exceptions_role_names
    }
  }

  action {
    action_group_id = azurerm_monitor_action_group.slack.id
  }
}
