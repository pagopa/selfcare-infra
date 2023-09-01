resource "azurerm_resource_group" "functions_rg" {
  name = "${var.project}-${var.env_short}-functions-resource-group"
  location = var.location

  tags = var.tags
}

resource "azurerm_storage_account" "functions_storage_account" {
  name = "${var.project}${var.env_short}functionsstorage"
  resource_group_name = azurerm_resource_group.functions_rg.name
  location = var.location
  account_tier = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_app_service_plan" "functions_app_service_plan" {
  name                = "${var.project}-${var.environment}-app-service-plan"
  resource_group_name = azurerm_resource_group.functions_rg.name
  location            = var.location
  kind                = "FunctionApp"
  reserved = true # this has to be set to true for Linux. Not related to the Premium Plan
  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

module "onboarding_func" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app?ref=v6.2.1"

  name                                     = format("%s-func", local.project)
  location                                 = azurerm_resource_group.functions_rg.location
  resource_group_name                      = azurerm_resource_group.functions_rg.name
  storage_account_name                     = azurerm_storage_account.functions_storage_account.name
  storage_account_durable_name             = azurerm_storage_account.functions_storage_account.name
  app_service_plan_id                      = azurerm_app_service_plan.functions_app_service_plan.id
  always_on                                = true
  subnet_id                                = module.subnet.id
  application_insights_instrumentation_key = azurerm_application_insights.application_insights.instrumentation_key
  system_identity                          = false

  tags = var.tags
}