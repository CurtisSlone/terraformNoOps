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
I've created two containers within the storage account. One for development, the other for production. I'm currently searching for a way to create logic to select which backend config I want to use
