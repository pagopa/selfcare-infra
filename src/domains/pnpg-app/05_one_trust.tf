resource "null_resource" "upload_one_trust" {
  triggers = {
    dir_sha1 = sha1(join("", [for f in fileset(format("./env/%s/oneTrust", var.env), "**") : filesha1("./env/${var.env}/oneTrust/${f}")]))
  }
  provisioner "local-exec" {
    command = <<EOT
              az storage blob sync \
                --container '$web' \
                --account-name ${replace(replace(local.cdn_name, "-cdn-endpoint", "-sa"), "-", "")} \
                --account-key ${local.storage_primary_access_key} \
                --source "./env/${var.env}/oneTrust" \
                --destination 'ot/' \
              && \
              az cdn endpoint purge \
                -g ${local.cdn_rg_name} \
                -n ${local.cdn_name} \
                --profile-name ${replace(local.cdn_name, "-cdn-endpoint", "-cdn-profile")}  \
                --content-paths "/ot/*" \
                --no-wait
          EOT
  }
}
