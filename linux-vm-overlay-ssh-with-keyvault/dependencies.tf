resource "azurerm_virtual_network" "jump-vnet" {
  name = "vm-network"
  location = var.location
  resource_group_name = module.mod_rg.resource_group_name
  address_space = ["10.0.0.0/16"]
  tags = {
    environment = var.environment
  }
}

resource "azurerm_subnet" "jump-snet" {
    name = "vm-subnet"
    resource_group_name = module.mod_rg.resource_group_name
    virtual_network_name = azurerm_virtual_network.jump-vnet.name
    address_prefixes = ["10.0.1.0/24"]
}

# resource "azurerm_network_security_group" "jump-nsg" {
#     name                = "vm-nsg"
#     location            = var.location
#     resource_group_name = module.mod_linux_vm.linux_vm_resource_group_name

#     security_rule {
#         name                       = "allow-ssh"
#         priority                   = 100
#         direction                  = "Inbound"
#         access                     = "Allow"
#         protocol                   = "Tcp"
#         source_port_range          = "*"
#         destination_port_range     = "22"
#         source_address_prefix      = "*"
#         destination_address_prefix = "*"
#     }
# }