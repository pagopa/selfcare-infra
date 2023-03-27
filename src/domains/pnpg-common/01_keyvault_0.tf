resource "azurerm_resource_group" "sec_rg_pnpg" {
  name     = "${local.product}-${var.domain}-sec-rg"
  location = var.location

  tags = var.tags
}

module "key_vault_pnpg" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault?ref=v5.3.0"

  name                       = "${local.product}-${var.domain}-kv"
  location                   = azurerm_resource_group.sec_rg_pnpg.location
  resource_group_name        = azurerm_resource_group.sec_rg_pnpg.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days = 90
  sku_name                   = "premium"

  tags = var.tags
}

## ad group policy ##
resource "azurerm_key_vault_access_policy" "ad_admin_group_policy" {
  key_vault_id = module.key_vault_pnpg.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.adgroup_admin.object_id

  key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", "Restore", "Purge", "Recover", ]
  secret_permissions      = ["Get", "List", "Delete", "Restore", "Purge", "Recover", "Set", "Backup"]
  storage_permissions     = []
  certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Restore", "Purge", "Recover", ]
}

#
# policy developers
#
resource "azurerm_key_vault_access_policy" "adgroup_developers_policy" {

  key_vault_id = module.key_vault_pnpg.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.adgroup_developers.object_id

  key_permissions         = var.env_short == "d" ? ["Get", "List", "Update", "Create", "Import", "Delete", "Restore", "Purge", "Recover", ] : ["Get", "List", "Update", "Create", "Import", ]
  secret_permissions      = var.env_short == "d" ? ["Get", "List", "Delete", "Restore", "Purge", "Recover", "Set", "Backup"] : ["Get", "List", "Set", ]
  storage_permissions     = []
  certificate_permissions = var.env_short == "d" ? ["Get", "List", "Update", "Create", "Import", "Delete", "Restore", "Purge", "Recover", "ManageContacts", ] : ["Get", "List", "Update", "Create", "Import", "Restore", "Recover", ]
}

#
# policy externals
#

resource "azurerm_key_vault_access_policy" "adgroup_externals_policy" {
  count = var.env_short == "d" ? 1 : 0

  key_vault_id = module.key_vault_pnpg.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.adgroup_developers.object_id

  key_permissions         = var.env_short == "d" ? ["Get", "List", "Update", "Create", "Import", "Delete", ] : ["Get", "List", "Update", "Create", "Import", ]
  secret_permissions      = var.env_short == "d" ? ["Get", "List", "Delete", "Restore", "Purge", "Recover", "Set", "Backup"] : ["Get", "List", "Set", ]
  storage_permissions     = []
  certificate_permissions = var.env_short == "d" ? ["Get", "List", "Update", "Create", "Import", "Delete", "Restore", "Purge", "Recover", "ManageContacts", ] : ["Get", "List", "Update", "Create", "Import", "Restore", "Recover", ]
}


# ## api management policy ##
resource "azurerm_key_vault_access_policy" "api_management_policy" {
  key_vault_id = module.key_vault_pnpg.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_user_assigned_identity.api_management_policy.principal_id

  key_permissions         = []
  secret_permissions      = ["Get", "List"]
  certificate_permissions = ["Get", "List"]
  storage_permissions     = []
}

resource "azurerm_user_assigned_identity" "api_management_policy" {
  resource_group_name = "${local.product}-api-rg"
  name                = "${local.product}-apim"
  location            = azurerm_resource_group.sec_rg_pnpg.location
  tags = var.tags
}
