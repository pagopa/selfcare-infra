# JWT
module "jwt_auth" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//jwt_keys?ref=v5.3.0"

  jwt_name         = "jwt"
  key_vault_id     = module.key_vault_pnpg.id
  cert_common_name = "apim"
  cert_password    = ""
  tags             = var.tags
}

module "jwt_exchange" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//jwt_keys?ref=v5.3.0"

  jwt_name         = "jwt-exchange"
  key_vault_id     = module.key_vault_pnpg.id
  cert_common_name = "pnpg.selfcare.pagopa.it"
  cert_password    = ""
  tags             = var.tags
}

module "agid_spid" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//jwt_keys?ref=refs/remotes/origin/jwt_cert_allowed_uses_as_variable"

  jwt_name                 = "agid-spid"
  key_vault_id             = module.key_vault_pnpg.id
  cert_common_name         = "imprese.notifichedigitali.it"
  cert_password            = ""
  cert_country             = "IT"
  cert_locality            = "Roma"
  cert_organization        = "PagoPA"
  cert_organizational_unit = "PagoPA"
  cert_province            = "RM"
  cert_postal_code         = "00187"
  cert_validity_hours      = 87600
  tags                     = var.tags
  cert_allowed_uses        = []
}

resource "null_resource" "upload_jwks" {
  triggers = {
    "changes-in-jwt" : module.jwt_auth.certificate_data_pem
    "changes-in-jwt-exchange" : module.jwt_exchange.certificate_data_pem
  }
  provisioner "local-exec" {
    command = <<EOT
              mkdir -p "${path.module}/.terraform/tmp"
              pip install --require-hashes --requirement "${path.module}/utils/py/requirements.txt"
              az storage blob download \
                --container-name '$web' \
                --account-name ${replace(replace(module.pnpg_checkout_cdn.name, "-cdn-endpoint", "-sa"), "-", "")} \
                --account-key ${module.pnpg_checkout_cdn.storage_primary_access_key} \
                --file "${path.module}/.terraform/tmp/oldJwks.json" \
                --name '.well-known/jwks.json'
              python "${path.module}/utils/py/jwksFromPems.py" "${path.module}/.terraform/tmp/oldJwks.json" "${module.jwt_auth.jwt_kid}" "${module.jwt_auth.certificate_data_pem}" "${module.jwt_exchange.jwt_kid}" "${module.jwt_exchange.certificate_data_pem}" > "${path.module}/.terraform/tmp/jwks.json"
              if [ $? -eq 1 ]
              then
                exit 1
              fi
              az storage blob upload \
                --container-name '$web' \
                --account-name ${replace(replace(module.pnpg_checkout_cdn.name, "-cdn-endpoint", "-sa"), "-", "")} \
                --account-key ${module.pnpg_checkout_cdn.storage_primary_access_key} \
                --file "${path.module}/.terraform/tmp/jwks.json" \
                --overwrite true \
                --name '.well-known/jwks.json'
              az cdn endpoint purge \
                --resource-group ${azurerm_resource_group.checkout_fe_pnpg_rg.name} \
                --name ${module.pnpg_checkout_cdn.name} \
                --profile-name ${replace(module.pnpg_checkout_cdn.name, "-cdn-endpoint", "-cdn-profile")} \
                --content-paths "/.well-known/jwks.json" \
                --no-wait
          EOT
  }
}

resource "pkcs12_from_pem" "jwt_pkcs12" {
  password        = ""
  cert_pem        = module.jwt_auth.certificate_data_pem
  private_key_pem = module.jwt_auth.jwt_private_key_pem
}

resource "azurerm_api_management_certificate" "jwt_certificate" {
  name                = "jwt-pnpg-spid-crt"
  api_management_name = data.azurerm_api_management.api_management_core.name
  resource_group_name = data.azurerm_api_management.api_management_core.resource_group_name
  data                = pkcs12_from_pem.jwt_pkcs12.result
}
