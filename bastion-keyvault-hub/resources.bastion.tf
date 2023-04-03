resource "azurerm_bastion_host" "bastion" {
  name = "hub-bastion-host"
  location = var.location
  resource_group_name = module.mod_bastion_rg.resource_group_name

  ip_configuration {
    name = "configuration"
    subnet_id = azurerm_subnet.hub_subnet.id
    public_ip_address_id = azurerm_public_ip.bastion_pip.id
  }
}