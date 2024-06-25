locals {
  storage_primary_access_key = module.key_vault_secrets_query.values["cdn-storage-access-key"].value
}

resource "null_resource" "upload_assets" {
  triggers = {
    dir_sha1 = sha1(join("", [for f in fileset("${path.module}/assets", "**") : filesha1("${path.module}/assets/${f}")]))
  }
  provisioner "local-exec" {
    command = <<EOT
              az storage blob sync \
                --container '$web' \
                --account-name ${replace(replace(local.cdn_name, "-cdn-endpoint", "-sa"), "-", "")} \
                --account-key ${local.storage_primary_access_key} \
                --source "./assets" \
                --destination 'assets/'

              az cdn endpoint purge \
                --resource-group ${local.cdn_rg_name} \
                --name ${local.cdn_name} \
                --profile-name ${replace(local.cdn_name, "-cdn-endpoint", "-cdn-profile")}  \
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
                --account-name ${replace(replace(local.cdn_name, "-cdn-endpoint", "-sa"), "-", "")} \
                --account-key ${local.storage_primary_access_key} \
                --file "./env/${var.env}/assets/login-alert-message.json" \
                --overwrite true \
                --name 'assets/login-alert-message.json'

              az cdn endpoint purge \
                --resource-group ${local.cdn_rg_name} \
                --name ${local.cdn_name} \
                --profile-name ${replace(local.cdn_name, "-cdn-endpoint", "-cdn-profile")}  \
                --content-paths "/assets/login-alert-message.json" \
                --no-wait
          EOT
  }
}

resource "null_resource" "upload_robots" {
  count = var.env_short == "u" ? 1 : 0

  triggers = {
    file_sha1 = filesha1("./assets/robots.txt")
  }

  provisioner "local-exec" {
    command = <<EOT
              az storage blob upload \
                --container '$web' \
                --account-name ${replace(replace(local.cdn_name, "-cdn-endpoint", "-sa"), "-", "")} \
                --account-key ${local.storage_primary_access_key} \
                --file "./env/${var.env}/assets/robots.txt" \
                --overwrite true \
                --name 'robots.txt'

              az cdn endpoint purge \
                --resource-group ${local.cdn_rg_name} \
                --name ${local.cdn_name} \
                --profile-name ${replace(local.cdn_name, "-cdn-endpoint", "-cdn-profile")}  \
                --content-paths "/robots.txt" \
                --no-wait
          EOT
  }
}