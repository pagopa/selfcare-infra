resource "null_resource" "upload_contract_templates" {
  triggers = {
    dir_sha1 = sha1(join("", [for f in fileset("${path.module}/contracts_template", "**") : filesha1("${path.module}/contracts_template/${f}")]))
  }
  provisioner "local-exec" {
    command = <<EOT
              az storage blob sync --container ${azurerm_storage_container.selc-contracts-container.name} \
                  --account-name ${module.selc-contracts-storage.name} \
                  --account-key "${module.selc-contracts-storyesage.primary_access_key}" \
                  --source "${path.module}/contracts_template/" \
                  --destination contracts/template/
                  --delete-destination false
          EOT
  }
}
