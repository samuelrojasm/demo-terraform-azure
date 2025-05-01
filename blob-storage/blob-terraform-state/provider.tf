##---------------------------------------------------
# blob-terraform-state
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

  }
}

provider "azurerm" {
  features {}
}