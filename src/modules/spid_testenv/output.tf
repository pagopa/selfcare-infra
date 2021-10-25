output "container_id" {
  description = "The id of the spid_testenv container."
  value       = var.enable_spid_test? azurerm_container_group.spid_testenv[0].id : null
}

output "spid_testenv_url" {
  description = "The id of the spid_testenv container."
  value       = var.enable_spid_test? azurerm_container_group.spid_testenv[0].fqdn : null
}
