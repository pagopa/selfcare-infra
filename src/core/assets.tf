resource "null_resource" "upload_assets" {
  triggers = {
    dir_sha1 = sha1(join("", [for f in fileset("${path.module}/assets", "**") : filesha1("${path.module}/assets/${f}")]))
  }
  provisioner "local-exec" {
    command = <<EOT
              az storage blob sync \
                --container '$web' \
                --account-name ${replace(replace(module.checkout_cdn.name, "-cdn-endpoint", "-sa"), "-", "")} \
                --account-key ${module.checkout_cdn.storage_primary_access_key} \
                --source "./assets" \
                --destination 'assets/'
              az cdn endpoint purge \
                --resource-group ${azurerm_resource_group.checkout_fe_rg.name} \
                --name ${module.checkout_cdn.name} \
                --profile-name ${replace(module.checkout_cdn.name, "-cdn-endpoint", "-cdn-profile")}  \
                --content-paths "/assets/*" \
                --no-wait
          EOT
  }
}


resource "null_resource" "upload_alert_message" {
  triggers = {
    file_sha1 = filesha1("./env/${var.env}/assets/login-alert-message.json")
  }

  provisioner "local-exec" {
    command = <<EOT
              az storage blob upload \
                --container '$web' \
                --account-name ${replace(replace(module.checkout_cdn.name, "-cdn-endpoint", "-sa"), "-", "")} \
                --account-key ${module.checkout_cdn.storage_primary_access_key} \
                --file "./env/${var.env}/assets/login-alert-message.json" \
                --overwrite true \
                --name 'assets/login-alert-message.json'

              az cdn endpoint purge \
                --resource-group ${azurerm_resource_group.checkout_fe_rg.name} \
                --name ${module.checkout_cdn.name} \
                --profile-name ${replace(module.checkout_cdn.name, "-cdn-endpoint", "-cdn-profile")}  \
                --content-paths "/assets/login-alert-message.json" \
                --no-wait
          EOT
  }
}


resource "null_resource" "upload_spid_idp_status" {
  triggers = {
    file_sha1 = filesha1("./env/${var.env}/assets/spid_idp_status.json")
  }

  provisioner "local-exec" {
    command = <<EOT
              az storage blob upload \
                --container '$web' \
                --account-name ${replace(replace(module.checkout_cdn.name, "-cdn-endpoint", "-sa"), "-", "")} \
                --account-key ${module.checkout_cdn.storage_primary_access_key} \
                --file "./env/${var.env}/assets/spid_idp_status.json" \
                --overwrite true \
                --name 'assets/spid_idp_status.json'

              az cdn endpoint purge \
                --resource-group ${azurerm_resource_group.checkout_fe_rg.name} \
                --name ${module.checkout_cdn.name} \
                --profile-name ${replace(module.checkout_cdn.name, "-cdn-endpoint", "-cdn-profile")}  \
                --content-paths "/assets/spid_idp_status.json" \
                --no-wait
          EOT
  }
}

resource "null_resource" "upload_config" {
  triggers = {
    file_sha1 = filesha1("./env/${var.env}/assets/config.json")
  }

  provisioner "local-exec" {
    command = <<EOT
              az storage blob upload \
                --container '$web' \
                --account-name ${replace(replace(module.checkout_cdn.name, "-cdn-endpoint", "-sa"), "-", "")} \
                --account-key ${module.checkout_cdn.storage_primary_access_key} \
                --file "./env/${var.env}/assets/config.json" \
                --overwrite true \
                --name 'assets/config.json'

              az cdn endpoint purge \
                --resource-group ${azurerm_resource_group.checkout_fe_rg.name} \
                --name ${module.checkout_cdn.name} \
                --profile-name ${replace(module.checkout_cdn.name, "-cdn-endpoint", "-cdn-profile")}  \
                --content-paths "/assets/config.json" \
                --no-wait
          EOT
  }
}