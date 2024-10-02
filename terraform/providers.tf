terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.3.0"
    }
    
  }
  backend "azurerm" {
    resource_group_name = "rg_backend_tfstate_98"
    storage_account_name = "sabetfs98vb3n7kb8pr"
    container_name = "tfstate98"
    key            = "rg.terraform.tfstate"
  }
}


provider "azurerm" {
  subscription_id = "8fe266af-9a8d-40b0-bcb6-08d23e112c60"
    features {
    }
}