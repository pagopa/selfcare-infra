output "thumbprint" {
  value     = azurerm_key_vault_certificate.jwt_certificate.thumbprint
  sensitive = false
}

output "jwt_private_key_pem" {
  value     = tls_private_key.jwt.private_key_pem
  sensitive = true
}

output "jwt_public_key_pem" {
  value     = tls_private_key.jwt.public_key_pem
}

output "certificate_data_base64" {
  value     = azurerm_key_vault_certificate.jwt_certificate.certificate_data_base64
}

output "certificate_data_pem" {
  value     = format("%s\n%s\n%s", "-----BEGIN CERTIFICATE-----", replace(azurerm_key_vault_certificate.jwt_certificate.certificate_data_base64, "/(.{64})/", "$1\n"), "-----END CERTIFICATE-----")
}