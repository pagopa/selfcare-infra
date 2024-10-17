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

variable "selc_resource_group_name" {
  type        = string
  description = "Name of the Selfcare resource group where resources will be created"
}

variable "pnpg_resource_group_name" {
  type        = string
  description = "Name of the PNPG resource group where resources will be created"
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

variable "selc_cae_name" {
  type        = string
  description = "Name of selc Container App env"
}

variable "pnpg_cae_name" {
  type        = string
  description = "Name of Container App env"
}

variable "selc_workload_profiles" {
  description = "SELC workload profiles"
  type = list(object({
    name                  = string
    workload_profile_type = string
    minimum_count         = number
    maximum_count         = number
  }))
  default = [
    {
      name                  = "Consumption"
      workload_profile_type = "Consumption"
      minimum_count         = 0
      maximum_count         = 1
    }
  ]
}

variable "pnpg_workload_profiles" {
  description = "PNPG workload profiles"
  type = list(object({
    name                  = string
    workload_profile_type = string
    minimum_count         = number
    maximum_count         = number
  }))
  default = [
    {
      name                  = "Consumption"
      workload_profile_type = "Consumption"
      minimum_count         = 0
      maximum_count         = 1
    }
  ]
}
