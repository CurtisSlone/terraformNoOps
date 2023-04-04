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

output "prod_storage_container" {
  value = azurerm_storage_container.tfremprodsc.name
}