## VPN subnet
module "vpn_snet" {
  source                                    = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v7.3.0"
  name                                      = "GatewaySubnet"
  address_prefixes                          = var.cidr_subnet_vpn
  resource_group_name                       = azurerm_resource_group.rg_vnet.name
  virtual_network_name                      = module.vnet.name
  service_endpoints                         = []
  private_endpoint_network_policies_enabled = true
}

data "azuread_application" "vpn_app" {
  display_name = format("%s-app-vpn", local.project)
}

module "vpn" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//vpn_gateway?ref=v7.3.0"

  name                = format("%s-vpn", local.project)
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_vnet.name
  sku                 = var.vpn_sku
  pip_sku             = var.vpn_pip_sku
  subnet_id           = module.vpn_snet.id

  vpn_client_configuration = [
    {
      address_space         = ["172.16.1.0/24"],
      vpn_client_protocols  = ["OpenVPN"],
      aad_audience          = data.azuread_application.vpn_app.application_id
      aad_issuer            = format("https://sts.windows.net/%s/", data.azurerm_subscription.current.tenant_id)
      aad_tenant            = format("https://login.microsoftonline.com/%s", data.azurerm_subscription.current.tenant_id)
      radius_server_address = null
      radius_server_secret  = null
      revoked_certificate   = []
      root_certificate      = []
    }
  ]

  # Security Logs
  sec_log_analytics_workspace_id = var.env_short == "p" ? data.azurerm_key_vault_secret.sec_workspace_id[0].value : null
  sec_storage_id                 = var.env_short == "p" ? data.azurerm_key_vault_secret.sec_storage_id[0].value : null

  tags = var.tags
}

## DNS Forwarder
module "dns_forwarder_snet" {
  source                                    = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v7.5.0"
  name                                      = format("%s-dns-forwarder-snet", local.project)
  address_prefixes                          = var.cidr_subnet_dns_forwarder
  resource_group_name                       = azurerm_resource_group.rg_vnet.name
  virtual_network_name                      = module.vnet.name
  private_endpoint_network_policies_enabled = true

  delegation = {
    name = "delegation"
    service_delegation = {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

module "dns_forwarder" {
  source              = "git::https://github.com/pagopa/terraform-azurerm-v3.git//dns_forwarder?ref=v7.3.0"
  name                = format("%s-dns-forwarder", local.project)
  location            = azurerm_resource_group.rg_vnet.location
  resource_group_name = azurerm_resource_group.rg_vnet.name
  subnet_id           = module.dns_forwarder_snet.id

  tags = var.tags
}

# DNS FORWARDER FOR DISASTER RECOVERY

#
# DNS Forwarder
#
module "dns_forwarder_pair_subnet" {
  source                                    = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v6.20.0"
  name                                      = "${local.project_pair}-dnsforwarder-snet"
  address_prefixes                          = var.cidr_subnet_pair_dnsforwarder
  resource_group_name                       = azurerm_resource_group.rg_pair_vnet.name
  virtual_network_name                      = module.vnet_pair.name
  private_endpoint_network_policies_enabled = true

  delegation = {
    name = "delegation"
    service_delegation = {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

output "subnet_pair_id" {
  value = module.dns_forwarder_pair_subnet.id
}

resource "random_id" "pair_dns_forwarder_hash" {
  byte_length = 3
}

module "vpn_pair_dns_forwarder" {

  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//dns_forwarder?ref=v7.3.0"

  name                = "${local.project_pair}-${random_id.pair_dns_forwarder_hash.hex}-vpn-dnsfrw"
  location            = var.location_pair
  resource_group_name = azurerm_resource_group.rg_pair_vnet.name
  subnet_id           = module.dns_forwarder_pair_subnet.id
  tags                = var.tags
}
