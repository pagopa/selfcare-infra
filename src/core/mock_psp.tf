resource "azurerm_resource_group" "mock_psp_rg" {
  count    = var.mock_psp_enabled ? 1 : 0
  name     = format("%s-mock-psp-rg", local.project)
  location = var.location

  tags = var.tags
}

# Subnet to host the mock psp
module "mock_psp_snet" {
  count                                          = var.mock_psp_enabled && var.cidr_subnet_mock_psp != null ? 1 : 0
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
  name                                           = format("%s-mock-psp-snet", local.project)
  address_prefixes                               = var.cidr_subnet_mock_psp
  resource_group_name                            = azurerm_resource_group.rg_vnet.name
  virtual_network_name                           = module.vnet.name
  enforce_private_link_endpoint_network_policies = true

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

module "mock_psp" {
  count  = var.mock_psp_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//app_service?ref=v1.0.14"

  resource_group_name = azurerm_resource_group.mock_psp_rg[0].name
  location            = var.location

  # App service plan vars
  plan_name     = format("%s-plan-mock-psp", local.project)
  plan_kind     = "Linux"
  plan_sku_tier = var.mock_psp_tier
  plan_sku_size = var.mock_psp_size
  plan_reserved = true # Mandatory for Linux plan

  # App service plan
  name                = format("%s-app-mock-psp", local.project)
  client_cert_enabled = false
  always_on           = var.mock_psp_always_on
  linux_fx_version    = "JAVA|8-jre8"
  health_check_path   = "/mockPspService/api/v1/info"

  app_settings = {
    SERVER_PUBLIC_URL           = format("https://api.%s.%s/mock-psp/api", var.dns_zone_prefix, var.external_domain),
    PAGOPA_MOCK_PSP_DB_USERNAME = format("%s@%s", data.azurerm_key_vault_secret.db_mock_psp_user_login[0].value, module.postgresql[0].name),
    PAGOPA_MOCK_PSP_DB_PWD      = data.azurerm_key_vault_secret.db_mock_psp_user_login_password[0].value,
    PAGOPA_MOCK_PSP_DB_URL      = format("%s:5432/%s", module.postgresql[0].fqdn, var.prostgresql_db_mockpsp),
    AZURE_API_STATIC_RES        = format("https://api.%s.%s/mock-psp/api/static/", var.dns_zone_prefix, var.external_domain)
  }

  allowed_subnets = [module.apim_snet.id]
  allowed_ips     = []

  subnet_name = module.mock_psp_snet[0].name
  subnet_id   = module.mock_psp_snet[0].id

  tags = var.tags
}

data "azurerm_key_vault_secret" "db_mock_psp_user_login" {
  count        = var.mock_psp_enabled ? 1 : 0
  name         = "db-mock-psp-user-login"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "db_mock_psp_user_login_password" {
  count        = var.mock_psp_enabled ? 1 : 0
  name         = "db-mock-psp-user-login-password"
  key_vault_id = module.key_vault.id
}
