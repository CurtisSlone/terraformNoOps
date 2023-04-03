data "azurenoopsutils_resource_name" "vnet" {
    name = var.jump_workload_name
    resource_type = "azurerm_virtual_network"
    prefixes = [var.org_name, var.location]
    suffixes = compact([var.environment])
    use_slug = true
    clean_input = true
    separator = "-"
}

data "azurenoopsutils_resource_name" "subnet" {
    name = var.jump_workload_name
    resource_type = "azurerm_subnet"
    prefixes = [var.org_name, var.location]
    suffixes = compact([var.environment])
    use_slug = true
    clean_input = true
    separator = "-"
}

# data "azurenoopsutils_resource_name" "law" {
#     name = var.workload_name
#     resource_type = "azurerm_log_analytics_workspace"
#     prefixes = [var.org_name, var.location]
#     suffixes = compact([var.environment])
#     use_slug = true
#     clean_input = true
#     separator = "-"
# }