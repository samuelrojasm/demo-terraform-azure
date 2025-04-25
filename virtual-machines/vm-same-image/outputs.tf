# Datos presentados al final de Terraform apply

output "vm_count" {
  description = "Cantidad de VMs creadas"
  value       = length(azurerm_linux_virtual_machine.vm)
}

output "resource_group_name" {
  description = "Nombre de Resource Group"
  value       = azurerm_resource_group.rg.name
}

output "vm_info" {
  description = "Nombre de las VMs creadas"
  value = {
    nombre         = azurerm_linux_virtual_machine.vm[*].name
    public_ip      = azurerm_public_ip.public_ip[*].ip_address
    public_ip_name = azurerm_public_ip.public_ip[*].name
    # managed_identity_type = azurerm_linux_virtual_machine.vm[*].identity[0].type # Managed Identity (System Assigned)
  }
}

output "Red" {
  value = {
    vnet_name   = try(azurerm_virtual_network.vnet.name, null)
    subnet_name = try(azurerm_subnet.subnet.name, null)
  }
}

/* 

output "Extensiones" {
  value = {
    aad_ssh_extension_name      = try(azurerm_virtual_machine_extension.aad_login[*].name, null)
    aad_ssh_extension_type      = try(azurerm_virtual_machine_extension.aad_login[*].type, null)
    aad_ssh_extension_publisher = try(azurerm_virtual_machine_extension.aad_login[*].publisher, null)
  }
}

*/