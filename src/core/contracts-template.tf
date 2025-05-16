resource "null_resource" "upload_contract_templates" {
  count        = local.enable_upload_contracts ? 1 : 0
  triggers = {
    dir_sha1 = sha1(join("", [for f in fileset("${path.module}/contracts_template/contracts/template", "**") : filesha1("${path.module}/contracts_template/contracts/template/${f}")]))
  }
  provisioner "local-exec" {
    command = <<EOT
              az storage copy \
                --account-name ${module.selc-contracts-storage.name} \
                --account-key "${module.selc-contracts-storage.primary_access_key}" \
                --destination-container ${azurerm_storage_container.selc-contracts-container.name} \
                --source "./contracts_template/*" \
                --recursive
          EOT
  }
}

