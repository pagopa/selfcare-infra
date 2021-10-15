module "spid-test-env" {
  source = "../modules/spid_testenv"

  enable_spid_test = var.enable_spid_test

  name              = format("%s-spid-testenv", local.project)
  location          = var.location
  subscription_name = data.azurerm_subscription.current.display_name

  hub_spid_login_metadata_url = format("https://api.%s.%s/hubspidloginms/metadata", var.dns_zone_prefix, var.external_domain)

  tags = var.tags
}
