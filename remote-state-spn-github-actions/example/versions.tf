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
  backend "azurerm" {
    resource_group_name = "testorg-eastus-network-artifacts-dev-rg"
    storage_account_name = "testorgtfstatesae1b06jxd"
    container_name = "testorgtfdevsce1b06jxd"
    key = "terraform.tfstate"
  }
}

provider "azurerm" {
    features {}
}