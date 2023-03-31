output "resource_group" {
    value = module.mod_rg.resource_group_name
}

output "keyvault_name" {
    value = ""
}

output "subnet" {
  value = azurerm_subnet.jump-snet.name
}
