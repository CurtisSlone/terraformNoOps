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
    storage_account_name = "testorgtfstatesak7nofldf"
    container_name = "testorgtfdevsck7nofldf"
    key = "terraform.tfstate"
    access_key = "tFsxxPIdIeZykvAB5lL34Rje1Lo2uIkuWHOXjVQZD5CXZTAZOOwQL0R5IeYWKEsGZaRExlUf6ZsP+ASt+z40DA=="
  }
}

provider "azurerm" {
    features {}
}