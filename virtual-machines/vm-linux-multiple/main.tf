##---------------------------------------------------------------------------
# vm-linux-multiple
# Definición de Grupo de Recursos, VNet, Subred y Múltiples Virtual Machines
# Acceso Entra ID + RBAC
##--------------------------------------------------------------------------

# Generar nombres dinámicos
locals {
  prefix       = "${var.service}-${var.purpose}"
  os_disk_name = "osdisk-${var.purpose}-${var.location}"
}

# Grupo de recursos
resource "azurerm_resource_group" "rg" {
  name     = "rg-${local.prefix}-001"
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
  principal_id         = data.azuread_group.vm_user_group.object_id
}

# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${local.prefix}-001"
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Subred
resource "azurerm_subnet" "subnet" {
  name                 = "snet-${local.prefix}-001"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_prefix
}

resource "azurerm_public_ip" "public_ip" {
  count               = var.cantidad_instancias
  name                = "pip-${local.prefix}-${count.index + 1}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Basic"
}

resource "azurerm_network_interface" "nic" {
  count               = var.cantidad_instancias
  name                = "nic-${local.prefix}-${count.index + 1}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip[count.index].id
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  count                           = var.cantidad_instancias                 # Crea múltiples VM
  name                            = "vm-${local.prefix}-${count.index + 1}" # Nombre dinámico: VM 1, 2, 3...
  admin_username                  = var.admin_username
  disable_password_authentication = true
  admin_password                  = null
  location                        = azurerm_resource_group.rg.location
  resource_group_name             = azurerm_resource_group.rg.name
  network_interface_ids = [
    azurerm_network_interface.nic[count.index].id
  ]
  size = var.size_vm

  # Activar System Assigned Managed Identity
  identity {
    type = "SystemAssigned"
  }

  # Llave pública 
  admin_ssh_key {
    username   = var.admin_username
    public_key = file("${path.module}/.ssh/dummy_key.pub")
  }

  source_image_reference {
    publisher = var.vm_image.publisher
    offer     = var.vm_image.offer
    sku       = var.vm_image.sku
    version   = var.vm_image.version
  }

  os_disk {
    name                 = "osdisk-${local.prefix}-${count.index + 1}"
    caching              = var.vm_os_disk.caching
    storage_account_type = var.vm_os_disk.storage_account_type
  }

  tags = {
    env = var.purpose
  }
}

##------------------------------------------
# Habilitar la extensión de login Entra ID.
# La VM debe tener instalada la extensión AADSSHLoginForLinux, 
# la cual permite validar y aceptar las credenciales de 
# Microsoft Entra ID para conexión SSH
##------------------------------------------
resource "azurerm_virtual_machine_extension" "aad_login" {
  count                      = var.cantidad_instancias
  name                       = "AADSSHLogin"
  virtual_machine_id         = azurerm_linux_virtual_machine.vm[count.index].id
  publisher                  = "Microsoft.Azure.ActiveDirectory"
  type                       = "AADSSHLoginForLinux"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
}
#------------------------------------------