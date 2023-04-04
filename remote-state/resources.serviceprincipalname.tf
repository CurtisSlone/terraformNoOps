resource "azuread_service_principal" "kv-spn" {
  application_id               = azuread_application.kv-app.id
  app_role_assignment_required = false
}
