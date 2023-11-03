terraform {
  backend "azurerm" {
    resource_group_name = "dev-andreag"
    storage_account_name = "tfstatecrossstg01"
    container_name = "tfcontainer"
    key = "terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 3.45.0"
    }
  }
}

provider "azurerm" {
  features {
  }
}

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}

data "azurerm_storage_account" "storage_account" {
  resource_group_name = "dev-andreag"
  name                = "tfstatecrossstg01"
}


resource "azurerm_role_assignment" "storage_account_assignments" {
  scope                = data.azurerm_storage_account.storage_account.id
  role_definition_name = "Contributor"

  principal_id         = "06d0d1fd-1b1f-4722-bed6-32ed539091db"
}

resource "azurerm_role_assignment" "vm_assignments" {
  scope                = data.azurerm_storage_account.storage_account.id
  role_definition_name = "Contributor"

  principal_id         = "7cb9a716-2058-45e3-baee-fd3726ed0170"
}
