
data "azurerm_subscription" "current_client" {}

module "mod_management_group" {
  source = "../terraform-azurerm-overlays-management-groups"

  root_id = "overlay"
  root_parent_id = data.azurerm_subscription.current_client.tenant_id
  root_name = "overlay"
  management_groups = {
    "sandbox" = {
        display_name = "sandbox"
        management_group_name = "sandbox"
        parent_management_group_id = "overlay"
        subscription_ids = ["23940602-cfb8-4eb0-9099-404c608da4c2"]
    }
  }
}