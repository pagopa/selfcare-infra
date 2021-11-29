terraform {
  required_providers {
    pkcs12 = {
      source  = "chilicat/pkcs12"
      version = "0.0.7"
    }

  }
}

resource "tls_private_key" "jwt" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "tls_self_signed_cert" "jwt_self" {
  allowed_uses = [
    "crl_signing",
    "data_encipherment",
    "digital_signature",
    "key_agreement",
    "cert_signing",
    "key_encipherment"
  ]
  key_algorithm         = "RSA"
  private_key_pem       = tls_private_key.jwt.private_key_pem
  validity_period_hours = var.cert_validity_hours
  subject {
    common_name = var.cert_common_name
  }
}

resource "pkcs12_from_pem" "jwt_pkcs12" {
  password        = var.cert_password
  cert_pem        = tls_self_signed_cert.jwt_self.cert_pem
  private_key_pem = tls_private_key.jwt.private_key_pem
}

resource "azurerm_key_vault_secret" "jwt_private_key" {
  name         = format("%s-private-key", var.jwt_name)
  value        = tls_private_key.jwt.private_key_pem
  content_type = "text/plain"

  key_vault_id = var.key_vault_id
}

resource "azurerm_key_vault_secret" "jwt_public_key" {
  name         = format("%s-public-key", var.jwt_name)
  value        = tls_private_key.jwt.public_key_pem
  content_type = "text/plain"

  key_vault_id = var.key_vault_id
}

resource "azurerm_key_vault_certificate" "jwt_certificate" {
  name         = format("%s-crt", var.jwt_name)
  key_vault_id = var.key_vault_id

  certificate {
    contents = pkcs12_from_pem.jwt_pkcs12.result
    password = var.cert_password
  }

  # to be provided even if not required due to issue https://github.com/hashicorp/terraform-provider-azurerm/pull/14225
  certificate_policy {
    issuer_parameters {
      name = "Self"
    }

    key_properties {
      exportable = true
      key_size   = 2048
      key_type   = "RSA"
      reuse_key  = true
    }

    secret_properties {
      content_type = "application/x-pkcs12"
    }
  }

  tags = var.tags
}