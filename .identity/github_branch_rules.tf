resource "github_branch_default" "default_main" {
  repository = local.github.repository
  branch     = "main"
}

resource "github_branch_protection_v3" "protection_main" {
  repository = local.github.repository
  branch     = "main"

  require_conversation_resolution = true
  required_pull_request_reviews {
    dismiss_stale_reviews           = false
    require_code_owner_reviews      = true
    required_approving_review_count = 1
  }

  required_status_checks {
    checks = []
  }
}
