# email templates
resource "null_resource" "upload_resources_templates" {
  triggers = {
    dir_sha1 = sha1(join("", [for f in fileset("${path.module}/resources/templates", "**") : filesha1("${path.module}/resources/templates/${f}")]))
  }
  provisioner "local-exec" {
    command = <<EOT
              az storage blob sync --container '$web' \
                --account-name ${replace(replace(module.checkout_cdn.name, "-cdn-endpoint", "-sa"), "-", "")} \
                --account-key ${module.checkout_cdn.storage_primary_access_key} \
                --source "./resources/templates" \
                --destination 'resources/templates/'
              az cdn endpoint purge \
                --resource-group ${azurerm_resource_group.checkout_fe_rg.name} \
                --name ${module.checkout_cdn.name} \
                --profile-name ${replace(module.checkout_cdn.name, "-cdn-endpoint", "-cdn-profile")}  \
                --content-paths "/resources/templates/*" \
                --no-wait
          EOT
  }
}

# default product logo
data "local_file" "resources_default_product_logo" {
  filename = "${path.module}/resources/defaultProductLogo.png"
}

resource "null_resource" "upload_resources_default_product_logo" {
  triggers = {
    "changes-in-config" : md5(data.local_file.resources_default_product_logo.content)
  }

  provisioner "local-exec" {
    command = <<EOT
              az storage blob upload --container '$web' \
                --account-name ${replace(replace(module.checkout_cdn.name, "-cdn-endpoint", "-sa"), "-", "")} \
                --account-key ${module.checkout_cdn.storage_primary_access_key} \
                --file ${data.local_file.resources_default_product_logo.filename} \
                --name resources/products/default/logo.png
          EOT
  }
}

# default product depict-image
data "local_file" "resources_default_product_depict-image" {
  filename = "${path.module}/resources/defaultProductDepictImage.jpeg"
}

resource "null_resource" "upload_resources_default_product_resources_depict-image" {
  triggers = {
    "changes-in-config" : md5(data.local_file.resources_default_product_depict-image.content)
  }

  provisioner "local-exec" {
    command = <<EOT
              az storage blob upload --container '$web' \
                --account-name ${replace(replace(module.checkout_cdn.name, "-cdn-endpoint", "-sa"), "-", "")} \
                --account-key ${module.checkout_cdn.storage_primary_access_key} \
                --file ${data.local_file.resources_default_product_depict-image.filename} \
                --name resources/products/default/depict-image.jpeg
          EOT
  }
}

# uploading a pagopa logo to contract storage
resource "null_resource" "upload_resources_logo" {
  triggers = {
    "changes-in-config" : md5(data.local_file.resources_default_product_logo.content)
  }
  provisioner "local-exec" {
    command = <<EOT
              az storage blob upload --container ${azurerm_storage_container.selc-contracts-container.name} \
                --account-name ${module.selc-contracts-storage.name} \
                --account-key "${module.selc-contracts-storage.primary_access_key}" \
                --file ${data.local_file.resources_default_product_logo.filename} \
                --name resources/logo.png
          EOT
  }
}