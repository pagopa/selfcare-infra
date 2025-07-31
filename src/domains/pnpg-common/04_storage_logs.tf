## Storage account to save logs

resource "azurerm_resource_group" "rg_logs_storage" {
  name     = "${local.project}-logs-storage-rg"
  location = var.location
  tags     = var.tags
}

#tfsec:ignore:azure-storage-default-action-deny
module "selc_logs_storage" {
  source                          = "github.com/pagopa/terraform-azurerm-v4.git//storage_account?ref=v6.6.0"
  name                            = replace("${local.project}-st-logs", "-", "")
  account_kind                    = "StorageV2"
  account_tier                    = "Standard"
  account_replication_type        = var.logs_account_replication_type
  access_tier                     = "Hot"
  blob_versioning_enabled         = var.logs_enable_versioning
  resource_group_name             = azurerm_resource_group.rg_logs_storage.name
  location                        = var.location
  advanced_threat_protection      = var.logs_advanced_threat_protection
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = false
  blob_delete_retention_days      = var.logs_delete_retention_days

  tags = var.tags
}

resource "azurerm_storage_container" "selc_logs_container" {
  name                  = "${local.project}-logs-blob"
  storage_account_name  = module.selc_logs_storage.name
  container_access_type = "private"
}

#
# Key Vault
#

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "selc_logs_storage_access_key" {
  name         = "logs-storage-access-key"
  value        = module.selc_logs_storage.primary_access_key
  content_type = "text/plain"

  key_vault_id = module.key_vault_pnpg.id
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry
resource "azurerm_key_vault_secret" "selc_logs_storage_connection_string" {
  name         = "logs-storage-connection-string"
  value        = module.selc_logs_storage.primary_connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault_pnpg.id
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry
resource "azurerm_key_vault_secret" "selc_logs_storage_blob_connection_string" {
  name         = "logs-storage-blob-connection-string"
  value        = module.selc_logs_storage.primary_blob_connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault_pnpg.id
}

#
# Private Endpoint
#
resource "azurerm_private_endpoint" "logs_storage" {
  name                = "${local.project}-logs_storage"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_logs_storage.name
  subnet_id           = data.azurerm_subnet.private_endpoint_subnet.id

  private_service_connection {
    name                           = "${local.project}-logs_storage-private-endpoint"
    private_connection_resource_id = module.selc_logs_storage.id
    is_manual_connection           = false
    subresource_names              = ["Blob"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_blob_core_windows_net.id]
  }
}

module "logs_storage_snet" {
  source               = "github.com/pagopa/terraform-azurerm-v4.git//subnet?ref=v6.6.0"
  name                 = "${local.project}-logs-storage-snet"
  address_prefixes     = var.cidr_subnet_logs_storage
  resource_group_name  = data.azurerm_virtual_network.vnet_core.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet_core.name
  # enforce_private_link_endpoint_network_policies = true

  service_endpoints = [
    "Microsoft.Storage",
  ]
}
