locals {
  project  = "${var.prefix}-${var.env_short}"
  app_name = "github-${var.github.org}-${var.github.repository}-${var.env}"

  security_rg    = "selc-${var.env_short}-sec-rg"
  key_vault_name = "selc-${var.env_short}-kv"

  state_name     = "tfinf${var.env}${var.prefix}"
  container_name = "terraform-state"

  federation_subject_ci = "repo:${var.github.org}/${var.github.repository}:environment:${upper(var.env)}"
  federation_subject_cd = "repo:${var.github.org}/${var.github.repository}:environment:${upper(var.env)}"
}
