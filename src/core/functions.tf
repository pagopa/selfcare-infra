resource "azurerm_resource_group" "functions_rg" {
  name     = "${local.project}-functions-rg"
  location = var.location

  tags = var.tags
}

# subnet
module "functions_snet" {
  count                = var.cidr_subnet_functions != null ? 1 : 0
  source               = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v7.3.0"
  name                 = format("%s-functions-snet", local.project)
  resource_group_name  = azurerm_resource_group.rg_vnet.name
  virtual_network_name = module.vnet.name
  address_prefixes     = var.cidr_subnet_functions

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

module "onboarding_func" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app?ref=v6.2.1"

  name                = format("%s-func", local.project)
  location            = azurerm_resource_group.functions_rg.location
  resource_group_name = azurerm_resource_group.functions_rg.name

  health_check_path   = "/api/v1/info"
  always_on                                = var.function_always_on
  subnet_id                                = module.functions_snet[0].id
  application_insights_instrumentation_key = azurerm_application_insights.application_insights.instrumentation_key
  java_version                             = "11"
  runtime_version     = "~4"


  app_service_plan_info = var.app_service_plan_info

  storage_account_info = var.storage_account_info


  tags = var.tags
}