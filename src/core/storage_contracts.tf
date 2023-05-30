## Storage account to save contracts

resource "azurerm_resource_group" "rg_contracts_storage" {
  name     = format("%s-contracts-storage-rg", local.project)
  location = var.location
  tags     = var.tags
}

#tfsec:ignore:azure-storage-default-action-deny
module "selc-contracts-storage" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account?ref=v6.14.0"

  name                       = replace(format("%s-contracts-storage", local.project), "-", "")
  account_kind               = "StorageV2"
  account_tier               = "Standard"
  account_replication_type   = var.contracts_account_replication_type
  access_tier                = "Hot"
  versioning_name            = "versioning"
  enable_versioning          = var.contracts_enable_versioning
  resource_group_name        = azurerm_resource_group.rg_contracts_storage.name
  location                   = var.location
  advanced_threat_protection = var.contracts_advanced_threat_protection
  allow_blob_public_access   = false

  blob_properties_delete_retention_policy_days = var.contracts_delete_retention_days

  tags = var.tags
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "selc_contracts_storage_access_key" {
  name         = "contracts-storage-access-key"
  value        = module.selc-contracts-storage.primary_access_key
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry
resource "azurerm_key_vault_secret" "selc_contracts_storage_connection_string" {
  name         = "contracts-storage-connection-string"
  value        = module.selc-contracts-storage.primary_connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry
resource "azurerm_key_vault_secret" "selc_contracts_storage_blob_connection_string" {
  name         = "contracts-storage-blob-connection-string"
  value        = module.selc-contracts-storage.primary_blob_connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

resource "azurerm_storage_container" "selc-contracts-container" {
  name                  = format("%s-contracts-blob", local.project)
  storage_account_name  = module.selc-contracts-storage.name
  container_access_type = "private"
}

module "contracts_storage_snet" {
  source                                         = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v6.14.0"
  name                                           = format("%s-contracts-storage-snet", local.project)
  address_prefixes                               = var.cidr_subnet_contract_storage
  resource_group_name                            = azurerm_resource_group.rg_vnet.name
  virtual_network_name                           = module.vnet.name
  enforce_private_link_endpoint_network_policies = true

  service_endpoints = [
    "Microsoft.Storage",
  ]
}

resource "azurerm_private_endpoint" "contracts_storage" {
  name                = format("%s-contracts_storage", local.project)
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_contracts_storage.name
  subnet_id           = module.contracts_storage_snet.id

  private_service_connection {
    name                           = format("%s-contracts_storage-private-endpoint", local.project)
    private_connection_resource_id = module.selc-contracts-storage.id
    is_manual_connection           = false
    subresource_names              = ["Blob"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.privatelink_blob_core_windows_net.id]
  }
}
