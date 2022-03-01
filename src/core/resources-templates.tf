resource "null_resource" "upload_resources_templates" {
  triggers = {
    dir_sha1 = sha1(join("", [for f in fileset("${path.module}/resources_templates", "**") : filesha1("${path.module}/resources_templates/${f}")]))
  }
  provisioner "local-exec" {
    command = <<EOT
              az storage blob sync --container '$web' \
                --account-name ${replace(replace(module.checkout_cdn.name, "-cdn-endpoint", "-sa"), "-", "")} \
                --account-key ${module.checkout_cdn.storage_primary_access_key} -s "./resources_templates" \
                --destination 'resources/templates/'
              az cdn endpoint purge \
                -g ${azurerm_resource_group.checkout_fe_rg.name} \
                -n ${module.checkout_cdn.name} \
                --profile-name ${replace(module.checkout_cdn.name, "-cdn-endpoint", "-cdn-profile")}  \
                --content-paths "/resources/templates/*" \
                --no-wait
          EOT
  }
}
