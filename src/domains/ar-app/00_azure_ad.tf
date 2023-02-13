data "azuread_group" "adgroup_externals" {
  display_name = format("%s-adgroup-externals", local.project)
}

data "azuread_group" "adgroup_developers" {
  display_name = format("%s-adgroup-developers", local.project)
}

data "azuread_group" "adgroup_security" {
  display_name = format("%s-adgroup-security", local.project)
}

data "azuread_group" "adgroup_operations" {
  display_name = format("%s-adgroup-operations", local.project)
}

data "azuread_group" "adgroup_technical_project_managers" {
  display_name = format("%s-adgroup-technical-project-managers", local.project)
}
