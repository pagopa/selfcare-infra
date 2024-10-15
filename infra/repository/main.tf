terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 3.111.0"
    }
    github = {
      source  = "integrations/github"
      version = "5.45.0"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  subscription_id = local.subscription_id_prod

  features {
    subscription {
      prevent_cancellation_on_destroy = false
    }
  }
}

module "repository" {
  source = "github.com/pagopa/selfcare-commons//infra/terraform-modules/github_repository_settings?ref=main"

  github = {
    repository = "selfcare-infra"
  }
}