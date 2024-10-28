locals {
  project = "${var.prefix}-${var.env_short}"

  environment = {
    d = "dev"
    u = "uat"
    p = "prod"
  }
}