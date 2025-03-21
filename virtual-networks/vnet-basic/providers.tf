# Configurar Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0.0"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}