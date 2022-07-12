module "key_vault_secrets_query" {
  source = "git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query?ref=v1.0.58"

  resource_group = local.key_vault_resource_group
  key_vault_name = local.key_vault_name

  secrets = [
    "appinsights-instrumentation-key",
    "redis-primary-access-key",
    "jwt-private-key",
    "jwt-public-key",
    "jwt-kid",
    "jwt-exchange-private-key",
    "jwt-exchange-public-key",
    "jwt-exchange-kid",
    "agid-spid-cert",
    "agid-spid-private-key",
    "mongodb-connection-string",
    "postgres-party-user-password",
    "smtp-usr",
    "smtp-psw",
    "smtp-not-pec-usr",
    "smtp-not-pec-psw",
    "contracts-storage-access-key",
    "web-storage-connection-string",
    "logs-storage-connection-string",
    "user-registry-api-key"
  ]
}
