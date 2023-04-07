resource "azurerm_key_vault" "tfstatekv" {
  name = "tfstatekv${random_string.tf-name.result}"
  location = var.location
  resource_group_name = module.mod_network_artifacts_rg.resource_group_name
  sku_name = "standard"
  tenant_id = data.azurerm_client_config.current.tenant_id
  enabled_for_disk_encryption = false
  purge_protection_enabled = false
}

resource "azurerm_key_vault_access_policy" "spnpolicy" {
  
    key_vault_id = azurerm_key_vault.tfstatekv.id
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = azuread_service_principal.GHASPN.id
    
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

resource "azurerm_key_vault_access_policy" "current" {
  
    key_vault_id = azurerm_key_vault.tfstatekv.id
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azuread_client_config.current.object_id

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

resource "azurerm_key_vault_secret" "tfstatekvsecret" {
  depends_on = [
    azurerm_key_vault_access_policy.current,
    azurerm_key_vault_access_policy.spnpolicy
  ]
  name = "tfstatesakey"
  value = azurerm_storage_account.tfstatesa.primary_access_key
  key_vault_id = azurerm_key_vault.tfstatekv.id
}