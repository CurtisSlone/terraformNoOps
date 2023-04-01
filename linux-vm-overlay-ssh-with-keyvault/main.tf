module "mod_rg" {
   source = "azurenoops/overlays-resource-group/azurerm"
  version = "~> 1.0"

  // Resource group name and location
  location       = var.location # This is the short location name (e.g. "eus")
  org_name       = var.org_name
  environment    = var.environment
  workload_name  = var.workload_name
  use_location_short_name = var.use_location_short_name # This is to enable short location name (e.g. "eus") as part of the resource group name
  custom_rg_name = var.custom_resource_group_name != null ? var.custom_resource_group_name : null

  // Enable resource locks
  enable_resource_locks = var.enable_resource_locks
  lock_level            = var.lock_level

  // Add tags
  add_tags = var.tags
}
