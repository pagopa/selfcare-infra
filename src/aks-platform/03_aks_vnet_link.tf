#
# Vnet Link
#

# vnet needs a vnet link with aks private dns zone
# aks terraform module doesn't export private dns zone
resource "null_resource" "aks_dns_private_link_to_vnet_core" {

  count = var.aks_enabled && var.aks_private_cluster_enabled ? 1 : 0
  triggers = {
    cluster_name = module.aks[0].name
    vnet_id      = data.azurerm_virtual_network.vnet_core.id
    vnet_name    = data.azurerm_virtual_network.vnet_core.name
  }

  provisioner "local-exec" {
    command = <<EOT
      dns_zone_name=$(az network private-dns zone list --output tsv --query "[?contains(id,'${self.triggers.cluster_name}')].{name:name}")
      dns_zone_resource_group_name=$(az network private-dns zone list --output tsv --query "[?contains(id,'${self.triggers.cluster_name}')].{resourceGroup:resourceGroup}")
      az network private-dns link vnet create \
        --name ${self.triggers.vnet_name} \
        --registration-enabled false \
        --resource-group $dns_zone_resource_group_name \
        --virtual-network ${self.triggers.vnet_id} \
        --zone-name $dns_zone_name
    EOT
  }

  provisioner "local-exec" {
    when    = destroy
    command = <<EOT
      dns_zone_name=$(az network private-dns zone list --output tsv --query "[?contains(id,'${self.triggers.cluster_name}')].{name:name}")
      dns_zone_resource_group_name=$(az network private-dns zone list --output tsv --query "[?contains(id,'${self.triggers.cluster_name}')].{resourceGroup:resourceGroup}")
      az network private-dns link vnet delete \
        --name ${self.triggers.vnet_name} \
        --resource-group $dns_zone_resource_group_name \
        --zone-name $dns_zone_name \
        --yes
    EOT
  }

  depends_on = [
    module.aks
  ]
}

# linking vnet AKS to vnet pair
# resource "null_resource" "aks_dns_private_link_to_vnet_pair" {

#   count = var.aks_enabled && var.aks_private_cluster_enabled ? 1 : 0
#   triggers = {
#     cluster_name = module.aks[0].name
#     vnet_id      = data.azurerm_virtual_network.vnet_pair.id
#     vnet_name    = data.azurerm_virtual_network.vnet_pair.name
#   }

#   provisioner "local-exec" {
#     command = <<EOT
#       dns_zone_name=$(az network private-dns zone list --output tsv --query "[?contains(id,'${self.triggers.cluster_name}')].{name:name}")
#       dns_zone_resource_group_name=$(az network private-dns zone list --output tsv --query "[?contains(id,'${self.triggers.cluster_name}')].{resourceGroup:resourceGroup}")
#       az network private-dns link vnet create \
#         --name ${self.triggers.vnet_name} \
#         --registration-enabled false \
#         --resource-group $dns_zone_resource_group_name \
#         --virtual-network ${self.triggers.vnet_id} \
#         --zone-name $dns_zone_name
#     EOT
#   }

#   provisioner "local-exec" {
#     when    = destroy
#     command = <<EOT
#       dns_zone_name=$(az network private-dns zone list --output tsv --query "[?contains(id,'${self.triggers.cluster_name}')].{name:name}")
#       dns_zone_resource_group_name=$(az network private-dns zone list --output tsv --query "[?contains(id,'${self.triggers.cluster_name}')].{resourceGroup:resourceGroup}")
#       az network private-dns link vnet delete \
#         --name ${self.triggers.vnet_name} \
#         --resource-group $dns_zone_resource_group_name \
#         --zone-name $dns_zone_name \
#         --yes
#     EOT
#   }

#   depends_on = [
#     module.aks
#   ]
# }

module "aks_dns_private_link_to_vnet_pair" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//virtual_network_peering?ref=v6.14.1"

  location = var.location

  source_resource_group_name       = data.azurerm_resource_group.vnet_pair_rg.name
  source_virtual_network_name      = data.azurerm_virtual_network.vnet_pair.name
  source_remote_virtual_network_id = data.azurerm_virtual_network.vnet_pair.id
  source_allow_gateway_transit     = false
  source_use_remote_gateways       = false
  # needed by vpn gateway for enabling routing from vnet to vnet_integration
  source_allow_forwarded_traffic = true

  target_resource_group_name       = data.azurerm_resource_group.vnet_aks_rg.name
  target_virtual_network_name      = data.azurerm_virtual_network.vnet_aks.name
  target_remote_virtual_network_id = data.azurerm_virtual_network.vnet_aks.id
  target_allow_gateway_transit     = true
  target_use_remote_gateways       = false
  target_allow_forwarded_traffic   = true
}