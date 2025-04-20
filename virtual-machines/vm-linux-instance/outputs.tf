# En Terraform, puedes agrupar las salidas usando un map o un object como valor del output. 
# Esto te permite organizar de forma limpia la información de una VM en un solo bloque,
# en lugar de múltiples outputs separados.

output "vm_info" {
  value = {
    name           = azurerm_linux_virtual_machine.vm.name
    id             = azurerm_linux_virtual_machine.vm.id
    location       = azurerm_linux_virtual_machine.vm.location
    resource_group = azurerm_linux_virtual_machine.vm.resource_group_name

    # Red
    private_ip = azurerm_network_interface.nic.private_ip_address
    subnet_id  = azurerm_network_interface.nic.ip_configuration[0].subnet_id
    vnet_name  = try(azurerm_virtual_network.vnet.name, null) # Si usas un data source

    # Disco
    os_disk_name         = azurerm_linux_virtual_machine.vm.os_disk[0].name
    os_disk_caching      = azurerm_linux_virtual_machine.vm.os_disk[0].caching
    os_disk_size_gb      = azurerm_linux_virtual_machine.vm.os_disk[0].disk_size_gb
    storage_account_type = azurerm_linux_virtual_machine.vm.os_disk[0].storage_account_type

    # Managed Identity
    identity_type = azurerm_linux_virtual_machine.vm.identity[0].type # Managed Identity (System Assigned)
    principal_id  = azurerm_linux_virtual_machine.vm.identity[0].principal_id
    tenant_id     = azurerm_linux_virtual_machine.vm.identity[0].tenant_id

    # NSG
    nsg_name  = azurerm_network_security_group.nsg.name
    nsg_id    = try(azurerm_network_security_group.nsg.id, null)
    nsg_rules = try(azurerm_network_security_group.nsg.security_rule, [])

    # Extensiones
    aad_ssh_extension_name      = try(azurerm_virtual_machine_extension.aad_login.name, null)
    aad_ssh_extension_status    = try(azurerm_virtual_machine_extension.aad_login.id, null)
    aad_ssh_extension_type      = try(azurerm_virtual_machine_extension.aad_login.type, null)
    aad_ssh_extension_publisher = try(azurerm_virtual_machine_extension.aad_login.publisher, null)
    aad_ssh_extension_vm_id     = try(azurerm_virtual_machine_extension.aad_login.virtual_machine_id, null)

    # Boot diagnostics
    boot_diag_storage_uri = try(azurerm_linux_virtual_machine.vm.boot_diagnostics[0].storage_account_uri, null)

    # Admin info
    admin_username = azurerm_linux_virtual_machine.vm.admin_username
    # admin_password = azurerm_linux_virtual_machine.vm.admin_password
  }
}
