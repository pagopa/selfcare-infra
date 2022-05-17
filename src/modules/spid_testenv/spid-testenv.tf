resource "azurerm_resource_group" "rg_spid_testenv" {
  count    = var.enable_spid_test ? 1 : 0
  name     = format("%s-rg", var.name)
  location = var.location

  tags = var.tags
}

# tfsec:ignore:azure-storage-default-action-deny
# tfsec:ignore:azure-storage-queue-services-logging-enabled
resource "azurerm_storage_account" "spid_testenv_storage_account" {
  count                     = var.enable_spid_test ? 1 : 0
  name                      = replace(format("%s-sa-st", var.name), "-", "")
  resource_group_name       = azurerm_resource_group.rg_spid_testenv[0].name
  location                  = var.location
  enable_https_traffic_only = true
  min_tls_version           = "TLS1_2"
  account_tier              = "Standard"

  account_replication_type = "LRS"

  tags = var.tags
}

resource "azurerm_storage_share" "spid_testenv_storage_share" {
  count = var.enable_spid_test ? 1 : 0
  name  = format("%s-share", var.name)

  storage_account_name = azurerm_storage_account.spid_testenv_storage_account[0].name

  quota = 1
}

resource "azurerm_storage_share" "spid_testenv_caddy_storage_share" {
  count = var.enable_spid_test ? 1 : 0
  name  = format("%s-caddy-share", var.name)

  storage_account_name = azurerm_storage_account.spid_testenv_storage_account[0].name

  quota = 1
}

module "spid_test_env_private_snet" {
  count                                          = var.enable_spid_test ? 1 : 0
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v2.0.3"
  name                                           = format("%s-private-snet", var.name)
  address_prefixes                               = var.cidr_subnet_spid_test_env_private
  resource_group_name                            = var.virtual_network_resource_group
  virtual_network_name                           = var.virtual_network_name
  enforce_private_link_endpoint_network_policies = true

  delegation = {
    name = "delegation"
    service_delegation = {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_network_profile" "spid_testenv_network_profile" {
  count               = var.enable_spid_test ? 1 : 0
  name                = format("%s-network-profile", var.name)
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_spid_testenv[0].name

  container_network_interface {
    name = "container-nic"

    ip_configuration {
      name      = "ip-config"
      subnet_id = module.spid_test_env_private_snet[0].id
    }
  }
}

resource "azurerm_container_group" "spid_testenv" {
  count               = var.enable_spid_test ? 1 : 0
  name                = "${var.name}-spid-testenv2"
  location            = azurerm_resource_group.rg_spid_testenv[0].location
  resource_group_name = azurerm_resource_group.rg_spid_testenv[0].name
  ip_address_type     = "Private"
  network_profile_id  = azurerm_network_profile.spid_testenv_network_profile[0].id
  os_type             = "Linux"

  container {
    name   = "spid-testenv2"
    image  = "italia/spid-testenv2:1.1.0"
    cpu    = "0.5"
    memory = "0.5"

    ports {
      port     = 8088
      protocol = "TCP"
    }

    environment_variables = {

    }

    readiness_probe {
      http_get {
        path   = "/"
        port   = 8088
        scheme = "Http"
      }
      initial_delay_seconds = 30
      timeout_seconds       = 4
    }

    liveness_probe {
      http_get {
        path   = "/"
        port   = 8088
        scheme = "Http"
      }
      initial_delay_seconds = 900
      timeout_seconds       = 4
    }

    volume {
      mount_path = "/app/conf"
      name       = "spid-testenv-conf"
      read_only  = false
      share_name = azurerm_storage_share.spid_testenv_storage_share[0].name

      storage_account_key  = azurerm_storage_account.spid_testenv_storage_account[0].primary_access_key
      storage_account_name = azurerm_storage_account.spid_testenv_storage_account[0].name
    }

  }

  tags = var.tags
}

resource "azurerm_container_group" "caddy" {
  count               = var.enable_spid_test ? 1 : 0
  name                = "${var.name}-caddy"
  location            = azurerm_resource_group.rg_spid_testenv[0].location
  resource_group_name = azurerm_resource_group.rg_spid_testenv[0].name
  ip_address_type     = "Public"
  dns_name_label      = var.name
  os_type             = "Linux"

  container {
    name     = "caddy-ssl-server"
    image    = "caddy:2"
    cpu      = "0.5"
    memory   = "0.5"
    commands = ["caddy", "run", "--config", "/data/Caddyfile"]

    ports {
      port     = 443
      protocol = "TCP"
    }

    ports {
      port     = 80
      protocol = "TCP"
    }

    volume {
      mount_path = "/data"
      name       = "caddy-data"
      read_only  = false
      share_name = azurerm_storage_share.spid_testenv_caddy_storage_share[0].name

      storage_account_key  = azurerm_storage_account.spid_testenv_storage_account[0].primary_access_key
      storage_account_name = azurerm_storage_account.spid_testenv_storage_account[0].name
    }
  }

  tags = var.tags
}

resource "local_file" "spid_testenv_config" {
  count    = var.enable_spid_test ? 1 : 0
  filename = format("%s/config.yaml", var.spid_testenv_local_config_dir)
  content = templatefile(
    "${path.module}/spid_testenv_conf/config.yaml.tpl",
    {
      base_url                      = format("https://%s", trim(azurerm_container_group.caddy[0].fqdn, "."))
      service_provider_metadata_url = var.hub_spid_login_metadata_url
  })
}

resource "local_file" "caddyfile" {
  count    = var.enable_spid_test ? 1 : 0
  filename = format("%s/Caddyfile", var.spid_testenv_local_config_dir)
  content = templatefile(
    "${path.module}/spid_testenv_conf/Caddyfile.tpl",
    {
      CADDY_HOST       = "${var.name}.${var.location}.azurecontainer.io"
      SPIDTESTENV_HOST = azurerm_container_group.spid_testenv[0].ip_address
  })
}

resource "null_resource" "upload_config_caddy" {
  count = var.enable_spid_test ? 1 : 0
  triggers = {
    "changes-in-caddyfile" : md5(local_file.caddyfile[count.index].content)
  }

  provisioner "local-exec" {
    command = <<EOT
              az storage file upload --account-name ${azurerm_storage_account.spid_testenv_storage_account[0].name} --account-key ${azurerm_storage_account.spid_testenv_storage_account[0].primary_access_key} --share-name ${azurerm_storage_share.spid_testenv_caddy_storage_share[0].name} --source ${var.spid_testenv_local_config_dir}/Caddyfile
              az container restart --name ${azurerm_container_group.caddy[0].name} --resource-group  ${azurerm_resource_group.rg_spid_testenv[0].name}
          EOT
  }
}

resource "null_resource" "upload_config_spid_testenv" {
  count = var.enable_spid_test ? 1 : 0
  triggers = {
    "changes-in-config" : md5(local_file.spid_testenv_config[count.index].content)
  }

  provisioner "local-exec" {
    command = <<EOT
              az storage file upload --account-name ${azurerm_storage_account.spid_testenv_storage_account[0].name} --account-key ${azurerm_storage_account.spid_testenv_storage_account[0].primary_access_key} --share-name ${azurerm_storage_share.spid_testenv_storage_share[0].name} --source ${var.spid_testenv_local_config_dir}/config.yaml --path config.yaml
              az container restart --name ${azurerm_container_group.spid_testenv[0].name} --resource-group  ${azurerm_resource_group.rg_spid_testenv[0].name}
          EOT
  }
}