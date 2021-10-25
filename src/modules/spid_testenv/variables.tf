# General Variables
variable "location" {
  type = string
}

variable "name" {
  type = string
}

variable "subscription_name" {
  type = string
}

// spid-testenv specific variables
variable "enable_spid_test" {
  type = bool
}

variable "hub_spid_login_metadata_url" {
  type = string
}

variable "tags" {
  type = map(any)
}
