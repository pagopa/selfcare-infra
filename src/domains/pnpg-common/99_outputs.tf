output "azurerm_api_management_certificate_jwt_certificate" {
  value     = azurerm_api_management_certificate.jwt_certificate.id
  sensitive = true
}

output "jwt_auth" {
  value     = module.jwt_auth
  sensitive = true
}
