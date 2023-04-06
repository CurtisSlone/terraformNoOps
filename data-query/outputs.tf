output "subscription_ids" {
    value = [for sub in data.azurerm_subscriptions.all.subscriptions : sub.display_name]
}

output "id" {
    value = data.azurerm_resource_group.example.id
}