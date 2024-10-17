module "acr" {
  source              = "github.com/pagopa/terraform-azurerm-v3.git//container_registry?ref=v7.50.1"
  name                = replace(format("%s-acr", local.project), "-", "")
  resource_group_name = azurerm_resource_group.rg_aks.name
  location            = azurerm_resource_group.rg_aks.location
  admin_enabled       = false

  private_endpoint = {
    enabled              = false
    private_dns_zone_ids = null
    subnet_id            = null
    virtual_network_id   = null
  }

  tags = var.tags
}
