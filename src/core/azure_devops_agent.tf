resource "azurerm_resource_group" "azdo_rg" {
  count    = var.enable_azdoa ? 1 : 0
  name     = format("%s-azdoa-rg", local.project)
  location = var.location

  tags = var.tags
}

module "azdoa_snet" {
  source                                    = "github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v7.50.1"
  count                                     = var.enable_azdoa ? 1 : 0
  name                                      = format("%s-azdoa-snet", local.project)
  address_prefixes                          = var.cidr_subnet_azdoa
  resource_group_name                       = azurerm_resource_group.rg_vnet.name
  virtual_network_name                      = module.vnet.name
  private_endpoint_network_policies_enabled = true

  service_endpoints = [
    "Microsoft.Storage",
  ]
}

module "azdoa_li" {
  source              = "github.com/pagopa/terraform-azurerm-v3.git//azure_devops_agent?ref=v7.50.1"
  count               = var.enable_azdoa ? 1 : 0
  name                = "${local.project}-azdoa-vmss-ubuntu-app"
  resource_group_name = azurerm_resource_group.azdo_rg[0].name
  subnet_id           = module.azdoa_snet[0].id
  subscription_name   = data.azurerm_subscription.current.display_name
  subscription_id     = data.azurerm_subscription.current.subscription_id
  location            = var.location
  image_type          = "custom" # enables usage of "source_image_name"
  source_image_name   = "selc-${var.env_short}-azdo-agent-ubuntu2204-image-v1"
  vm_sku              = var.azdo_agent_vm_sku

  tags = var.tags
}

module "azdoa_li_infra" {
  source              = "github.com/pagopa/terraform-azurerm-v3.git//azure_devops_agent?ref=v7.50.1"
  count               = var.enable_azdoa ? 1 : 0
  name                = "${local.project}-azdoa-vmss-ubuntu-infra"
  resource_group_name = azurerm_resource_group.azdo_rg[0].name
  subnet_id           = module.azdoa_snet[0].id
  subscription_name   = data.azurerm_subscription.current.display_name
  subscription_id     = data.azurerm_subscription.current.subscription_id
  location            = var.location
  image_type          = "custom" # enables usage of "source_image_name"
  source_image_name   = "selc-${var.env_short}-azdo-agent-ubuntu2204-image-v1"
  vm_sku              = var.azdo_agent_vm_sku

  tags = var.tags
}

# azure devops policy
data "azuread_service_principal" "iac_principal" {
  count        = var.enable_iac_pipeline ? 1 : 0
  display_name = format("pagopaspa-selfcare-iac-projects-%s", data.azurerm_subscription.current.subscription_id)
}

resource "azurerm_key_vault_access_policy" "azdevops_iac_policy" {
  count        = var.enable_iac_pipeline ? 1 : 0
  key_vault_id = module.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azuread_service_principal.iac_principal[0].object_id

  secret_permissions      = ["Get", "List", "Set", ]
  certificate_permissions = ["SetIssuers", "DeleteIssuers", "Purge", "List", "Get"]
  storage_permissions     = []
}

# azure devops policy
data "azuread_service_principal" "app_projects_principal" {
  count = var.enable_app_projects_pipeline ? 1 : 0
  ###???
  # display_name = format("pagopaspa-selfcare-platform-app-projects-%s", data.azurerm_subscription.current.subscription_id)
  client_id = "857f30ee-6e15-4b50-a9f3-cfd2ab2d3a29"
}

resource "azurerm_key_vault_access_policy" "azdevops_app_projects_policy" {
  count        = var.enable_app_projects_pipeline ? 1 : 0
  key_vault_id = module.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azuread_service_principal.app_projects_principal[0].object_id

  secret_permissions      = ["Get", "List"]
  certificate_permissions = []
  storage_permissions     = []
  key_permissions         = []
}
