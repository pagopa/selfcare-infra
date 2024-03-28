variable "project" {
  type        = string
  description = "SelfCare prefix and short environment"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "tags" {
  type        = map(any)
  description = "Resource tags"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group where resources will be created"
}

variable "selc_subnet_id" {
  type        = string
  description = "Id of the subnet to use for SelfCare Container App Environment"
}

variable "pnpg_subnet_id" {
  type        = string
  description = "Id of the subnet to use for PNPG Container App Environment"
}

variable "zone_redundant" {
  type        = bool
  description = "Enable or not the zone redundancy"
}
