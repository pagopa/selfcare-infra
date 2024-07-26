module "acr" {
  source              = "github.com/pagopa/terraform-azurerm-v3.git//container_registry?ref=v7.50.1"
  count               = contains(["u", "p"], var.env_short) ? 1 : 0
  name                = replace(format("%s-acr", local.project), "-", "")
  resource_group_name = azurerm_resource_group.rg_aks[0].name
  location            = azurerm_resource_group.rg_aks[0].location
  admin_enabled       = false

  private_endpoint = {
    enabled              = false
    private_dns_zone_ids = null
    subnet_id            = null
    virtual_network_id   = null
  }

  tags = var.tags
}

# add the role to the identity the kubernetes cluster was assigned
resource "azurerm_role_assignment" "aks_to_acr" {
  count                = contains(["u", "p"], var.env_short) ? 1 : 0
  scope                = module.acr[0].id
  role_definition_name = "AcrPull"
  principal_id         = module.aks[0].kubelet_identity_id

  depends_on = [
    module.aks,
    module.acr
  ]
}
