resource "azurerm_key_vault" "tfstatekv" {
  name = "tfstatekv${random_string.tf-name.result}"
  location = var.location
  resource_group_name = module.mod_network_artifacts_rg.resource_group_name
  sku_name = "standard"
  tenant_id = data.azurerm_client_config.current.tenant_id
  enabled_for_disk_encryption = false
  purge_protection_enabled = false
  access_policy {
    
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id
    
    key_permissions = [
        "Get",
        "List",
        "Create",
        "Delete",
        "Purge"
    ]
    secret_permissions = [
        "Get",
        "List",
        "Set",
        "Delete",
        "Purge",
        "Recover"

        ]

        storage_permissions = [
        "Get",
        "GetSAS",
        "SetSAS",
        "Delete",
        "Purge"

        ]
  }
}


resource "azurerm_key_vault_secret" "tfstatekvsecret" {
  name = "tfstatesakey"
  value = azurerm_storage_account.tfstatesa.primary_access_key
  key_vault_id = azurerm_key_vault.tfstatekv.id
}