resource "azurerm_resource_group" "rg_storage" {
  name     = format("%s-storage-rg", local.project)
  location = var.location
  tags     = var.tags
}

## Storage account to save blob
module "selc-blob-storage" {
  source = "git::https://github.com/pagopa/azurerm.git//storage_account?ref=v1.0.79"

  name                       = replace(format("%s-blobstorage", local.project), "-", "")
  account_kind               = "StorageV2"
  account_tier               = "Standard"
  account_replication_type   = "LRS"
  access_tier                = "Hot"
  enable_versioning          = false
  resource_group_name        = azurerm_resource_group.rg_storage.name
  location                   = var.location
  advanced_threat_protection = false
  allow_blob_public_access   = false

  network_rules = {
    default_action = "Deny"
    ip_rules       = []
    bypass = [
      "Logging",
      "Metrics",
      "AzureServices",
    ]
    virtual_network_subnet_ids = [
      module.apim_snet.id,
      module.k8s_snet.id
    ]
  }

  tags = var.tags
}

# Container parties contracts
resource "azurerm_storage_container" "selc-contracts" {
  name                  = format("%s-contracts-blob", local.project)
  storage_account_name  = module.selc-blob-storage.name
  container_access_type = "blob"
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "cstar_blobstorage_key" {
  name         = "blobstorage-access-key"
  value        = module.selc-blob-storage.primary_access_key
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}
