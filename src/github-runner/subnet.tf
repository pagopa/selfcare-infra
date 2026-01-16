module "subnet_runner" {
  source = "github.com/pagopa/terraform-azurerm-v4.git//subnet?ref=v8.2.0"

  name                 = "${local.project}-github-runner-snet"
  resource_group_name  = var.networking.vnet_resource_group_name
  virtual_network_name = var.networking.vnet_name

  address_prefixes = [
    "${var.networking.subnet_cidr_block}"
  ]

  service_endpoints = [
    "Microsoft.Storage",
  ]

  private_endpoint_network_policies = "Enabled"
}


# data "azurerm_subnet" "documents_snet" {
#   name                 = "${local.project}-documents-snet"
#   virtual_network_name = var.networking.vnet_name
#   resource_group_name  = var.networking.vnet_resource_group_name
# }

# resource "azurerm_private_endpoint" "contracts_storage" {
#   name                = "${local.project}-documents-storage-pe"
#   location            = var.location
#   resource_group_name = "${local.project}-documents-storage-rg"
#   subnet_id           = data.azurerm_subnet.documents_snet.id

#   private_service_connection {
#     name                           = format("%s-documents_storage-private-endpoint", local.project)
#     private_connection_resource_id = module.selc-documents-storage.id
#     is_manual_connection           = false
#     subresource_names              = ["Blob"]
#   }

#   private_dns_zone_group {
#     name                 = "private-dns-zone-group"
#     private_dns_zone_ids = [azurerm_private_dns_zone.privatelink_blob_core_windows_net.id]
#   }
# }

