module "acr" {
  source              = "github.com/pagopa/terraform-azurerm-v4.git//container_registry?ref=v6.6.0"
  name                = replace(format("%s-acr", local.project), "-", "")
  resource_group_name = azurerm_resource_group.rg_aks.name
  location            = azurerm_resource_group.rg_aks.location
  admin_enabled       = false
  sku                 = "Basic"
  
  zone_redundancy_enabled       = false
  private_endpoint_enabled      = false
  public_network_access_enabled = true
  # private_endpoint = {
  #   virtual_network_id   = null
  #   subnet_id            = null
  #   private_dns_zone_ids = [null]    
  # }

  tags = var.tags
}
