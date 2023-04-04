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
    storage_account_name = azurerm_storage_account.tfstatesa.name
    container_name = azurerm_storage_container.tfdevsc.name
    key = "dev.terraform.tfstate"
  }
}

provider "azurerm" {
    features {}
}