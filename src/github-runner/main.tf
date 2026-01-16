terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 4.27.0"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}
