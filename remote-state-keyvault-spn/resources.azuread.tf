resource "azuread_group" "remote-state-kv-group" {
  display_name = "terraform-kv-group"
  description = "Group for accessing the Key Vault Secrets"
  security_enabled = true
}

resource "azuread_application" "kv-app" {
    display_name = "kv-app"
}

resource "azuread_group_member" "aad-group-member" {
    group_object_id = azuread_group.remote-state-kv-group.id
    member_object_id = azuread_application.kv-app.id
}