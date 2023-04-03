#
#
# JUMPBOX RESOURCE GROUP MODULE
#
#
module "mod_jump_rg" {
    source = "azurenoops/overlays-resource-group/azurerm"
    version = "~> 1.0"

    //RG global configuration
    location = var.location
    org_name = var.org_name
    environment = var.environment
    workload_name = var.workload_name
    use_location_short_name = var.use_location_short_name
    custom_rg_name = var.custom_resource_group_name != null ? var.custom_resource_group_name : null

    //Resource locks
    enable_resource_locks = var.enable_resource_locks
    lock_level = var.lock_level

    //Tags
    add_tags = var.add_tags
}

#
#
# Bastion RESOURCE GROUP MODULE
#
#
module "mod_bastion_rg" {
    source = "azurenoops/overlays-resource-group/azurerm"
    version = "~> 1.0"

    //RG global configuration
    location = var.location
    org_name = var.org_name
    environment = var.environment
    workload_name = var.workload_name
    use_location_short_name = var.use_location_short_name
    custom_rg_name = var.custom_resource_group_name != null ? var.custom_resource_group_name : null

    //Resource locks
    enable_resource_locks = var.enable_resource_locks
    lock_level = var.lock_level

    //Tags
    add_tags = var.add_tags
}