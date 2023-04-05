
module "mod_service_principal" {
    source = "../terraform-azuread-overlays-service-principal"

    service_principal_name = "test-app-spn"
    service_principal_password_rotation_in_years = 1

    service_principal_assignments = [
        {
            scope = "/subscriptions/"
            role_definition_name = "Contributor"
        }
    ]
}