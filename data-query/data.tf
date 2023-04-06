data "azurerm_subscriptions" "all" {}

data "azurerm_resource_group" "example" {
    name = "existing"
}

