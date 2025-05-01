##-------------------------------------------------
# blob-terraform-state
# Asignación de valores a las varibales
##-------------------------------------------------

location = "eastus"
service  = "blob-tf-state"
purpose  = "demo"

storage_param = {
  account_replication_type = "LRS"
  account_tier             = "Standard"
  public_access            = false
  kind                     = "StorageV2"
}