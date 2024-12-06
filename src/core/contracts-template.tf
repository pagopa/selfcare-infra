resource "null_resource" "upload_contract_templates" {
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

resource "null_resource" "app_io_premium_plans" {
  # triggers = {
  #   file_sha1 = filesha1("./env/${var.env}/assets/app-io-premium-plans.json")
  # }

  provisioner "local-exec" {
    command = <<EOT
              az storage blob upload \
                --container '$web' \
                --account-name ${replace(replace(module.checkout_cdn.name, "-cdn-endpoint", "-sa"), "-", "")} \
                --account-key ${module.checkout_cdn.storage_primary_access_key} \
                --file "./env/${var.env}/assets/app-io-premium-plans.json" \
                --overwrite true \
                --name 'assets/app-io-premium-plans.json'

              az cdn endpoint purge \
                --resource-group ${azurerm_resource_group.checkout_fe_rg.name} \
                --name ${module.checkout_cdn.name} \
                --profile-name ${replace(module.checkout_cdn.name, "-cdn-endpoint", "-cdn-profile")}  \
                --content-paths "/assets/app-io-premium-plans.json" \
                --no-wait
          EOT
  }
}

