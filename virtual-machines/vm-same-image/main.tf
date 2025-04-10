# Definición de VNet, Virtual Machine, Subred y el Grupo de Recursos

# Generar nombres dinámicos
locals {
  resource_group_name = "rg-${var.service}-${var.purpose}-001"
  vnet_name           = "vnet-${var.purpose}-${var.location}-001"
  subnet_name         = "snet-${var.purpose}-${var.location}-001"
  nic_name            = "nic-${var.purpose}-${var.location}-001"
}

# Grupo de recursos
resource "azurerm_resource_group" "rg" {
  name     = local.resource_group_name
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

resource "azurerm_network_interface" "nic" {
  name                = local.nic_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    # Esta línea asegura que no se asigna una IP pública
    public_ip_address_id = null
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                  = "vm-entraid-demo"
  admin_username        = "azureuser"
  admin_password        = random_password.password.result
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic.id]
  size                  = "Standard_B1ls"

  # Requisito obligatorio para login con Entra ID
  identity {
    type = "SystemAssigned"
  }

  # NO usamos claves SSH
  disable_password_authentication = true

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_disk {
    name                 = "vm-entraid-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"

  }

  tags = {
    env = var.purpose
  }
}

# Habilitar la extensión de login Entra ID
resource "azurerm_virtual_machine_extension" "aad_login" {
  name                       = "AADSSHLogin"
  virtual_machine_id         = azurerm_linux_virtual_machine.vm.id
  publisher                  = "Microsoft.Azure.ActiveDirectory"
  type                       = "AADSSHLoginForLinux"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
}

resource "random_password" "password" {
  length      = 30
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1
  special     = true
}