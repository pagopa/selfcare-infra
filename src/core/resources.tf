resource "null_resource" "upload_resources" {
  triggers = {
    dir_sha1 = sha1(join("", [for f in fileset("${path.module}/resources", "**") : filesha1("${path.module}/resources/${f}")]))
  }
  provisioner "local-exec" {
    command = <<EOT
              az storage blob sync \
                --container '$web' \
                --account-name ${replace(replace(module.checkout_cdn.name, "-cdn-endpoint", "-sa"), "-", "")} \
                --account-key ${module.checkout_cdn.storage_primary_access_key} -s "./resources" \
                --destination 'resources/'
              az cdn endpoint purge \
                -g ${azurerm_resource_group.checkout_fe_rg.name} \
                -n ${module.checkout_cdn.name} \
                --profile-name ${replace(module.checkout_cdn.name, "-cdn-endpoint", "-cdn-profile")}  \
                --content-paths "/resources/*" \
                --no-wait
          EOT
  }
}
