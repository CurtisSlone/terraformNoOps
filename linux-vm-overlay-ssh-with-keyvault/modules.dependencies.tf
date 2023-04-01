
module "key_vault" {
  source  = "azurenoops/overlays-key-vault/azurerm"
  #version = "x.x.x"
  # source = "../.."

  depends_on = [
    module.mod_rg
  ]
  # By default, this module will create a resource group and 
  # provide a name for an existing resource group. If you wish 
  # to use an existing resource group, change the option 
  # to "create_key_vault_resource_group = false." The location of the group 
  # will remain the same if you use the current resource.
  create_key_vault_resource_group = false

  location                        = var.location
  environment                     = var.environment
  deploy_environment              = var.environment
  org_name                        = var.org_name
  workload_name                   = var.workload_name

  # This is to enable the features of the key vault
  enabled_for_deployment          = false
  enabled_for_disk_encryption     = false
  enabled_for_template_deployment = false

  # This is to enable public access to the key vault, since we are using a private endpoint, we will disable it
  public_network_access_enabled = false
  purge_protection_enabled = false
  # Creating Private Endpoint requires, VNet name to create a Private Endpoint
  # By default this will create a `privatelink.azurecr.io` DNS zone. if created in commercial cloud
  # To use existing subnet, specify `existing_subnet_id` with valid subnet id. 
  # To use existing private DNS zone specify `existing_private_dns_zone` with valid zone name
  # Private endpoints doesn't work If not using `existing_subnet_id` to create redis inside a specified VNet.
  enable_private_endpoint = false
  custom_resource_group_name = module.mod_rg.resource_group_name
  existing_subnet_id = azurerm_subnet.jump-snet.id
  virtual_network_name = azurerm_virtual_network.jump-vnet.name
  # existing_subnet_id      = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rg-anoa-dev-kv/providers/Microsoft.Network/virtualNetworks/vnet-anoa-dev-kv/subnets/snet-anoa-dev-kv"
  # virtual_network_name    = "vnet-anoa-dev-kv"
  # existing_private_dns_zone     = "demo.example.com"
 
  # Current user should be here to be able to create keys and secrets
  admin_objects_ids = [
    data.azuread_group.admin_group.id
  ]
  
  # This is to enable resource locks for the key vault. 
  enable_resource_locks = false

  # Tags for Azure Resources
  add_tags = {
    example = "basic deployment of key vault"
  }
}