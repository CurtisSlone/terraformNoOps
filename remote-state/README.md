# **Remote-State**

## Purpose
Create remote state and deploy to azure

## NoOps Overlays Used

terraform-azurerm-overlays-resource-group

## Resources Used

Random
Storage
KeyVault

### Dependencies
The resource group, storage accounts and storage containers must be deployed before wiring up the backend.
It's best to run 
```hcl 
terraform plan 
terraform apply --auto-approve
``` 
before wiring the backend.

The storage account & containers must be deployed first.

The storage account and container names must be deployed in whatever terraform code uses the remote backend

### Caveats
I've created two containers within the storage account. One for development, the other for production. I'm currently searching for a way to create logic to select which backend config I want to use.


## Current Errors

#### 1
Initializing the backend...
╷
│ Error: Either an Access Key / SAS Token or the Resource Group for the Storage Account must be specified - or Azure AD Authentication must be enabled

The storage container requires an access key. It is best practice to not expose this access key in code. In the exaple

##### FIX:
Enter access_key value into tests azurerm backend

#### 2
Running ```hcl terraform init ``` stays in the "Initializing the backend" state

##### FIX:
Enter correct storage account, storage container, and access key information