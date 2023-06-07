#
# Vnet Link
#

# vnet needs a vnet link with aks private dns zone
# aks terraform module doesn't export private dns zone
# linking vnet AKS to vnet pair
data "external" "get_dns_zone" {
  program = ["bash", "-c", <<-EOH
    dns_zone_name=$(az network private-dns zone list --output tsv --query "[?contains(id,'${module.aks[0].name}')].{name:name}")
    dns_zone_resource_group_name=$(az network private-dns zone list --output tsv --query "[?contains(id,'${module.aks[0].name}')].{resourceGroup:resourceGroup}")
    echo "{\"dns_zone_name\": \"$dns_zone_name\", \"dns_zone_resource_group_name\": \"$dns_zone_resource_group_name\"}"
  EOH
  ]
}
resource "azurerm_private_dns_zone_virtual_network_link" "aks_dns_private_link_to_vnet_core" {
  name                  = data.azurerm_virtual_network.vnet_core.name
  resource_group_name   = data.external.get_dns_zone.result["dns_zone_resource_group_name"]
  private_dns_zone_name = data.external.get_dns_zone.result["dns_zone_name"]
  virtual_network_id    = data.azurerm_virtual_network.vnet_core.id

  depends_on = [module.aks]
}

# linking vnet AKS to vnet pair
resource "azurerm_private_dns_zone_virtual_network_link" "aks_dns_private_link_to_vnet_pair" {
  name                  = data.azurerm_virtual_network.vnet_pair.name
  resource_group_name   = data.external.get_dns_zone.result["dns_zone_resource_group_name"]
  private_dns_zone_name = data.external.get_dns_zone.result["dns_zone_name"]
  virtual_network_id    = data.azurerm_virtual_network.vnet_pair.id

  depends_on = [module.aks]
}


