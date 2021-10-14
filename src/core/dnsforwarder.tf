resource "azurerm_resource_group" "dns_forwarder" {

  name     = format("%s-dns-forwarder-rg", local.project)
  location = var.location

  tags = var.tags
}

## DNS Forwarder subnet
module "dns_forwarder_snet" {
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.60"
  name                                           = format("%s-dnsforwarder-snet", local.project)
  address_prefixes                               = var.cidr_subnet_dnsforwarder
  resource_group_name                            = azurerm_resource_group.rg_vnet.name
  virtual_network_name                           = module.vnet.name
  enforce_private_link_endpoint_network_policies = true

  service_endpoints = [
    "Microsoft.Storage",
  ]

  delegation = {
    name = "delegation"
    service_delegation = {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_network_profile" "dns_forwarder" {
  name                = format("%s-dnsforwarder-netprofile", local.project)
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_vnet.name

  container_network_interface {
    name = "container-nic"

    ip_configuration {
      name      = "ip-config"
      subnet_id = module.dns_forwarder_snet.id
    }
  }
}

#tfsec:ignore:azure-storage-default-action-deny
module "storage_account_dns_forwarder" {
  source = "git::https://github.com/pagopa/azurerm.git//storage_account?ref=v1.0.60"

  name                       = replace(format("%s-dnsfwd-st", local.project), "-", "")
  account_kind               = "StorageV2"
  account_tier               = "Standard"
  account_replication_type   = "LRS"
  access_tier                = "Hot"
  resource_group_name        = azurerm_resource_group.dns_forwarder.name
  location                   = var.location
  advanced_threat_protection = false

  tags = var.tags
}

resource "azurerm_storage_share" "dns_forwarder" {

  name = format("%s-dns-forwarder-share", local.project)

  storage_account_name = module.storage_account_dns_forwarder.name

  quota = 1
}

resource "azurerm_container_group" "coredns_forwarder" {

  name                = format("%s-dns-forwarder", local.project)
  location            = azurerm_resource_group.dns_forwarder.location
  resource_group_name = azurerm_resource_group.dns_forwarder.name
  ip_address_type     = "Private"
  network_profile_id  = azurerm_network_profile.dns_forwarder.id
  os_type             = "Linux"

  container {
    name   = "dns-forwarder"
    image  = "coredns/coredns:1.8.4"
    cpu    = "0.5"
    memory = "0.5"

    commands = ["/coredns", "-conf", "/app/conf/Corefile"]

    ports {
      port     = 53
      protocol = "UDP"
    }

    ports {
      port     = 8080
      protocol = "TCP"
    }

    ports {
      port     = 8181
      protocol = "TCP"
    }

    environment_variables = {

    }

    /*
    readiness_probe {
      http_get {
        path   = "/ready"
        port   = 8181
        scheme = "Http"
      }
      failure_threshold     = 3
      initial_delay_seconds = 0
      period_seconds        = 10
      success_threshold     = 1
      timeout_seconds       = 1
    }

    liveness_probe {
      http_get {
        path   = "/health"
        port   = 8080
        scheme = "Http"
      }
      failure_threshold     = 5
      initial_delay_seconds = 60
      period_seconds        = 10
      success_threshold     = 1
      timeout_seconds       = 5
    }
*/

    volume {
      mount_path = "/app/conf"
      name       = "dns-forwarder-conf"
      read_only  = false
      share_name = azurerm_storage_share.dns_forwarder.name

      storage_account_key  = module.storage_account_dns_forwarder.primary_access_key
      storage_account_name = module.storage_account_dns_forwarder.name
    }

  }


  depends_on = [
    null_resource.upload_corefile
  ]

  tags = var.tags
}

data "local_file" "corefile" {
  filename = "${path.module}/dns/Corefile"
}

resource "null_resource" "upload_corefile" {

  triggers = {
    "changes-in-config" : md5(data.local_file.corefile.content)
  }

  provisioner "local-exec" {
    command = <<EOT
              az storage file upload \
                --account-name ${module.storage_account_dns_forwarder.name} \
                --account-key ${module.storage_account_dns_forwarder.primary_access_key} \
                --share-name ${azurerm_storage_share.dns_forwarder.name} \
                --source "${path.module}/dns/Corefile"
          EOT
  }
}
