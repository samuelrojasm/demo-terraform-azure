# Definición de VNet, Virtual Machine, Subred y el Grupo de Recursos

# Generar nombres dinámicos
locals {
  resource_group_name = "rg-${var.service}-${var.purpose}-001"
  vnet_name           = "vnet-${var.purpose}-${var.location}-001"
  subnet_name         = "snet-${var.purpose}-${var.location}-001"
  nic_name            = "nic-${var.purpose}-${var.location}-001"
  vm_name             = "vm-${var.purpose}-${var.location}-001"
  os_disk_name = "osdisk-${var.purpose}-${var.location}-001"
}

# Grupo de recursos
resource "azurerm_resource_group" "rg" {
  name     = local.resource_group_name
  location = var.location
}

# Obtener el ID de un grupo existente
data "azuread_group" "vm_user_group" {
  display_name = "grp-vm-user-login"
}

# Asignar el Rol "Virtual Machine User Login" al Grupo (a nivel Resource Group)
resource "azurerm_role_assignment" "vm_user_login" {
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Virtual Machine User Login"
  principal_id         = data.azuread_group.vm_user_group.id
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
  name                  = local.vm_name
  admin_username        = "azureuser"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic.id]
  size                  = "Standard_B1ls"

  #------------------------------------------
  # Requisito obligatorio para Entra ID login,
  # acceso únicamente con Microsoft Entra ID + RBAC
  # NO usamos claves SSH
  #------------------------------------------

  # Activar System Assigned Managed Identity
  identity {
    type = "SystemAssigned"
  }

  # Esto indica que no cree una cuenta local, 
  # usar únicamente Entra ID para el acceso
  # (es decir, az ssh vm con credenciales de AAD)
  disable_password_authentication = true
  admin_password                  = null # opcional, se puede omitir

  #------------------------------------------

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

#------------------------------------------
# Habilitar la extensión de login Entra ID
#------------------------------------------
# La VM debe tener instalada la extensión AADSSHLoginForLinux, 
# la cual permite validar y aceptar las credenciales de 
# Microsoft Entra ID para conexión SSH
resource "azurerm_virtual_machine_extension" "aad_login" {
  name                       = "AADSSHLogin"
  virtual_machine_id         = azurerm_linux_virtual_machine.vm.id
  publisher                  = "Microsoft.Azure.ActiveDirectory"
  type                       = "AADSSHLoginForLinux"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
}