resource "azurerm_cosmosdb_account" "this" {
  name                      = var.name
  location                  = var.location
  resource_group_name       = var.resource_group_name
  offer_type                = var.offer_type
  kind                      = var.kind
  enable_free_tier          = var.enable_free_tier
  enable_automatic_failover = var.enable_automatic_failover

  mongo_server_version = var.mongo_server_version

  geo_location {
    location          = var.main_geo_location_location
    failover_priority = 0
  }

  dynamic "geo_location" {
    for_each = var.additional_geo_locations

    content {
      location          = geo_location.value.location
      failover_priority = geo_location.value.failover_priority
    }
  }

  consistency_policy {
    consistency_level       = var.consistency_policy.consistency_level
    max_interval_in_seconds = var.consistency_policy.max_interval_in_seconds
    max_staleness_prefix    = var.consistency_policy.max_staleness_prefix
  }

  dynamic "capabilities" {
    for_each = var.capabilities

    content {
      name = capabilities.value
    }
  }

  public_network_access_enabled = var.public_network_access_enabled

  // Virtual network settings
  is_virtual_network_filter_enabled = var.is_virtual_network_filter_enabled

  dynamic "virtual_network_rule" {
    for_each = var.allowed_virtual_network_subnet_ids
    iterator = subnet_id

    content {
      id = subnet_id.value
    }
  }

  // IP filtering
  ip_range_filter = var.ip_range

  tags = var.tags
}

resource "azurerm_management_lock" "this" {
  count      = var.lock_enable ? 1 : 0
  name       = format("%s-lock", azurerm_cosmosdb_account.this.name)
  scope      = azurerm_cosmosdb_account.this.id
  lock_level = "CanNotDelete"
  notes      = "This items can't be deleted in this subscription!"
}
