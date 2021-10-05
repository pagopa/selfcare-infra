resource "azurerm_resource_group" "rg_storage" {
  name     = format("%s-storage-rg", local.project)
  location = var.location
  tags     = var.tags
}


## Storage account to save aks terraform state
module "aks_storage_account_terraform_state" {
  source = "git::https://github.com/pagopa/azurerm.git//storage_account?ref=v1.0.58"

  name            = replace(format("%s-saaksinfra", local.project), "-", "")
  versioning_name = format("%s-sa-aksinfra-versioning", local.project)

  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "GRS"
  access_tier              = "Hot"
  enable_versioning        = true
  resource_group_name      = azurerm_resource_group.rg_aks.name
  location                 = var.location

  tags = var.tags
}

# Container to stare the status file
resource "azurerm_storage_container" "aks_state" {
  depends_on = [module.aks_storage_account_terraform_state]

  name                  = format("%s-aks-state", var.prefix)
  storage_account_name  = module.aks_storage_account_terraform_state.name
  container_access_type = "private"
}

## Storage account to save logs
module "operations_logs" {
  source = "git::https://github.com/pagopa/azurerm.git//storage_account?ref=v1.0.58"

  name                = replace(format("%s-sa-ops-logs", local.project), "-", "")
  versioning_name     = format("%s-sa-ops-versioning", local.project)
  resource_group_name = azurerm_resource_group.rg_storage.name
  location            = var.location

  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "GRS"
  access_tier              = "Hot"
  enable_versioning        = true

  lock_enabled = true
  lock_name    = "storage-logs"
  lock_level   = "CanNotDelete"
  lock_notes   = null


  tags = var.tags
}
