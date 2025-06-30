resource "null_resource" "upload_contract_templates" {
  count        = local.enable_upload_contracts ? 1 : 0
  triggers = {
    dir_sha1 = sha1(join("", [for f in fileset("${path.module}/contracts_template/contracts/template", "**") : filesha1("${path.module}/contracts_template/contracts/template/${f}")]))
  }
  provisioner "local-exec" {
    command = <<EOT
              az storage copy \
                --connection-string '${data.azurerm_key_vault_secret.selc_documents_storage_connection_string.value}' \
                --container 'sc-${var.env_short}-documents-blob' \
                --source "./contracts_template/*" \
                --recursive
          EOT
  }
}

data "azurerm_key_vault_secret" "selc_documents_storage_connection_string" {
  name         = "documents-storage-connection-string"
  key_vault_id = module.key_vault.id
}