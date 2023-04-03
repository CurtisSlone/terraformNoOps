#
# Hub VNET
#

resource "azurerm_virtual_network" "hub-vnet" {
    name = "hub-vnet"
    address_space = ["10.0.0.0/16"]
    location = var.location
    resource_group_name = module.mod_bastion_rg.resource_group_name
}

#
# Hub SNET
#
resource "azurerm_subnet" "hub_subnet" {
  name = "AzureBastionSubnet"
  resource_group_name = module.mod_bastion_rg.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
  address_prefixes = ["10.0.1.0/24"]
}

#
# Bastion Public IP
#
resource "azurerm_public_ip" "bastion_pip" {
  name = "hub-bastion-pip"
  location = var.location
  resource_group_name = module.mod_bastion_rg.resource_group_name
  allocation_method = "Static"
  sku = "Standard"
}

#
# Hub NSG
#
resource "azurerm_network_security_group" "bastion_nsg" {
  name = "bastion-nsg"
  location = var.location
  resource_group_name = module.mod_bastion_rg.resource_group_name
}

#
# Hub NSG Rule
#
resource "azurerm_network_security_rule" "bastion_access" {
  name = "AllowBastionAccess"
  priority = 100
  direction = "Inbound"
  access = "Allow"
  protocol = "Tcp"
  source_port_range = "*"
  destination_port_range = "22"
  source_address_prefix = "VirtualNetwork"
  destination_address_prefix = "*"
  resource_group_name = module.mod_bastion_rg.resource_group_name
  network_security_group_name = azurerm_network_security_group.bastion_nsg.name
}

#
# Hub Test Spoke Vnet
#

#
# Hub VNET Peerings
#

