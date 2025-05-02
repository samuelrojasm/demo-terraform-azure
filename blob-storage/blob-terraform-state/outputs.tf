##--------------------------------------------------------------
# blob-terraform-state
# Outputs: Datos presentados al final de Terraform apply
##--------------------------------------------------------------

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}
output "storage_account_name" {
  value = azurerm_storage_account.storageacct.name
}

output "container_name" {
  value = azurerm_storage_container.container.name
}