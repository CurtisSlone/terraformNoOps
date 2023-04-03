
#
#
# Hub Workload resources
#
#

resource "azurerm_virtual_network" "hub-vnet" {
  name = "hub-vm-network"
  location = var.location
  resource_group_name = module.mod_bastion_rg.resource_group_name
  address_space = ["10.1.0.0/16"]
  tags = {
    environment = "test"
  }
}

resource "azurerm_subnet" "AzureBastionSubnet" {
    name = "hub-vm-subnet"
    resource_group_name = module.mod_bastion_rg.resource_group_name
    virtual_network_name = azurerm_virtual_network.hub-vnet.name
    address_prefixes = ["10.1.1.0/24"]
}

resource "azurerm_public_ip" "bastion-public-ip" {
  name = "bastion-pip"
  location = var.location
  resource_group_name = module.mod_bastion_rg.resource_group_name
  allocation_method = "Static"
  sku = "Standard"
}

resource "azurerm_bastion_host" "hub-bastion" {
  name = "hub-bastion"
  location = var.location
  resource_group_name = module.mod_bastion_rg.resource_group_name
  
  ip_configuration {
    name = "bastion"

# │ Error: The name of the Subnet for "ip_configuration.0.subnet_id" must be exactly 'AzureBastionSubnet' to be used for the Azure Bastion Host resource
# │
# │   with azurerm_bastion_host.hub-bastion,
# │   on resource.dependencies.tf line 40, in resource "azurerm_bastion_host" "hub-bastion":
# │   40:     subnet_id = azurerm_subnet.hub-snet.id

    subnet_id = azurerm_subnet.AzureBastionSubnet.id
    public_ip_address_id = azurerm_public_ip.bastion-public-ip.id
  }
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