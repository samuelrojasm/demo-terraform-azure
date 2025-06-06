##---------------------------------------------------
# vm-linux-multiple
# Configurar Azure provider
# Iniciar sesión con las credenciales definidas
##---------------------------------------------------

terraform {
  required_version = ">= 1.11.0"

  required_providers {

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "azuread" {
}