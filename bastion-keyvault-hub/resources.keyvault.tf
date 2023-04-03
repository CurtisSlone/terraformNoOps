resource "tls_private_key" "bastion_ssh_key" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "azurerm_key_vault" "hub-keyvault" {
    name = "hub-keyvault"
    location = var.location
    resource_group_name = module.mod_bastion_rg.resource_group_name
    sku_name = "standard"
    tenant_id = data.azurerm_client_config.current.tenant_id
}

resource "azurerm_key_vault_access_policy" "keyvault-access-policy" {
        key_vault_id = azurerm_key_vault.hub-keyvault.id
        tenant_id = data.azurerm_client_config.current.tenant_id
        object_id = data.azurerm_client_config.current.object_id

        key_permissions = [
            "create",
            "get",
            "list",
            "delete",
            "update",
            "import"
        ]

        secret_permissions = [
            "set",
            "get",
            "list",
            "delete"
        ]
}

resource "azurerm_key_vault_secret" "bastion_ssh_key_private" {
  name = "bastion-ssh-key-private"
  value = tls_private_key.bastion_ssh_key.private_key_pem
  key_vault_id = azurerm_key_vault.hub-keyvault.id
}