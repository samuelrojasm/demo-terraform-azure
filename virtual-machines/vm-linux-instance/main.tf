# Definición de VNet, Virtual Machine, Subred y el Grupo de Recursos

# Generar nombres dinámicos
locals {
  resource_group_name = "rg-${var.service}-${var.purpose}-001"
  vnet_name           = "vnet-${var.purpose}-${var.location}-001"
  subnet_name         = "snet-${var.purpose}-${var.location}-001"
  nic_name            = "nic-${var.purpose}-${var.location}-001"
  vm_name             = "vm-${var.purpose}-${var.location}-001"
  os_disk_name        = "osdisk-${var.purpose}-${var.location}-001"
  nsg_name            = "nsg-${var.purpose}-${var.location}-001"
  public_ip_name      = "pip-${var.purpose}-${var.location}-001"
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
  principal_id         = data.azuread_group.vm_user_group.object_id
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

resource "azurerm_public_ip" "public_ip" {
  name                = local.public_ip_name
  location            = zurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Basic"
}

resource "azurerm_network_interface" "nic" {
  name                = local.nic_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name           = local.vm_name
  admin_username = var.admin_username # Requerido aunque no se use para login
  # admin_password        = random_password.admin.result # Requerido aunque no se use para login
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic.id]
  size                  = "Standard_B1ls"

  # Usa una llave Dummy que no se usará
  admin_ssh_key {
    username   = "azureuser"
    public_key = file("${path.module}/.ssh/dummy_key.pub")
  }

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
  admin_password                  = null
  #------------------------------------------

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_disk {
    name                 = local.os_disk_name
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
#------------------------------------------

#------------------------------------------
# Habilitar Network Security Group
# Azure aplica una regla implícita de “Deny All” al final de las reglas de NSG,
# por lo que todo lo que no esté explícitamente permitido será denegado automáticamente.
#------------------------------------------
resource "azurerm_network_security_group" "nsg" {
  name                = local.nsg_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Regla: Denegar SSH (puerto 22)
resource "azurerm_network_security_rule" "deny_ssh" {
  name                        = "Deny-SSH"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
  description                 = "Bloquea el acceso SSH por puerto 22"
}

# Asociar este NSG a la interfaz de red de la VM
resource "azurerm_network_interface_security_group_association" "nsg_assoc" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
#------------------------------------------

resource "random_password" "admin" {
  length  = 16   # Longitud total de la contraseña
  special = true # Incluir caracteres especiales (!@#$...)
  upper   = true # Incluir mayúsculas
  lower   = true # Incluir minúsculas
}
