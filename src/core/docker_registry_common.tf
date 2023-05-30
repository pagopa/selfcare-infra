resource "azurerm_resource_group" "docker_registry" {
  name     = "${local.project}-docker-rg"
  location = var.location

  tags = var.tags
}

module "acr_common" {
  source                        = "git::https://github.com/pagopa/terraform-azurerm-v3.git//container_registry?ref=v6.14.0"
  name                          = replace("${local.project}-common-acr", "-", "")
  resource_group_name           = azurerm_resource_group.docker_registry.name
  location                      = azurerm_resource_group.docker_registry.location
  admin_enabled                 = false
  sku                           = var.docker_registry.sku
  anonymous_pull_enabled        = false
  zone_redundancy_enabled       = var.docker_registry.zone_redundancy_enabled
  public_network_access_enabled = true

  network_rule_set = [{
    default_action  = var.docker_registry.network_rule_set.default_action
    ip_rule         = var.docker_registry.network_rule_set.ip_rule
    virtual_network = var.docker_registry.network_rule_set.virtual_network
  }]

  private_endpoint = {
    enabled              = false
    private_dns_zone_ids = [""]
    subnet_id            = ""
    virtual_network_id   = ""
  }

  georeplications = var.docker_registry.geo_replication.enabled ? [{
    location                  = var.location_pair
    regional_endpoint_enabled = var.docker_registry.geo_replication.regional_endpoint_enabled
    zone_redundancy_enabled   = var.docker_registry.geo_replication.zone_redundancy_enabled
  }] : []

  tags = var.tags
}


