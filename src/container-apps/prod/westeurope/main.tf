terraform {

  backend "azurerm" {
    resource_group_name  = "io-infra-rg"
    storage_account_name = "selcpstinfraterraform"
    container_name       = "azurermstate"
    key                  = "selfcare-infra.container-apps.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 3.97.1"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "selc_container_app_rg" {
  name     = "${local.project}-container-app-rg"
  location = local.location

  tags = local.tags
}

resource "azurerm_resource_group" "selc_cae_rg" {
  name     = "${local.project}-container-app-002-rg"
  location = local.location

  tags = local.tags
}

module "networking" {
  source = "../../_modules/networking"

  project = local.project

  # inferred from vnet-common with cidr 10.1.0.0/16
  # https://github.com/pagopa/selfcare-infra/blob/9de7d03852904c1e743684a9edd40ae9df0645a8/src/core/01_network_0.tf#L9-L10
  cidr_subnet_selc_cae = "10.1.148.0/23"
  cidr_subnet_pnpg_cae = "10.1.156.0/23"

  selc_container_app_name_snet = "${local.project}-cae-002-snet"
  pnpg_container_app_name_snet = "${local.project}-pnpg-cae-cp-snet"

  pnpg_delegation = []

  tags = local.tags
}

module "container_app_environments" {
  source = "../../_modules/container_app_environments"

  project                  = local.project
  location                 = local.location
  selc_resource_group_name = azurerm_resource_group.selc_cae_rg.name
  pnpg_resource_group_name = azurerm_resource_group.selc_container_app_rg.name

  selc_subnet_id = module.networking.subnet_selfcare.id
  pnpg_subnet_id = module.networking.subnet_pnpg.id

  selc_cae_name = "${local.project}-cae-002"
  pnpg_cae_name = "${local.project}-pnpg-cae-cp"

  pnpg_workload_profiles = []

  zone_redundant = true

  tags = local.tags
}
