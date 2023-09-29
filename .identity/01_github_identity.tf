resource "azurerm_resource_group" "identity_rg" {
  name     = "identity-rg"
  location = var.location
}

resource "azurerm_user_assigned_identity" "this_ci" {
  location            = var.location
  name                = "${local.app_name}-ci"
  resource_group_name = azurerm_resource_group.identity_rg.name

  tags = var.tags
}

resource "azurerm_user_assigned_identity" "this_cd" {
  location            = var.location
  name                = "${local.app_name}-cd"
  resource_group_name = azurerm_resource_group.identity_rg.name

  tags = var.tags
}

resource "azurerm_role_assignment" "environment_ci_subscription" {
  for_each             = toset(var.environment_ci_roles.subscription)
  scope                = data.azurerm_subscription.current.id
  role_definition_name = each.key
  principal_id         = azurerm_user_assigned_identity.this_ci.principal_id
}

resource "azurerm_role_assignment" "environment_cd_subscription" {
  for_each             = toset(var.environment_cd_roles.subscription)
  scope                = data.azurerm_subscription.current.id
  role_definition_name = each.key
  principal_id         = azurerm_user_assigned_identity.this_cd.principal_id
}

resource "azurerm_federated_identity_credential" "environment_ci" {
  name                = "${local.project}-github-selfcare-infra-ci"
  resource_group_name = azurerm_resource_group.identity_rg.name
  audience            = var.github-federation.audience
  issuer              = var.github-federation.issuer
  parent_id           = azurerm_user_assigned_identity.this_ci.id
  subject             = local.federation_subject_ci
}

resource "azurerm_federated_identity_credential" "environment_cd" {
  name                = "${local.project}-github-selfcare-infra-cd"
  resource_group_name = azurerm_resource_group.identity_rg.name
  audience            = var.github-federation.audience
  issuer              = var.github-federation.issuer
  parent_id           = azurerm_user_assigned_identity.this_cd.id
  subject             = local.federation_subject_cd
}

output "azure_environment_ci" {
  value = {
    app_name       = azurerm_user_assigned_identity.this_ci.name
    client_id      = azurerm_user_assigned_identity.this_ci.client_id
    application_id = azurerm_user_assigned_identity.this_ci.client_id
    object_id      = azurerm_user_assigned_identity.this_ci.principal_id
  }
}

output "azure_environment_cd" {
  value = {
    app_name       = azurerm_user_assigned_identity.this_cd.name
    client_id      = azurerm_user_assigned_identity.this_cd.client_id
    application_id = azurerm_user_assigned_identity.this_cd.client_id
    object_id      = azurerm_user_assigned_identity.this_cd.principal_id
  }
}
