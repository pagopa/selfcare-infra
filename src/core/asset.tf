## Terms and Conditions
data "local_file" "tc" {
  filename = "${path.module}/assets/tc.pdf"
}
resource "null_resource" "upload_tc" {
  triggers = {
    "changes-in-config" : md5(data.local_file.tc.content)
  }
  provisioner "local-exec" {
    command = <<EOT
              az config set extension.use_dynamic_install=yes_without_prompt
              az storage azcopy blob upload \
                 --account-name ${replace(replace(module.checkout_cdn.name, "-cdn-endpoint", "-sa"), "-", "")} \
                 --account-key ${module.checkout_cdn.storage_primary_access_key} \
                 --container '$web' \
                 --destination 'assets/' \
                 --source "${path.module}/assets/tc.pdf"
              az cdn endpoint purge -g ${azurerm_resource_group.checkout_fe_rg.name} -n ${module.checkout_cdn.name} \
                 --profile-name ${replace(module.checkout_cdn.name, "-cdn-endpoint", "-cdn-profile")} \
                 --content-paths "/assets/tc.pdf" \
                 --no-wait
          EOT
  }
}

## Informativa Privacy
data "local_file" "informativa-privacy" {
  filename = "${path.module}/assets/InformativaPrivacy.pdf"
}
resource "null_resource" "upload_informativa-privacy" {
  triggers = {
    "changes-in-config" : md5(data.local_file.informativa-privacy.content)
  }
  provisioner "local-exec" {
    command = <<EOT
              az config set extension.use_dynamic_install=yes_without_prompt
              az storage azcopy blob upload \
                 --account-name ${replace(replace(module.checkout_cdn.name, "-cdn-endpoint", "-sa"), "-", "")} \
                 --account-key ${module.checkout_cdn.storage_primary_access_key} \
                 --container '$web' \
                 --destination 'assets/' \
                 --source "${path.module}/assets/InformativaPrivacy.pdf"
              az cdn endpoint purge -g ${azurerm_resource_group.checkout_fe_rg.name} -n ${module.checkout_cdn.name} \
                 --profile-name ${replace(module.checkout_cdn.name, "-cdn-endpoint", "-cdn-profile")} \
                 --content-paths "/assets/InformativaPrivacy.pdf" \
                 --no-wait
          EOT
  }
}