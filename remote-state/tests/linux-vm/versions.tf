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
    storage_account_name = "testorgtfstatesabxia1arm5"
    container_name = "testorgtfdevscbxia1arm"
    key = "terraform.tfstate"
    use_azuread_auth     = true
  }
}

provider "azurerm" {
    features {}
}