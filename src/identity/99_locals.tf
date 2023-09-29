locals {
  project  = "${var.prefix}-${var.env_short}"
  app_name = "github-${var.github.org}-${var.github.repository}-${var.env}"

  federation_subject_ci = "repo:${var.github.org}/${var.github.repository}:environment:${var.env}-ci"
  federation_subject_cd = "repo:${var.github.org}/${var.github.repository}:environment:${var.env}-cd"
}
