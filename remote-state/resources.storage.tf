#
# Network Artifacts Storage Account
#

resource "azurerm_storage_account" "network-artifacts-storage" {
  depends_on = [
    module.mod_network_artifacts_rg
  ]
  name                     = "${lower(var.org_name)}tfmgtdev${random_string.tf-name.result}"
  resource_group_name      = module.mod_network_artifacts_rg.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  enable_https_traffic_only = true

  tags = {
    environment = var.environment
  }
}

#
# Network Artifacts Storage Container
#

resource "azurerm_storage_container" "network-artifacts-storage-container" {
  depends_on = [
    azurerm_storage_account.network-artifacts-storage
  ]
  name                  = "vhds"
  storage_account_name  = azurerm_storage_account.network-artifacts-storage.name
  container_access_type = "private"
}