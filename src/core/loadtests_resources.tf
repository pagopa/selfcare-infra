resource "azurerm_resource_group" "rg_load_tests_db" {
  count    = var.enable_load_tests_db ? 1 : 0
  name     = "${local.project}-load-tests-db-rg"
  location = var.location

  tags = var.tags
}

resource "azurerm_container_group" "load_tests_db" {
  count               = var.enable_load_tests_db ? 1 : 0
  name                = "${local.project}-load-tests-db"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_load_tests_db[0].name
  ip_address_type     = "Private"
  dns_name_label      = "${local.project}-load-tests-db"
  os_type             = "Linux"

  container {
    name     = "docker-influxdb-grafana"
    image    = "philhawthorne/docker-influxdb-grafana:latest"
    cpu      = "0.5"
    memory   = "0.5"

    ports {
      port     = 3003
      protocol = "TCP"
    }

    ports {
      port     = "3004:8083"
      protocol = "TCP"
    }

    ports {
      port     = 8086
      protocol = "TCP"
    }
  }

  tags = var.tags
}
