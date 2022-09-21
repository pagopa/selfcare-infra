locals {
  resource_groups_name   = format("%s-api-rg", local.project)
  service_name           = format("%s-apim", local.project)
  api_id                 = format("%s-ms-external-api-v1", local.project)
  azure_apim_api_version = "2021-08-01"
}

resource "null_resource" "download_apim_external_api_v1" {
  #triggers = {
  #  file_sha1 = filesha1("./api/ms_external_api/v1/open-api.yml.tpl")
  #}

  #depends_on = [module.apim_external_api_ms_v1]

  provisioner "local-exec" {
    command = <<EOT
      mkdir -p "${path.module}/.terraform/tmp/env/${var.env}/developer/external"
      az rest \
        --method get \
        --url https://management.azure.com/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/${local.resource_groups_name}/providers/Microsoft.ApiManagement/service/${local.service_name}/apis/${local.api_id} \
        --url-parameters api-version=${local.azure_apim_api_version} export=true format=openapi \
 	--output-file ${path.module}/.terraform/tmp/env/${var.env}/developer/external/ms-external-api-v1.yaml
    EOT
  }
}

resource "null_resource" "upload_developer_external_api_v1" {
  triggers = {
  #  file_sha1 = filesha1("./api/ms_external_api/v1/open-api.yml.tpl")
    build_number = "${timestamp()}"
  }

  depends_on = [null_resource.download_apim_external_api_v1]

  provisioner "local-exec" {
    command = <<EOT
              az storage blob upload \
                --container '$web' \
                --account-name ${replace(replace(module.checkout_cdn.name, "-cdn-endpoint", "-sa"), "-", "")} \
                --account-key ${module.checkout_cdn.storage_primary_access_key} \
                --file "${path.module}/.terraform/tmp/env/${var.env}/developer/external/ms-external-api-v1.yaml" \
                --name 'developer/external/ms-external-api-v1.yaml'
              az cdn endpoint purge \
                --resource-group ${azurerm_resource_group.checkout_fe_rg.name} \
                --name ${module.checkout_cdn.name} \
                --profile-name ${replace(module.checkout_cdn.name, "-cdn-endpoint", "-cdn-profile")}  \
                --content-paths "/developer/external/ms-external-api-v1.yaml" \
                --no-wait
          EOT
  }
}

resource "null_resource" "upload_developer_index" {
  triggers = {
    file_sha1 = filesha1("./env/${var.env}/developer/external/index.html")
  }

  provisioner "local-exec" {
    command = <<EOT
              az storage blob upload \
                --container '$web' \
                --account-name ${replace(replace(module.checkout_cdn.name, "-cdn-endpoint", "-sa"), "-", "")} \
                --account-key ${module.checkout_cdn.storage_primary_access_key} \
                --file "./env/${var.env}/developer/external/index.html" \
                --name 'developer/external/index.html'
              az cdn endpoint purge \
                --resource-group ${azurerm_resource_group.checkout_fe_rg.name} \
                --name ${module.checkout_cdn.name} \
                --profile-name ${replace(module.checkout_cdn.name, "-cdn-endpoint", "-cdn-profile")}  \
                --content-paths "/developer/external/index.html" \
                --no-wait
          EOT
  }
}
