# **Terraform NoOps Training**

## Purpose:
Gain practical experience with Terraform, Azure, and Github Actions. Additionally, I will be providing use cases to the Azure Federal team to develop and mature their azurenoops overlays found [here](https://github.com/azurenoops).

## Current Azure NoOps Overlays & Use Cases

| Azure NoOps Overlay                               | Overlay Use Case                          |
|:------------------------------------------------  | ----------------------------------------: |
| terraform-azurerm-overlays-linux-virtualmachine   | Direct SSH                                |
|       N/A                                         | Bastion-Keyvault-hub                      |
|       N/A                                         | remote-state                              | 
| terraform-azurerm-overlays-management-groups      | management-groups                         |
| terraform-azuread-overlays-service-principal      | spn                                       |
| terraform-azuread-overlays-resource-groups        | remote-state-spn-github-actions           |

## Caveats

Local secrets like tenant ID or subscription ID are contained in variables.secrets.tf. These files are kept from being pushed to this library. To test locally, you must create a variables.secrets.tf file in the use case directory.