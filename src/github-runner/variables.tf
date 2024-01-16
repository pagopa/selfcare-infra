variable "prefix" {
  type    = string
  default = "selc"

  validation {
    condition = (
      length(var.prefix) < 6
    )
    error_message = "Max length is 6 chars."
  }
}

variable "tags" {
  type = map(any)
  default = {
    CreatedBy = "Terraform"
  }
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

variable "location" {
  type    = string
  default = "westeurope"
}

variable "key_vault" {
  type = object({
    name                = string
    resource_group_name = string
    pat_secret_name     = string
  })
}

variable "networking" {
  type = object({
    vnet_resource_group_name = string
    vnet_name                = string
    subnet_cidr_block        = string
  })
}

variable "law" {
  type = object({
    name                = string
    resource_group_name = string
  })
}
