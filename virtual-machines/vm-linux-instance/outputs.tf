# En Terraform, puedes agrupar las salidas usando un map o un object como valor del output. 
# Esto te permite organizar de forma limpia la información de una VM en un solo bloque,
# en lugar de múltiples outputs separados.

output "vm_info" {
  value = {
    name           = azurerm_linux_virtual_machine.vm.name
    location       = azurerm_linux_virtual_machine.vm.location
    resource_group = azurerm_linux_virtual_machine.vm.resource_group_name
    admin_username = azurerm_linux_virtual_machine.vm.admin_username
  }
}

output "admin_password" {
  value     = azurerm_linux_virtual_machine.vm.admin_password
  sensitive = true
}

output "Red" {
  value = {
    vnet_name   = try(azurerm_virtual_network.vnet.name, null)
    subnet_name = try(azurerm_subnet.subnet.name, null)
    private_ip  = azurerm_network_interface.nic.private_ip_address
  }
}

output "Disco" {
  value = {
    os_disk_name         = azurerm_linux_virtual_machine.vm.os_disk[0].name
    os_disk_caching      = azurerm_linux_virtual_machine.vm.os_disk[0].caching
    os_disk_size_gb      = azurerm_linux_virtual_machine.vm.os_disk[0].disk_size_gb
    storage_account_type = azurerm_linux_virtual_machine.vm.os_disk[0].storage_account_type
  }
}

output "Managed_Identity" {
  value = {
    identity_type = azurerm_linux_virtual_machine.vm.identity[0].type # Managed Identity (System Assigned)
    principal_id  = azurerm_linux_virtual_machine.vm.identity[0].principal_id
  }
}

output "NSG" {
  value = {
    nsg_name = azurerm_network_security_group.nsg.name
  }
}

output "nsg_rules" {
  value = {
    name        = azurerm_network_security_rule.deny_ssh.name
    description = azurerm_network_security_rule.deny_ssh.description
    protocol    = azurerm_network_security_rule.deny_ssh.protocol
    port        = azurerm_network_security_rule.deny_ssh.destination_port_range
    access      = azurerm_network_security_rule.deny_ssh.access
    direction   = azurerm_network_security_rule.deny_ssh.direction
    priority    = azurerm_network_security_rule.deny_ssh.priority
  }
}

output "Extensiones" {
  value = {
    aad_ssh_extension_name      = try(azurerm_virtual_machine_extension.aad_login.name, null)
    aad_ssh_extension_type      = try(azurerm_virtual_machine_extension.aad_login.type, null)
    aad_ssh_extension_publisher = try(azurerm_virtual_machine_extension.aad_login.publisher, null)

  }
}