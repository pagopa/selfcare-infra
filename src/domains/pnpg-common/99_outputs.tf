output "azurerm_api_management_certificate_jwt_certificate_thumbprint" {
  value     = azurerm_api_management_certificate.jwt_certificate.thumbprint
  sensitive = true
}

output "jwt_auth_jwt_kid" {
  value     = module.jwt_auth.jwt_kid
  sensitive = true
}
