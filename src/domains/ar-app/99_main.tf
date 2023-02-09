terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.40.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "= 2.33.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "= 3.2.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "= 2.17.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "= 2.8.0"
    }
    local = {
      source = "hashicorp/local"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}

provider "kubernetes" {
  config_path = "${var.k8s_kube_config_path_prefix}/config-${var.aks_name}"
}

provider "helm" {
  kubernetes {
    config_path = "${var.k8s_kube_config_path_prefix}/config-${var.aks_name}"
  }
}
