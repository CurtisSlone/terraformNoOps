data "azurerm_client_config" "current" {}

data "azurerm_key_vault" "remote-backend-keyvault" {
    name = azurerm_key_vault.remote-backend-keyvault.name
    resource_group_name = module.mod_network_artifacts_rg.resource_group_name
}

data "azurerm_key_vault_secret" "storage_account_key" {
    name = azurerm_key_vault_secret.storage_account_key.name
    key_vault_id = azurerm_key_vault.remote-backend-keyvault.id
}