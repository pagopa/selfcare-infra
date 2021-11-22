data "local_file" "tc" {
  filename = "${path.module}/assets/tc.pdf"
}
data "local_file" "informativa-privacy" {
  filename = "${path.module}/assets/InformativaPrivacy.pdf"
}


resource "null_resource" "upload_tc" {
  triggers = {
    "changes-in-tc" : md5(data.local_file.tc.content)
    "changes-in-informativa-privacy" : md5(data.local_file.informativa-privacy.content)
  }
  provisioner "local-exec" {
    command = <<EOT
              az storage blob sync \
                --container '$web' \
                --account-name ${replace(replace(module.checkout_cdn.name, "-cdn-endpoint", "-sa"), "-", "")} \
                --account-key ${module.checkout_cdn.storage_primary_access_key} -s "./assets" \
                --destination 'assets/'
              az cdn endpoint purge \
                -g ${azurerm_resource_group.checkout_fe_rg.name} \
                -n ${module.checkout_cdn.name} \
                --profile-name ${replace(module.checkout_cdn.name, "-cdn-endpoint", "-cdn-profile")}  \
                --content-paths "/assets/*" \
                --no-wait
          EOT
  }
}