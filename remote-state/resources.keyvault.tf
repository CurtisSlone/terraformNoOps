
resource "azurerm_key_vault" "remote-backend-keyvault" {
    name = "${lower(var.org_name)}tfmgtkv${random_string.tf-name.result}"
    location = var.location
    resource_group_name = module.mod_network_artifacts_rg.resource_group_name
    sku_name = "standard"
    tenant_id = data.azurerm_client_config.current.tenant_id
}

resource "azurerm_key_vault_access_policy" "keyvault-access-policy" {
        key_vault_id = azurerm_key_vault.remote-backend-keyvault.id
        tenant_id = data.azurerm_client_config.current.tenant_id
        object_id = azuread_group.remote-state-kv-group.id

        key_permissions = [
            "Get",
            "List"
        ]

        secret_permissions = [
            "Set",
            "Get",
            "List"
        ]
}

resource "azurerm_key_vault_secret" "storage_account_key" {
  name = "remote-secret"
  value = azurerm_storage_account.network-artifacts-storage.primary_access_key
  key_vault_id = azurerm_key_vault.remote-backend-keyvault.id
}