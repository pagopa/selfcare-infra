module "spid-test-env" {
  source = "../modules/spid_testenv"

  enable_spid_test = var.enable_spid_test

  name              = format("%s-spid-testenv", local.project)
  location          = var.location
  subscription_name = data.azurerm_subscription.current.display_name

  hub_spid_login_metadata_url = format("https://api.%s.%s/spid/v1/metadata", var.dns_zone_prefix, var.external_domain)

  spid_testenv_local_config_dir = format("./env/%s/spid_testenv_conf", var.env)

  cidr_subnet_spid_test_env_private = var.cidr_subnet_spid_test_env_private
  virtual_network_resource_group    = azurerm_resource_group.rg_vnet.name
  virtual_network_name              = module.vnet.name

  tags = var.tags
}
