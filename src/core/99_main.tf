terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 3.116.0"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2.33.0"
    }

    pkcs12 = {
      source  = "chilicat/pkcs12"
      version = "0.0.7"
    }

    random = {
      source  = "hashicorp/random"
      version = "<= 3.5.1"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  skip_provider_registration = true
  features {
    key_vault {
      purge_soft_delete_on_destroy = false
    }
  }
}

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}

# provider "kubernetes" {
#   config_path = "${var.k8s_kube_config_path_prefix}/config-${local.aks_cluster_name}"
# }

# provider "helm" {
#   kubernetes {
#     config_path = "${var.k8s_kube_config_path_prefix}/config-${local.aks_cluster_name}"
#   }
# }
