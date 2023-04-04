output "resource_group_name" {
  value = module.mod_network_artifacts_rg.resource_group_name
}

output "storage_account_name" {
  value = azurerm_storage_account.network-artifacts-storage.name
}

output "container_name" {
  value = azurerm_storage_container.network-artifacts-storage-container.name
}

output "storage_account_primary_access_key" {
  value     = azurerm_storage_account.network-artifacts-storage.primary_access_key
  sensitive = true
}

output "objectID" {
  value = data.azurerm_client_config.current.object_id
}