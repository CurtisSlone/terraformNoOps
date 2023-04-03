resource "tls_private_key" "bastion_ssh_key" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "azurerm_key_vault" "hub-keyvault" {
    name = "hub-keyvault"
    location = var.location
    resource_group_name = module.mod_bastion_rg.resource_group_name
    sku_name = "standard"
}