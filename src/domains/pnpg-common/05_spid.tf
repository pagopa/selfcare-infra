module "spid_logs_encryption_keys" {
    source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//jwt_keys?ref=v5.3.0"

  jwt_name         = "spid-logs-encryption"
  key_vault_id     = module.key_vault_pnpg.id
  cert_common_name = "spid-logs"
  cert_password    = ""
  tags             = var.tags
}
