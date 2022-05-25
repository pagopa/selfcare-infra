resource "null_resource" "upload_one_trust" {
  triggers = {
    dir_sha1 = sha1(join("", [for f in fileset(format("./env/%s/oneTrust", var.env), "**") : filesha1("./env/${var.env}/oneTrust/${f}")]))
  }
  provisioner "local-exec" {
    command = <<EOT
              az storage blob sync \
                --container '$web' \
                --account-name ${replace(replace(module.checkout_cdn.name, "-cdn-endpoint", "-sa"), "-", "")} \
                --account-key ${module.checkout_cdn.storage_primary_access_key}
                --source "./env/${var.env}/oneTrust" \
                --destination 'ot/'
              az cdn endpoint purge \
                -g ${azurerm_resource_group.checkout_fe_rg.name} \
                -n ${module.checkout_cdn.name} \
                --profile-name ${replace(module.checkout_cdn.name, "-cdn-endpoint", "-cdn-profile")}  \
                --content-paths "/ot/*" \
                --no-wait
          EOT
  }
}
