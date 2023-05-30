# JWT
module "jwt" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//jwt_keys?ref=v6.14.0"

  jwt_name         = "jwt"
  key_vault_id     = module.key_vault.id
  cert_common_name = "apim"
  cert_password    = ""
  tags             = var.tags
}

module "jwt_exchange" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//jwt_keys?ref=v6.14.0"

  jwt_name         = "jwt-exchange"
  key_vault_id     = module.key_vault.id
  cert_common_name = "selfcare.pagopa.it"
  cert_password    = ""
  tags             = var.tags
}

module "agid_spid" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//jwt_keys?ref=v6.14.0"

  jwt_name         = "agid-spid"
  key_vault_id     = module.key_vault.id
  cert_common_name = "selfcare.pagopa.it"
  cert_password    = ""
  tags             = var.tags
}

resource "null_resource" "upload_jwks" {
  triggers = {
    "changes-in-jwt" : module.jwt.certificate_data_pem
    "changes-in-jwt-exchange" : module.jwt_exchange.certificate_data_pem
  }
  provisioner "local-exec" {
    command = <<EOT
              mkdir -p "${path.module}/.terraform/tmp"
              pip install --require-hashes --requirement "${path.module}/utils/py/requirements.txt"
              az storage blob download \
                --container-name '$web' \
                --account-name ${replace(replace(module.checkout_cdn.name, "-cdn-endpoint", "-sa"), "-", "")} \
                --account-key ${module.checkout_cdn.storage_primary_access_key} \
                --file "${path.module}/.terraform/tmp/oldJwks.json" \
                --name '.well-known/jwks.json'
              python "${path.module}/utils/py/jwksFromPems.py" "${path.module}/.terraform/tmp/oldJwks.json" "${module.jwt.jwt_kid}" "${module.jwt.certificate_data_pem}" "${module.jwt_exchange.jwt_kid}" "${module.jwt_exchange.certificate_data_pem}" > "${path.module}/.terraform/tmp/jwks.json"
              if [ $? -eq 1 ]
              then
                exit 1
              fi
              az storage blob upload \
                --container-name '$web' \
                --account-name ${replace(replace(module.checkout_cdn.name, "-cdn-endpoint", "-sa"), "-", "")} \
                --account-key ${module.checkout_cdn.storage_primary_access_key} \
                --file "${path.module}/.terraform/tmp/jwks.json" \
                --overwrite true \
                --name '.well-known/jwks.json'
              az cdn endpoint purge \
                --resource-group ${azurerm_resource_group.checkout_fe_rg.name} \
                --name ${module.checkout_cdn.name} \
                --profile-name ${replace(module.checkout_cdn.name, "-cdn-endpoint", "-cdn-profile")} \
                --content-paths "/.well-known/jwks.json" \
                --no-wait
          EOT
  }
}

resource "pkcs12_from_pem" "jwt_pkcs12" {
  password        = ""
  cert_pem        = module.jwt.certificate_data_pem
  private_key_pem = module.jwt.jwt_private_key_pem
}

resource "azurerm_api_management_certificate" "jwt_certificate" {
  name                = "jwt-spid-crt"
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
  data                = pkcs12_from_pem.jwt_pkcs12.result
}
