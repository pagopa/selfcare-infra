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

variable "spid_testenv_local_config_dir" {
  type = string
}

variable "hub_spid_login_metadata_url" {
  type = string
}

variable "cidr_subnet_spid_test_env_private" {
  type = list(string)
}

variable "virtual_network_resource_group" {
  type = string
}

variable "virtual_network_name" {
  type = string
}

variable "tags" {
  type = map(any)
}
