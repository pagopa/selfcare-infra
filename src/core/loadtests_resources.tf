resource "azurerm_resource_group" "rg_load_tests_db" {
  count    = var.enable_load_tests_db ? 1 : 0
  name     = "${local.project}-load-tests-db-rg"
  location = var.location

  tags = var.tags
}

module "load_tests_snet" {
  count = var.enable_load_tests_db ? 1 : 0

  source                                    = "github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v7.50.1"
  name                                      = "${local.project}-load-tests-db-snet"
  address_prefixes                          = var.cidr_subnet_load_tests
  resource_group_name                       = azurerm_resource_group.rg_vnet.name
  virtual_network_name                      = module.vnet.name
  private_endpoint_network_policies_enabled = true
  service_endpoints                         = ["Microsoft.Web"]

  delegation = {
    name = "delegation"
    service_delegation = {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_network_profile" "network_profile_load_tests_db" {
  count = var.enable_load_tests_db ? 1 : 0

  name                = "${local.project}-load-tests-db-network-profile"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_load_tests_db[0].name

  container_network_interface {
    name = "container-nic"

    ip_configuration {
      name      = "ip-config"
      subnet_id = module.load_tests_snet[0].id
    }
  }
}

resource "azurerm_container_group" "load_tests_db" {
  count = var.enable_load_tests_db ? 1 : 0

  name                = "${local.project}-load-tests-db"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_load_tests_db[0].name
  ip_address_type     = "Private"
  network_profile_id  = azurerm_network_profile.network_profile_load_tests_db[0].id
  os_type             = "Linux"

  container {
    name   = "docker-influxdb-grafana"
    image  = "philhawthorne/docker-influxdb-grafana:latest"
    cpu    = "0.5"
    memory = "0.5"

    ports {
      port     = 3003
      protocol = "TCP"
    }

    ports {
      port     = 8083
      protocol = "TCP"
    }

    ports {
      port     = 8086
      protocol = "TCP"
    }
  }

  tags = var.tags
}
