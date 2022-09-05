locals {
  resource_groups_name = format("%s-api-rg", local.project)
  service_name = format("%s-apim", local.project)
  api_id = format("%s-ms-external-api-v1", local.project)
  azure_apim_api_version = "2021-08-01"
}

resource "null_resource" "read_apim_api" {
  triggers = {
    #build_number = "${timestamp()}"
    dir_sha1 = sha1(join("", [for f in fileset(format("./api/ms_external_api", var.env), "**") : filesha1("./api/ms_external_api/${f}")]))
  }

  depends_on = [module.apim_external_api_ms_v1]
  # az rest --method get --url "https://management.azure.com/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/selc-d-api-rg/providers/Microsoft.ApiManagement/service/selc-d-apim/apis/selc-d-ms-external-api-v1?api-version=2021-08-01&export=true&format=openapi" --output-file ./env/${var.env}/openapi/ms-external-api-v1.yaml
  
  provisioner "local-exec" {
    command = <<EOT
      az rest \
        --method get \
        --url "https://management.azure.com/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/${local.resource_groups_name}/providers/Microsoft.ApiManagement/service/${local.service_name}/apis/${local.api_id}?api-version=${local.azure_apim_api_version}&export=true&format=openapi" \
        --output-file ./env/${var.env}/openapi/ms-external-api-v1.yaml
    EOT
  }
}

resource "null_resource" "upload_developer_index" {
  triggers = {
    dir_sha1 = sha1(join("", [for f in fileset(format("./env/%s/openapi", var.env), "**") : filesha1("./env/${var.env}/openapi/${f}")]))
  }
  
  depends_on = [null_resource.read_apim_api]

  provisioner "local-exec" {
    command = <<EOT
              az storage blob sync \
                --container '$web' \
                --account-name ${replace(replace(module.checkout_cdn.name, "-cdn-endpoint", "-sa"), "-", "")} \
                --account-key ${module.checkout_cdn.storage_primary_access_key} \
                --source "./env/${var.env}/openapi" \
                --destination 'openapi/'
              az cdn endpoint purge \
                -g ${azurerm_resource_group.checkout_fe_rg.name} \
                -n ${module.checkout_cdn.name} \
                --profile-name ${replace(module.checkout_cdn.name, "-cdn-endpoint", "-cdn-profile")}  \
                --content-paths "/openapi/*" \
                --no-wait
          EOT
  }
}


