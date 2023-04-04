# **Remote-State**

## Purpose
Create remote state and deploy to azure

## NoOps Overlays Used

terraform-azurerm-overlays-resource-group

### Dependencies
The resource group, storage accounts and storage containers must be deployed before wiring up the backend.
It's best to run 
```hcl 
terraform plan 
terraform apply --auto-approve
``` 
before wiring the backend.

The storage account & containers must be deployed first.

### Caveats
I have two versions files. One for production, the other for development. This is because I want to experiment with tags in githib to attempt to automate how the terraform code is deployed