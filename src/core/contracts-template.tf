resource "null_resource" "upload_contract_templates" {
  triggers = {
    dir_sha1 = sha1(join("", [for f in fileset("${path.module}/contracts_template/contracts/template", "**") : filesha1("${path.module}/contracts_template/contracts/template/${f}")]))
  }
  provisioner "local-exec" {
    command = <<EOT
              az storage copy \
                --account-name "sc${var.env_short}${var.location_short}ardocumentsst01" \
                --connection-string "${data.azurerm_key_vault_secret.selc_documents_storage_connection_string.value}" \
                --destination-container "sc-${var.env_short}-documents-blob" \
                --source "./contracts_template/*" \
                --recursive
          EOT
  }
}
