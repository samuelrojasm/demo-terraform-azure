# Datos presentados al final de Terraform apply

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "Red" {
  value = {
    vnet_name   = try(azurerm_virtual_network.vnet.name, null)
    subnet_name = try(azurerm_subnet.subnet.name, null)
  }
}