output "vnet_name" {
  value = module.vnet.name
}

output "vnet_address_space" {
  value = module.vnet.address_space
}

output "vnet_integration_name" {
  value = module.vnet_integration.name
}

output "vnet_integration_address_space" {
  value = module.vnet_integration.address_space
}

## Redis cache
output "redis_primary_access_key" {
  value     = module.redis.primary_access_key
  sensitive = true
}

output "redis_hostname" {
  value = module.redis.hostname
}

output "redis_port" {
  value = module.redis.port
}

output "redis_ssl_port" {
  value = module.redis.ssl_port
}

## AKS
output "aks_cluster_name" {
  value = module.aks.name
}

output "aks_fqdn" {
  value = module.aks.fqdn
}

output "aks_private_fqdn" {
  value = module.aks.private_fqdn
}

output "aks_client_certificate" {
  value = module.aks.client_certificate
}

output "aks_kube_config" {
  value     = module.aks.kube_config
  sensitive = true
}

output "aks_outbound_ips" {
  value = azurerm_public_ip.aks_outbound.*.ip_address
}

## key vault ##
output "key_vault_uri" {
  value = module.key_vault.vault_uri
}

output "key_vault_name" {
  value = module.key_vault.name
}

## Container registry ##
output "container_registry_login_server" {
  value = module.acr.login_server
}

output "container_registry_admin_username" {
  value = module.acr.admin_username
}

output "container_registry_admin_password" {
  value     = module.acr.admin_password
  sensitive = true
}

## Api management ##
output "apim_name" {
  value = module.apim.name
}

output "apim_private_ip_addresses" {
  value = module.apim.private_ip_addresses
}

output "apim_public_ip_addresses" {
  value = module.apim.public_ip_addresses
}

output "apim_gateway_url" {
  value = format("https://%s", azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name)
}

output "apim_gateway_hostname" {
  value = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
}

## Application gateway.
output "app_gateway_public_ip" {
  value = azurerm_public_ip.appgateway_public_ip.ip_address
}

output "app_gateway_fqdn" {
  value = azurerm_public_ip.appgateway_public_ip.fqdn
}

output "api_fqdn" {
  value = azurerm_dns_a_record.dns_a_api.fqdn
}

output "reverse_proxy_ip" {
  value = var.reverse_proxy_ip
}
