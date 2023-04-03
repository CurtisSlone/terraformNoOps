#
#
# Linux Jumpbox
#
#
#
module "mod_linux_vm" {
    source = "../terraform-azurerm-overlays-linux-virtualmachine"

  depends_on = [
    module.mod_jump_rg
  ]
    # Resource Group, location, VNet, subnet, and NSG details
    create_vm_resource_group = false
    custom_vm_resource_group_name = module.mod_jump_rg.resource_group_name
    location = var.location
    environment = var.environment
    org_name = var.org_name
    workload_name = "jumpbox"
    vm_subnet_id = azurerm_subnet.jump-snet.id
    virtual_machine_name = "linux"

    # Network Seurity group port allow definitions for each Virtual Machine
    # NSG association to be added automatically for all network interfaces.
    # Remove this NSG rules block, if `existing_network_security_group_id` is specified
    attach_existing_network_security_group = true
    existing_network_security_group_id = azurerm_network_security_group.jump-nsg.id


  # This module support multiple Pre-Defined Linux and Windows Distributions.
  # Check the README.md file for more pre-defined images for Ubuntu, Centos, RedHat.
  # Please make sure to use gen2 images supported VM sizes if you use gen2 distributions
  # Specify `disable_password_authentication = false` to create random admin password
  # Specify a valid password with `admin_password` argument to use your own password 
  # To generate SSH key pair, specify `generate_admin_ssh_key = true`
  # To use existing key pair, specify `admin_ssh_key_data` to a valid SSH public key path.
  # Specify instance_count = 1 to create a single instance, or specify a higher number to create multiple instances  
  linux_distribution_name         = "ubuntu1804"
  virtual_machine_size            = var.virtual_machine_size
  admin_username                  = var.admin_username
  admin_password                  = "P@ssw0rd1234"
  aad_ssh_login_enabled           = true
  generate_admin_ssh_key          = false
  admin_ssh_key_data = "./testkeys/public.pem"
  instances_count                 = 1

  # Proxymity placement group, Availability Set and adding Public IP to VM's are optional.
  # remove these argument from module if you dont want to use it.  
  enable_proximity_placement_group = false
  enable_vm_availability_set       = true
  enable_public_ip_address         = false
    # Boot diagnostics to troubleshoot virtual machines, by default uses managed 
    # To use custom storage account, specify `storage_account_name` with a valid name
    # Passing a `null` value will utilize a Managed Storage Account to store Boot Diagnostics
    enable_boot_diagnostics = false
    # storage_account_name    = var.storage_account_name

    # Attach a managed data disk to a Windows/Linux VM's. Possible Storage account type are: 
  # `Standard_LRS`, `StandardSSD_ZRS`, `Premium_LRS`, `Premium_ZRS`, `StandardSSD_LRS`
  # or `UltraSSD_LRS` (UltraSSD_LRS only available in a region that support availability zones)
  # Initialize a new data disk - you need to connect to the VM and run diskmanagemnet or fdisk
  data_disks = {
    disk1 = {
      name                 = "disk1"
      disk_size_gb         = 100
      lun                  = 0
      storage_account_type = "StandardSSD_LRS"
    }
    disk2 = {
      name                 = "disk2"
      disk_size_gb         = 100
      lun                  = 1
      storage_account_type = "StandardSSD_LRS"
    }
  }

  # (Optional) To enable Azure Monitoring and install log analytics agents
  # (Optional) Specify `storage_account_name` to save monitoring logs to storage.   
  # log_analytics_resource_id = azurerm_log_analytics_workspace.log_analytics_workspace.id

  # Deploy log analytics agents to virtual machine. 
  # Log analytics workspace primary shared key required.
  deploy_log_analytics_agent = false
  # log_analytics_workspace_primary_shared_key = azurerm_log_analytics_workspace.log_analytics_workspace.primary_shared_key

  // Tags
  add_tags = merge(var.tags, {
    example = "basic-linux-vm"
  })


}
