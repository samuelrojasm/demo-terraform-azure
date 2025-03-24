# Definición de VNet, Subred y el Grupo de Recursos

# Generar nombres dinámicos
locals {
  resource_group_name = "rg-${var.service}-${var.purpose}-001"
  vnet_name   = "vnet-${var.purpose}-${var.location}-001"
  subnet_name = "snet-${var.purpose}-${var.location}-001"
}

# Grupo de recursos
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Subred
resource "azurerm_subnet" "subnet" {
  name                 = local.subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_prefix
}
