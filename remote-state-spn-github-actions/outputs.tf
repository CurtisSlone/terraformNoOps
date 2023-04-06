output "resource_group_name" {
  value = module.mod_network_artifacts_rg.resource_group_name
}

output "storage_account_name" {
  value = azurerm_storage_account.tfstatesa.name
}

output "container_name" {
  value = azurerm_storage_container.tfremdevsc.name
}

output "dev_storage_container" {
  value = azurerm_storage_container.tfremdevsc.name
}

output "access_key" {
  value = azurerm_storage_account.tfstatesa.primary_access_key
  sensitive = true
}

output "object_id" {
  value = data.azurerm_client_config.current.object_id
}