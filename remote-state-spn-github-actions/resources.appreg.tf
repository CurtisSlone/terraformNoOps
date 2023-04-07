#
# Create app registration
#

resource "azuread_application" "ghactions" {
  display_name = "github-actions"
#   required_resource_access {
#     resource_app_id = "00000003-0000-0000-c000-000000000000" # Microsoft Graph

#     resource_access {
#       id   = "df021288-bdef-4463-88db-98f22de89214" # User.Read.All
#       type = "Role"
#     }

    # resource_access {
    #   id   = "b4e74841-8e56-480b-be8b-910348b18b4c" # User.ReadWrite
    #   type = "Scope"
    # }
#   }
}

#
# Create Secret
#
resource "azuread_application_password" "GHAPass" {
  application_object_id = azuread_application.ghactions.id
}

#
# Create SPN
#
resource "azuread_service_principal" "GHASPN" {
    depends_on = [
      azuread_application.ghactions
    ]
  application_id = azuread_application.ghactions.application_id
}

#
# Assign Contributor Access to current subscription
#
resource "azurerm_role_assignment" "current" {
    scope = "subscriptions/${data.azurerm_client_config.current.subscription_id}"
    role_definition_name = "Contributor"
    principal_id = azuread_service_principal.GHASPN.id
}