locals {
  resource_groups_name = format("%s-api-rg", local.project)
  service_name = format("%s-apim", local.project)
  api_id = format("%s-ms-external-api-v1", local.project)
  azure_apim_api_version = "2021-08-01"
}

resource "null_resource" "download_apim_external_api_v1" {
  triggers = {
    build_number = "${timestamp()}"
    # dir_sha1 = sha1(join("", [for f in fileset("./api/ms_external_api", "**") : filesha1("./api/ms_external_api/${f}")]))
  }

  depends_on = [module.apim_external_api_ms_v1]
  # az rest --method get --url "https://management.azure.com/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/selc-d-api-rg/providers/Microsoft.ApiManagement/service/selc-d-apim/apis/selc-d-ms-external-api-v1?api-version=2021-08-01&export=true&format=openapi" --output-file ./env/${var.env}/openapi/ms-external-api-v1.yaml
  
  provisioner "local-exec" {
    command = <<EOT
      az rest \
        --method get \
        --url "https://management.azure.com/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/${local.resource_groups_name}/providers/Microsoft.ApiManagement/service/${local.service_name}/apis/${local.api_id}?api-version=${local.azure_apim_api_version}&export=true&format=openapi" \
        --output-file ./env/${var.env}/developer/external/ms-external-api-v1.yaml
    EOT
  }
}

resource "null_resource" "upload_developer_external_api_v1" {
  triggers = {
    dir_sha1 = sha1(fileexists("./env/${var.env}/developer/external/ms-external-api-v1.yaml") 
      ? filesha1("./env/${var.env}/developer/external/ms-external-api-v1.yaml") 
      : sha1(""))
  }
  
  depends_on = [null_resource.download_apim_external_api_v1]

  provisioner "local-exec" {
    command = <<EOT
              az storage blob sync \
                --container '$web' \
                --account-name ${replace(replace(module.checkout_cdn.name, "-cdn-endpoint", "-sa"), "-", "")} \
                --account-key ${module.checkout_cdn.storage_primary_access_key} \
                --source "./env/${var.env}/developer/external" \
                --destination 'developer/external/'
              az cdn endpoint purge \
                -g ${azurerm_resource_group.checkout_fe_rg.name} \
                -n ${module.checkout_cdn.name} \
                --profile-name ${replace(module.checkout_cdn.name, "-cdn-endpoint", "-cdn-profile")}  \
                --content-paths "/developer/external/*" \
                --no-wait
          EOT
  }
}

resource "null_resource" "upload_developer_index" {
  triggers = {
    dir_sha1 = sha1(filesha1("./env/${var.env}/developer/external/index.html"))
  }
  
  provisioner "local-exec" {
    command = <<EOT
              az storage blob sync \
                --container '$web' \
                --account-name ${replace(replace(module.checkout_cdn.name, "-cdn-endpoint", "-sa"), "-", "")} \
                --account-key ${module.checkout_cdn.storage_primary_access_key} \
                --source "./env/${var.env}/developer/external/index.html" \
                --destination 'developer/external/index.html'
              az cdn endpoint purge \
                -g ${azurerm_resource_group.checkout_fe_rg.name} \
                -n ${module.checkout_cdn.name} \
                --profile-name ${replace(module.checkout_cdn.name, "-cdn-endpoint", "-cdn-profile")}  \
                --content-paths "/developer/external/*" \
                --no-wait
          EOT
  }
}

resource "null_resource" "purge_cdn_developer" {
    provisioner "local-exec" {
    command = <<EOT
              az cdn endpoint purge \
                -g ${azurerm_resource_group.checkout_fe_rg.name} \
                -n ${module.checkout_cdn.name} \
                --profile-name ${replace(module.checkout_cdn.name, "-cdn-endpoint", "-cdn-profile")}  \
                --content-paths "/developer/external/*" \
                --no-wait
          EOT
  }
}

