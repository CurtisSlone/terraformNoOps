resource "tls_private_key" "bastion_ssh_key" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "azurerm_key_vault" "hub-keyvault" {
    name = "hub-keyvault-testing-123"
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

#  Error: checking for presence of existing Secret "bastion-ssh-key-private" (Key Vault "https://hub-keyvault-testing-123.vault.azure.net/"): keyvault.BaseClient#GetSecret: Failure responding to request: StatusCode=403 -- Original Error: autorest/azure: Service reticrosoft.com/fwlink/?linkid=2125287" InnerError={"code":"AccessDenied"}
# │
# │   with azurerm_key_vault_secret.bastion_ssh_key_private,
# │   on resources.keyvault.tf line 36, in resource "azurerm_key_vault_secret" "bastion_ssh_key_private":
# │   36: resource "azurerm_key_vault_secret" "bastion_ssh_key_private" {
resource "azurerm_key_vault_secret" "bastion_ssh_key_private" {
    depends_on = [
      tls_private_key.bastion_ssh_key
    ]
  name = "bastion-ssh-key-private"
  value = tls_private_key.bastion_ssh_key.private_key_pem
  key_vault_id = azurerm_key_vault.hub-keyvault.id
}