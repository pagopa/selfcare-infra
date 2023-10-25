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

variable "env_short" {
  type = string
  validation {
    condition = (
      length(var.env_short) <= 1
    )
    error_message = "Max length is 1 chars."
  }
}

variable "github_federations" {
  type = list(object({
    repository        = string
    credentials_scope = optional(string, "environment")
    subject           = string
  }))
  description = "GitHub Organization, repository name and scope permissions"
}

variable "environment_ci_roles" {
  type = object({
    subscription    = list(string)
    resource_groups = map(list(string))
  })
  description = "GitHub Continous Integration roles"
}

variable "environment_cd_roles" {
  type = object({
    subscription    = list(string)
    resource_groups = map(list(string))
  })
  description = "GitHub Continous Delivery roles"
}

variable "tags" {
  type = map(any)
  default = {
    CreatedBy = "Terraform"
  }
}
