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
  default = "test"
}

variable "org_name" {
  description = "Name of the organization"
  type = string
  default = "testorg"
}

variable "tags" {
    description = "A map of tags to add all resources"
    type = map(string)
    default = {}
}

variable "admin_username" {
  description = "the username of the local administrator used for the Virtual Machine"
  default = "azureadmin"
}

variable "virtual_machine_size" {
  description = "The Virtual Machine SKU for the virtual machine, default is standard_a2_v2"
  default = "Standard_A2_v2"
}