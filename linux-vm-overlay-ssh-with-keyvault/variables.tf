#
# Global Variables
#

variable "location" {
    description = "Azure region in which instance will be hosted"
    type = string
    default = "eastus"
}

variable "environment" { 
    description = "Name of the workload's environment"
    type = string
    default = "dev"
}

variable "workload_name" { 
    description = "Name of the workload_name"
    type = string
    default = "ssh-keyvault-test"
}

variable "org_name" {
    description = "Name of the organization"
    type = string
    default = "testorg"
}

variable "tags" {
    description = "A map of tags to add to all resources"
    type = map(string)
    default = {}
}

#
# Resource Group Variables
#

variable "enable_resource_locks" {
    description = "(Optional) Enable resource locks, defaut is false. If true, resource locks will be created for the resource group and the storage account."
    type = bool
    default = false
}

variable "lock_level" {
  description = "(Optional) id locks are enabled, Specifies the Level to be used for this Lock."
  type = string
  default = "CanNotDelete"
}

variable "custom_resource_group_name" {
    description = "(Optional) Custom name for the resource group. If not set, the module will generate a name based on the workload_name, environment and org_name."
    type = string
    default = null
}

variable "use_location_short_name" {
    description = "Use short location name in the naming provider to generate default resource name"
    type = bool
    default = false
}


#
# Linux Variables
#

variable "admin_username" {
    description = "The username of the local administrator used for the Virtual Machine"
    default = "azureadmin"
}

variable "virtual_machine_size" {
    description = "The Virtual Machine SKU for the Virtual Machine, default is standard_a2_v2"
    default = "Standard_A2_v2"
}

