terraform {
    required_version = ">= 1.2"
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~> 3.22"
    }
    azurenoopsutils = {
        source = "azurenoops/azurenoopsutils"
        version = "~> 1.0.4"
    }
  }
  
}

provider "azurerm" {
    features {}
}