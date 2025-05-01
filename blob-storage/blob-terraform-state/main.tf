##---------------------------------------------------------------------------
# blob-terraform-state
# Definición de:
#   - Azure Resource Group, 
#   - Azure Storage Account y 
#   - Blob Container privado
##---------------------------------------------------------------------------

# Generar nombres dinámicos
locals {
  prefix = "${var.service}-${var.purpose}"
}

# Azure Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "rg-${local.prefix}"
  location = var.location
}

# Azure Storage Account
resource "azurerm_storage_account" "storageacct" {
  name                = "storageacct${var.name_storageacct}01" # único globalmente
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  account_tier                    = var.storage_param.account_tier
  account_kind                    = var.storage_param.kind
  account_replication_type        = var.storage_param.account_replication_type
  allow_nested_items_to_be_public = var.storage_param.public_access

  tags = {
    environment = "${local.prefix}"
  }
}

# Azure Blob Container privado
resource "azurerm_storage_container" "container" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.storageacct.id
  container_access_type = "private"
}