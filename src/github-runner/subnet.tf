module "subnet_runner" {
  source = "github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v7.46.0"

  name                 = "${local.project}-github-runner-snet"
  resource_group_name  = var.networking.vnet_resource_group_name
  virtual_network_name = var.networking.vnet_name

  address_prefixes = [
    "${var.networking.subnet_cidr_block}"
  ]

  private_endpoint_network_policies_enabled = true
}
