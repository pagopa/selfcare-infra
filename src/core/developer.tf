resource "null_resource" "upload_developer_index" {
  triggers = {
    dir_sha1 = sha1(join("", [for f in fileset(format("./env/%s/developer", var.env), "**") : filesha1("./env/${var.env}/developer/${f}")]))
  }
  provisioner "local-exec" {
    command = <<EOT
              az storage blob sync \
                --container '$web' \
                --account-name ${replace(replace(module.checkout_cdn.name, "-cdn-endpoint", "-sa"), "-", "")} \
                --account-key ${module.checkout_cdn.storage_primary_access_key} \
                --source "./env/${var.env}/developer" \
                --destination 'developer/'
              az cdn endpoint purge \
                -g ${azurerm_resource_group.checkout_fe_rg.name} \
                -n ${module.checkout_cdn.name} \
                --profile-name ${replace(module.checkout_cdn.name, "-cdn-endpoint", "-cdn-profile")}  \
                --content-paths "/developer/*" \
                --no-wait
          EOT
  }
}
