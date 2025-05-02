##---------------------------------------------------
# blob-tf-backend-state
# Configurar Azure provider y el backend store
# Iniciar sesión con las credenciales definidas
##---------------------------------------------------

terraform {
  required_version = ">= 1.11.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-blob-tf-state-demo"
    storage_account_name = "storageacctblobtfstate01"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}