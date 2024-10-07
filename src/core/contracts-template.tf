resource "null_resource" "upload_contract_templates" {
  triggers = {
    dir_sha1 = sha1(join("", [for f in fileset("${path.module}/contracts/template", "**") : filesha1("${path.module}/contracts/template/${f}")]))
  }
  provisioner "local-exec" {
    command = <<EOT
              az storage copy \
                --account-name ${module.selc-contracts-storage.name} \
                --account-key "${module.selc-contracts-storage.primary_access_key}" \
                --destination-container ${azurerm_storage_container.selc-contracts-container.name} \
                --source "${path.module}/contracts/" \
                --recursive
          EOT
  }
}

resource "null_resource" "upload_io_contracts" {
  provisioner "local-exec" {
    command = <<EOT
              az storage copy \
                --account-name ${module.selc-contracts-storage.name} \
                --account-key "${module.selc-contracts-storage.primary_access_key}" \
                --destination-container ${azurerm_storage_container.selc-contracts-container.name} \
                --source "${path.module}/contracts_io/" \
                --recursive
          EOT
  }
}
