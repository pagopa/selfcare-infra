resource "github_repository_environment" "github_repository_environment_cd" {
  environment = "${var.env}-cd"
  repository  = local.github.repository

  dynamic "reviewers" {
    for_each = (var.github_repository_environment_cd.reviewers_teams == null ? [] : [1])
    content {
      teams = matchkeys(
        data.github_organization_teams.all.teams[*].id,
        data.github_organization_teams.all.teams[*].slug,
        var.github_repository_environment_cd.reviewers_teams
      )
    }
  }

  dynamic "deployment_branch_policy" {
    for_each = local.github.cd_branch_policy_enabled == true ? [1] : []

    content {
      protected_branches     = var.github_repository_environment_cd.protected_branches
      custom_branch_policies = var.github_repository_environment_cd.custom_branch_policies
    }
  }
}

resource "github_repository_environment_deployment_policy" "cd_deployment_policy" {
  count = var.github_repository_environment_cd.branch_pattern == null ? 0 : 1

  repository     = local.github.repository
  environment    = github_repository_environment.github_repository_environment_cd.environment
  branch_pattern = var.github_repository_environment_cd.branch_pattern
}

resource "github_actions_environment_secret" "env_cd_secrets" {
  for_each        = local.env_cd_secrets
  repository      = local.github.repository
  environment     = github_repository_environment.github_repository_environment_cd.environment
  secret_name     = each.key
  plaintext_value = each.value
}
