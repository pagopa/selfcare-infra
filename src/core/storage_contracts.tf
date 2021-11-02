## Storage account to save contracts

resource "azurerm_resource_group" "rg_contracts_storage" {
  name     = format("%s-contracts-storage-rg", local.project)
  location = var.location
  tags     = var.tags
}

#tfsec:ignore:azure-storage-default-action-deny
module "selc-contracts-storage" {
  source = "git::https://github.com/pagopa/azurerm.git//storage_account?ref=v1.0.79"

  name                       = replace(format("%s-contracts-storage", local.project), "-", "")
  account_kind               = "StorageV2"
  account_tier               = "Standard"
  account_replication_type   = var.env_short == "p" ? "RA-GZRS" : "LRS"
  access_tier                = "Hot"
  enable_versioning          = var.env_short == "p" ? true : false
  resource_group_name        = azurerm_resource_group.rg_contracts_storage.name
  location                   = var.location
  advanced_threat_protection = var.env_short == "p" ? true : false
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

resource "azurerm_storage_container" "selc-contracts-container" {
  name                  = format("%s-contracts-blob", local.project)
  storage_account_name  = module.selc-contracts-storage.name
  container_access_type = "private"
}

module "contracts_storage_snet" {
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.60"
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
    name = "private-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.privatelink_blob_core_windows_net.id]
  }
}
