##---------------------------------------------------------------------------
# blob-tf-backend-state
# Objetivo:
#   Validar el uso de backend state
# Definición de:
#   Azure Resource Group, 
##---------------------------------------------------------------------------

# Generar nombres dinámicos
locals {
  prefix = "${var.service}-${var.purpose}"
}

# Azure Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "rg-${local.prefix}"
  location = var.location
}