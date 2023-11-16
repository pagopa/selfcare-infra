terraform {
  required_version = ">=0.15.3"

  backend "azurerm" {}

  required_providers {
    azurerm = {
      version = "= 2.79.1"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "= 2.5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.18.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.2.0"
    }
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = false
    }
  }
}

provider "kubernetes" {
  config_path = "${var.k8s_kube_config_path_prefix}/config-${local.aks_cluster_name}"
}

provider "helm" {
  kubernetes {
    config_path = "${var.k8s_kube_config_path_prefix}/config-${local.aks_cluster_name}"
  }
}

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}
