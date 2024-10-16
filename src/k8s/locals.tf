locals {
  project                            = format("%s-%s", var.prefix, var.env_short)
  key_vault_name                     = format("%s-kv", local.project)
  key_vault_resource_group           = format("%s-sec-rg", local.project)
  key_vault_id                       = "${data.azurerm_subscription.current.id}/resourceGroups/${local.key_vault_resource_group}/providers/Microsoft.KeyVault/vaults/${local.key_vault_name}"
  redis_url                          = "${format("%s-redis", local.project)}.redis.cache.windows.net"
  mongodb_name_selc_core             = "selcMsCore"
  mongodb_name_selc_user_group       = "selcUserGroup"
  contracts_storage_account_name     = replace(format("%s-contracts-storage", local.project), "-", "")
  contracts_storage_container        = format("%s-contracts-blob", local.project)
  appinsights_instrumentation_key    = format("InstrumentationKey=%s", module.key_vault_secrets_query.values["appinsights-instrumentation-key"].value)
  monitor_action_group_slack_name    = "SlackPagoPA"
  monitor_action_group_email_name    = "PagoPA"
  monitor_action_group_opsgenie_name = "Opsgenie"
  aks_cluster_name                   = var.aks_name
  monitor_appinsights_name           = "${local.project}-appinsights"
}
