variable "project" {
  type        = string
  description = "SelfCare prefix and short environment"
}

variable "tags" {
  type        = map(any)
  description = "Resource tags"
}

variable "cidr_subnet_selc_cae" {
  type        = string
  description = "CIDR block for SelfCare ContainerAppEnvironment subnet"
}

variable "cidr_subnet_pnpg_cae" {
  type        = string
  description = "CIDR block for PNPG ContainerAppEnvironment subnet"
}
