resource "azurerm_resource_group" "rg_aks" {
  name     = "${local.project}-aks-rg"
  location = var.location
  tags     = var.tags
}

module "aks" {
  source = "git::https://github.com/pagopa/azurerm.git//kubernetes_cluster?ref=v1.0.75"

  depends_on = [
    module.k8s_snet,
    azurerm_public_ip.aks_outbound,
  ]

  name                       = "${local.project}-aks"
  location                   = azurerm_resource_group.rg_aks.location
  dns_prefix                 = "${local.project}-aks"
  resource_group_name        = azurerm_resource_group.rg_aks.name
  availability_zones         = var.aks_availability_zones
  kubernetes_version         = var.aks_kubernetes_version
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id

  vm_size                    = var.aks_vm_size
  enable_auto_scaling        = var.aks_enable_auto_scaling
  node_count                 = var.aks_node_count
  min_count                  = var.aks_min_count
  max_count                  = var.aks_max_count
  max_pods                   = var.aks_max_pods
  upgrade_settings_max_surge = var.aks_upgrade_settings_max_surge
  sku_tier                   = var.aks_sku_tier

  private_cluster_enabled = true

  rbac_enabled = true
  aad_admin_group_ids = var.env_short == "d" ? [
    data.azuread_group.adgroup_admin.object_id,
    data.azuread_group.adgroup_developers.object_id,
    data.azuread_group.adgroup_externals.object_id
  ] : [data.azuread_group.adgroup_admin.object_id]

  vnet_id        = module.vnet.id
  vnet_subnet_id = module.k8s_snet.id

  network_profile = {
    docker_bridge_cidr = "172.17.0.1/16"
    dns_service_ip     = "10.2.0.10"
    network_plugin     = "azure"
    network_policy     = "azure"
    outbound_type      = "loadBalancer"
    service_cidr       = "10.2.0.0/16"
  }

  metric_alerts = var.aks_metric_alerts
  action = [
    {
      action_group_id    = azurerm_monitor_action_group.slack.id
      webhook_properties = null
    },
    {
      action_group_id    = azurerm_monitor_action_group.email.id
      webhook_properties = null
    }
  ]

  alerts_enabled = var.aks_alerts_enabled

  outbound_ip_address_ids = azurerm_public_ip.aks_outbound.*.id

  tags = var.tags
}

# k8s cluster subnet
module "k8s_snet" {
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.58"
  name                                           = "${local.project}-k8s-snet"
  address_prefixes                               = var.cidr_subnet_k8s
  resource_group_name                            = azurerm_resource_group.rg_vnet.name
  virtual_network_name                           = module.vnet.name
  enforce_private_link_endpoint_network_policies = true

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.Storage"
  ]
}

resource "azurerm_public_ip" "aks_outbound" {
  count = var.aks_num_outbound_ips

  name                = format("%s-aksoutbound-pip-%02d", local.project, count.index + 1)
  resource_group_name = azurerm_resource_group.rg_vnet.name
  location            = azurerm_resource_group.rg_vnet.location
  sku                 = "Standard"
  allocation_method   = "Static"

  tags = var.tags
}
