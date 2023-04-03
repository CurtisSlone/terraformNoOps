
#
#
# Hub Workload resources
#
#

resource "azurerm_virtual_network" "hub-vnet" {
  name = "hub-vm-network"
  location = var.location
  resource_group_name = module.mod_bastion_rg.name
  address_space = ["10.1.0.0/16"]
  tags = {
    environment = "test"
  }
}

resource "azurerm_subnet" "hub-snet" {
    name = "hub-vm-subnet"
    resource_group_name = module.mod_bastion_rg.name
    virtual_network_name = azurerm_virtual_network.hub-vnet.name
    address_prefixes = ["10.1.1.0/24"]
}

#
#
# Jump Workload resources
#
#
resource "azurerm_virtual_network" "jump-vnet" {
  name = "jump-vm-network"
  location = var.location
  resource_group_name = module.mod_linux_vm.linux_vm_resource_group_name
  address_space = ["10.0.0.0/16"]
  tags = {
    environment = "test"
  }
}

resource "azurerm_subnet" "jump-snet" {
    name = "jump-vm-subnet"
    resource_group_name = module.mod_linux_vm.linux_vm_resource_group_name
    virtual_network_name = azurerm_virtual_network.jump-vnet.name
    address_prefixes = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "jump-nsg" {
    name                = "vm-nsg"
    location            = var.location
    resource_group_name = module.mod_linux_vm.linux_vm_resource_group_name

    security_rule {
        name                       = "allow-ssh"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
}