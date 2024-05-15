data "azurerm_resource_group" "monitor_rg" {
  name = var.monitor_resource_group_name
}

data "azurerm_log_analytics_workspace" "log_analytics" {
  name                = var.log_analytics_workspace_name
  resource_group_name = var.log_analytics_workspace_resource_group_name
}

data "azurerm_application_insights" "application_insights" {
  name                = local.monitor_appinsights_name
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
}

#
# Action
#
data "azurerm_monitor_action_group" "slack" {
  resource_group_name = var.monitor_resource_group_name
  name                = local.monitor_action_group_slack_name
}

data "azurerm_monitor_action_group" "email" {
  resource_group_name = var.monitor_resource_group_name
  name                = local.monitor_action_group_email_name
}

resource "azurerm_monitor_action_group" "http_status" {
  count = var.env_short == "d" ? 0 : 1

  resource_group_name = data.azurerm_resource_group.monitor_rg.name
  name                = "HttpStatus-${var.env_short}"
  short_name          = "HttpStatus-${var.env_short}"

  email_receiver {
    name                    = "slack"
    email_address           = module.key_vault_secrets_query.values["alert-pnpg-http-status-slack"].value
    use_common_alert_schema = true
  }

  tags = var.tags
}

resource "azurerm_monitor_metric_alert" "http_error_5xx" {
  count = var.env_short == "d" ? 0 : 1

  name                = "http-error-5xx"
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
  scopes              = [data.azurerm_application_insights.application_insights.id]
  description         = "Action will be triggered when Request with http 5xx status happens."
  auto_mitigate       = false

  criteria {
    metric_namespace = "Microsoft.Insights/Components"
    metric_name      = "requests/failed"
    aggregation      = "Count"
    operator         = "GreaterThan"
    threshold        = 0

    dimension {
      name     = "request/resultCode"
      operator = "Include"
      values   = ["500", "501", "502"]
    }
  }

  action {
    action_group_id = azurerm_monitor_action_group.http_status[0].id
  }
}

resource "azurerm_monitor_metric_alert" "unhealthy_error_503" {
  count = var.env_short == "d" ? 0 : 1

  name                = "unhealthy-error-503"
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
  scopes              = [data.azurerm_application_insights.application_insights.id]
  description         = "Action will be triggered when a resource fails health check returning 503 error."
  auto_mitigate       = false

  criteria {
    metric_namespace = "Microsoft.Insights/Components"
    metric_name      = "requests/failed"
    aggregation      = "Count"
    operator         = "GreaterThan"
    threshold        = 5

    dimension {
      name     = "request/resultCode"
      operator = "Include"
      values   = ["503"]
    }
  }

  action {
    action_group_id = azurerm_monitor_action_group.http_status[0].id
  }
}

resource "azurerm_monitor_metric_alert" "functions_exceptions" {
  count = var.env_short == "d" ? 0 : 1

  name                = local.alert_functions_exceptions_name
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
  scopes              = [data.azurerm_application_insights.application_insights.id]
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
    action_group_id = azurerm_monitor_action_group.http_status[0].id
  }
}
