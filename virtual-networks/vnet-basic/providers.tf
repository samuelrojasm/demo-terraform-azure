# Configurar Azure provider
# Iniciar sesión con las credenciales definidas

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.x"
    }
  }

  required_version = ">= 1.11.0"
}

provider "azurerm" {
  features {}
}



