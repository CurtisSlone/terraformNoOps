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
# Hub Test Spoke Vnet & Subnet
#
resource "azurerm_virtual_network" "test_spoke_vnet" {
  name = "test-spoke"
  address_space = ["10.1.0.0/16"]
  location = var.location
  resource_group_name = module.mod_bastion_rg.resource_group_name
}

resource "azurerm_subnet" "test_spoke_subnet" {
  name = "test-spoke-subnet"
  resource_group_name = module.mod_bastion_rg.name
  virtual_network_name = azurerm_virtual_network.test_spoke_vnet
  address_prefixes = ["10.1.1.0/24"]
}

#
# Hub VNET Peerings
#

resource "azurerm_virtual_network_peering" "hub-to-spoke" {
  name = "hub-to-spoke"
  resource_group_name = module.mod_bastion_rg.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub-vnet
  remote_virtual_network_id = azurerm_virtual_network.test_spoke_vnet.id
}

resource "azurerm_virtual_network_peering" "spoke-to-hub" {
  name = "spoke-to-hub"
  resource_group_name = module.mod_bastion_rg.resource_group_name
  virtual_network_name = azurerm_virtual_network.test_spoke_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.hub-vnet.id
}
