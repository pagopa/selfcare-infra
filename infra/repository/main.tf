terraform {
  required_version = ">= 1.6.0"

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