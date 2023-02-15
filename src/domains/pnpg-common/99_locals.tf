locals {
  product = "${var.prefix}-${var.env_short}"
  project = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"

  vnet_core_name                = "${local.product}-vnet"
  vnet_core_resource_group_name = "${local.product}-vnet-rg"

  container_registry_common_name    = "${local.project}-common-acr"
  rg_container_registry_common_name = "${local.project}-docker-rg"
}
