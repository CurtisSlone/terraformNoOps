output "resource_group_name" {
  value = module.mod_network_artifacts_rg.resource_group_name
}

output "storage_account_name" {
  value = azurerm_storage_account.network-artifacts-storage.name
}

output "container_name" {
  value = azurerm_storage_container.network-artifacts-storage-container.name
}
