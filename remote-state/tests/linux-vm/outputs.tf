output "public_ip" {
  value = module.mod_linux_vm.linux_vm_public_ips
}

output "resource_group_name" {
  value = module.mod_linux_vm.linux_vm_resource_group_name
}

output "network_security_group" {
  value = module.mod_linux_vm.network_security_group_ids
}