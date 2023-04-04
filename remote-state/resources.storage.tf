#
# Network Artifacts Storage Account
#

resource "azurerm_storage_account" "network-artifacts-storage" {
  name                     = "network-artifacts-storage"
  resource_group_name      = module.mod_network_artifacts_rg.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = var.tags
  }
}

#
# Network Artifacts Storage Container
#