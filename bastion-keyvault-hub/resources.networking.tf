resource "azurerm_virtual_network" "hub-vnet" {
    name = "hub-vnet"
    address_space = ["10.0.0.0/16"]
    location = var.location
    resource_group_name = module.mod_bastion_rg.resource_group_name
}

resource "azurerm_subnet" "hub_subnet" {
  name = "AzureBastionSubnet"
  resource_group_name = module.mod_bastion_rg.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
  address_prefixes = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "bastion_pip" {
  name = "hub-bastion-pip"
  location = var.location
  resource_group_name = module.mod_bastion_rg.resource_group_name
  allocation_method = "Static"
  sku = "Standard"
}