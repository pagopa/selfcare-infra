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

resource "github_branch_protection_v3" "protection_develop" {
  repository = local.github.repository
  branch     = "develop"

  required_pull_request_reviews {
    dismiss_stale_reviews           = true
    require_code_owner_reviews      = true
    required_approving_review_count = 1

    bypass_pull_request_allowances {
      users = []
      teams = []
      apps  = []
    }
  }

  required_status_checks {
    checks = []
  }
}
