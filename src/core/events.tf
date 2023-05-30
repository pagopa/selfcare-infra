resource "azurerm_resource_group" "event_rg" {
  name     = "${local.project}-event-rg"
  location = var.location

  tags = var.tags
}

module "eventhub_snet" {
  source                                         = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v6.14.0"
  name                                           = "${local.project}-eventhub-snet"
  address_prefixes                               = var.cidr_subnet_eventhub
  resource_group_name                            = azurerm_resource_group.rg_vnet.name
  virtual_network_name                           = module.vnet.name
  service_endpoints                              = ["Microsoft.EventHub"]
  enforce_private_link_endpoint_network_policies = true
}

module "event_hub" {
  source                   = "git::https://github.com/pagopa/terraform-azurerm-v3.git//eventhub?ref=v6.14.0"
  name                     = "${local.project}-eventhub-ns"
  location                 = var.location
  resource_group_name      = azurerm_resource_group.event_rg.name
  auto_inflate_enabled     = var.eventhub_auto_inflate_enabled
  sku                      = var.eventhub_sku_name
  capacity                 = var.eventhub_capacity
  maximum_throughput_units = var.eventhub_maximum_throughput_units
  zone_redundant           = var.eventhub_zone_redundant

  virtual_network_ids = [module.vnet.id]
  subnet_id           = module.eventhub_snet.id

  private_dns_zone_record_A_name = null

  eventhubs = var.eventhubs

  network_rulesets = [
    {
      default_action       = "Deny",
      virtual_network_rule = [],
      ip_rule              = var.eventhub_ip_rules
    }
  ]

  private_dns_zones = {
    id   = [azurerm_private_dns_zone.privatelink_servicebus_windows_net.id]
    name = [azurerm_private_dns_zone.privatelink_servicebus_windows_net.name]
  }

  alerts_enabled = var.eventhub_alerts_enabled
  metric_alerts  = var.eventhub_metric_alerts
  action = [
    {
      action_group_id    = azurerm_monitor_action_group.slack.id
      webhook_properties = null
    },
    {
      action_group_id    = azurerm_monitor_action_group.email.id
      webhook_properties = null
    }
  ]

  tags = var.tags
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "event_hub_keys" {
  for_each = module.event_hub.key_ids

  name         = "eventhub-${replace(each.key, ".", "-")}-key"
  value        = module.event_hub.keys[each.key].primary_key
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "event_hub_connection_strings" {
  for_each = module.event_hub.key_ids

  name         = "eventhub-${replace(each.key, ".", "-")}-connection-string"
  value        = module.event_hub.keys[each.key].primary_connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}
