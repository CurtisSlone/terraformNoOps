#
# Jumpbox Outputs
#

output "linux_public_ip" {
  value = module.mod_linux_vm.linux_vm_public_ips
}

output "jump_resource_group_name" {
  value = module.mod_linux_vm.linux_vm_resource_group_name
}

output "jump_network_security_group" {
  value = module.mod_linux_vm.network_security_group_ids
}

#
# Bastion Outputs
#

