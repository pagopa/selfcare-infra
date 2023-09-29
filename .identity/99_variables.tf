variable "prefix" {
  type = string
  validation {
    condition = (
      length(var.prefix) <= 8
    )
    error_message = "Max length is 8 chars."
  }
}

variable "location" {
  type        = string
  description = "One of westeurope, northeurope"
}

variable "env" {
  type        = string
  description = "Environment"
}

variable "env_short" {
  type = string
  validation {
    condition = (
      length(var.env_short) <= 1
    )
    error_message = "Max length is 1 chars."
  }
}

variable "location_short" {
  type = string
  validation {
    condition = (
      length(var.location_short) <= 3
    )
    error_message = "Length must be 3 chars."
  }
}

variable "github" {
  type = object({
    org        = string
    repository = string
  })
  description = "GitHub Organization and repository name"
  default = {
    org        = "pagopa"
    repository = "selfcare-infra"
  }
}

variable "environment_ci_roles" {
  type = object({
    subscription = list(string)
  })
  description = "GitHub Continous Integration roles"
}

variable "environment_cd_roles" {
  type = object({
    subscription = list(string)
  })
  description = "GitHub Continous Delivery roles"
}

variable "github-federation" {
  description = "Static GitHub federation data"
  type = object({
    audience = list(string)
    issuer   = string
  })
  default = {
    audience = ["api://AzureADTokenExchange"]
    issuer   = "https://token.actions.githubusercontent.com"
  }
}

variable "tags" {
  type = map(any)
  default = {
    CreatedBy = "Terraform"
  }
}
