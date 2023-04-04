resource "tls_private_key" "remote_ssh_key" {
  algorithm = "RSA"
  rsa_bits = 4096
}

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
        object_id = data.azurerm_client_config.current.object_id

        key_permissions = [
            "Create",
            "Get",
            "List",
            "Delete",
            "Update",
            "Import"
        ]

        secret_permissions = [
            "Set",
            "Get",
            "List",
            "Delete"
        ]
}

resource "azurerm_key_vault_secret" "_ssh_key_private" {
    depends_on = [
      tls_private_key.remote_ssh_key
    ]
  name = "remote-ssh-key-private"
  value = tls_private_key.remote_ssh_key.private_key_pem
  key_vault_id = azurerm_key_vault.remote-backend-keyvault.id
}