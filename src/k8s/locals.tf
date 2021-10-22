locals {
  project                         = format("%s-%s", var.prefix, var.env_short)
  key_vault_name                  = format("%s-kv", local.project)
  key_vault_resource_group        = format("%s-sec-rg", local.project)
  key_vault_id                    = "${data.azurerm_subscription.current.id}/resourceGroups/${local.key_vault_resource_group}/providers/Microsoft.KeyVault/vaults/${local.key_vault_name}"
  redis_url                       = "${format("%s-redis", local.project)}.redis.cache.windows.net"
  appinsights_instrumentation_key = format("InstrumentationKey=%s", module.key_vault_secrets_query.values["appinsights-instrumentation-key"].value)
}
