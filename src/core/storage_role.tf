data "azurerm_storage_account" "tfstate" {
  name                     = "tfapp${var.env}selfcare"
  resource_group_name      = "terraform-state-rg"
}

# Container per lo stato Terraform
data "azurerm_storage_container" "tfstate" {
  name                  = "terraform-state"
  storage_account_name  = data.azurerm_storage_account.tfstate.name
}

# Assegna il ruolo al service principal corrente
resource "azurerm_role_assignment" "storage_blob_contributor" {
  scope              = data.azurerm_storage_account.tfstate.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id       = data.azuread_group.adgroup_developers.object_id
}

resource "azurerm_role_assignment" "storage_blob_contributor_admin" {
  scope              = data.azurerm_storage_account.tfstate.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id       = data.azuread_group.adgroup_admin.object_id
}
