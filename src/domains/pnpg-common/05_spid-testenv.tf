module "spid-test-env" {
  source = "./modules/spid_testenv"

  enable_spid_test = var.enable_spid_test

  name              = "${local.product}-${var.domain}-spid-testenv"
  location          = var.location
  subscription_name = data.azurerm_subscription.current.display_name

  hub_spid_login_metadata_url = "https://api-pnpg.${var.dns_zone_prefix}.${var.external_domain}/spid/v1/metadata"

  spid_testenv_local_config_dir = "./env/${var.env}/spid_testenv_conf"

  tags = var.tags
}
