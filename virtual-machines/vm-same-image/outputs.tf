# Datos presentados al final de Terraform apply

output "vm_count" {
  description = "Cantidad de VMs creadas"
  value       = length(azurerm_linux_virtual_machine.vm)
}

output "vm_info" {
  description = "Nombre de las VMs creadas"
  value = {
    nombre         = azurerm_linux_virtual_machine.vm[*].name
    public_ip      = azurerm_public_ip.public_ip[*].ip_address
    public_ip_name = azurerm_public_ip.public_ip[*].name
  }
}

output "resource_group_name" {
  description = "Nombre de Resource Group"
  value       = azurerm_resource_group.rg.name
}

output "Red" {
  value = {
    vnet_name   = try(azurerm_virtual_network.vnet.name, null)
    subnet_name = try(azurerm_subnet.subnet.name, null)
  }
}