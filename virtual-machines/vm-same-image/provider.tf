##-------------------------------------------------
# vm-same-image
# Configurar Azure provider
# Iniciar sesión con las credenciales definidas
##-------------------------------------------------

terraform {
  required_version = ">= 1.11.0"

  required_providers {

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
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