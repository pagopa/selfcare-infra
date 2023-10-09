locals {
  project  = "${var.prefix}-${var.env_short}"
  app_name = "github-${var.github.org}-${var.github.repository}-${var.env}"

  state_name     = "tfinf${var.env}${var.prefix}"
  container_name = "terraform-state"

  federation_subject_ci = "repo:${var.github.org}/${var.github.repository}:environment:${upper(var.env)}"
  federation_subject_cd = "repo:${var.github.org}/${var.github.repository}:environment:${upper(var.env)}"
}
