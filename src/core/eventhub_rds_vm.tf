resource "azurerm_public_ip" "evh_rds" {
  name                = format("%s-evh-rds-pip", local.project)
  location            = var.location
  resource_group_name = azurerm_resource_group.event_rg.name
  allocation_method   = "Static"
  zones               = [1, 2, 3]
  sku                 = "Standard"
  sku_tier            = "Regional"
  domain_name_label   = format("%s-evh-rds", local.project)

  tags = var.tags

  # static ip shared with nexi, don't destroy it
  lifecycle {
    prevent_destroy = true
  }
}

resource "random_password" "evh_rds_vm_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_key_vault_secret" "evh_rds_vm_password" {
  name         = format("%s-evh-rds-vm-password", local.project)
  value        = random_password.evh_rds_vm_password.result
  key_vault_id = module.key_vault.id

  tags = var.tags

  lifecycle {
    prevent_destroy = true
  }
}

module "evh_rds_vm_snet" {
  source                                    = "github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v7.50.1"
  name                                      = format("%s-vm-snet", local.project)
  address_prefixes                          = var.cidr_subnet_eventhub_rds
  resource_group_name                       = azurerm_resource_group.rg_vnet.name
  virtual_network_name                      = module.vnet.name
  private_endpoint_network_policies_enabled = false
}

resource "azurerm_network_interface" "evh_rds_vm_public" {
  name                 = format("%s-evh-rds-vm-public-nic", local.project)
  location             = var.location
  resource_group_name  = azurerm_resource_group.event_rg.name
  enable_ip_forwarding = true

  ip_configuration {
    name                          = format("%s-evh-rds-vm-public-nic", local.project)
    public_ip_address_id          = azurerm_public_ip.evh_rds.id
    subnet_id                     = module.evh_rds_vm_snet.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.tags
}

resource "azurerm_linux_virtual_machine" "evh_rds_vm" {
  name                            = format("%s-evh-rds-vm", local.project)
  location                        = var.location
  resource_group_name             = azurerm_resource_group.event_rg.name
  network_interface_ids           = [azurerm_network_interface.evh_rds_vm_public.id]
  size                            = var.eventhub_rds_vm.size
  disable_password_authentication = false

  admin_username = "azureuser"
  admin_password = random_password.evh_rds_vm_password.result

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_ZRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = var.tags
}

resource "azurerm_virtual_machine_extension" "evh_rds_vm" {
  name                 = format("%s-evh-rds-vm", local.project)
  virtual_machine_id   = azurerm_linux_virtual_machine.evh_rds_vm.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = jsonencode({
    "script" : base64encode(
      templatefile(
        "./eventhub_rds_vm_script.sh",
        {
          eventhub_fqdn = "${local.project}-eventhub-ns.servicebus.windows.net",
          rds_fqdn      = azurerm_public_ip.evh_rds.fqdn
        }
      )
    )
  })

  tags = var.tags
}

resource "azurerm_network_security_group" "evh_rds_vm" {
  name                = format("%s-evh-rds-vm-nsg", local.project)
  location            = var.location
  resource_group_name = azurerm_resource_group.event_rg.name

  security_rule {
    name                       = "kafka"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "9093"
    source_address_prefix      = length(var.eventhub_rds_vm.allowed_ipaddresses) == 1 ? var.eventhub_rds_vm.allowed_ipaddresses[0] : ""
    source_address_prefixes    = length(var.eventhub_rds_vm.allowed_ipaddresses) > 1 ? var.eventhub_rds_vm.allowed_ipaddresses : []
    destination_address_prefix = "*"
  }

  tags = var.tags
}

resource "azurerm_network_interface_security_group_association" "evh_rds_vm" {
  network_interface_id      = azurerm_network_interface.evh_rds_vm_public.id
  network_security_group_id = azurerm_network_security_group.evh_rds_vm.id
}

#
output "evh_rds_addresses" {
  value = {
    ip    = azurerm_public_ip.evh_rds.ip_address,
    fqdn  = azurerm_public_ip.evh_rds.fqdn,
    ports = "9092,9093"
  }
}
