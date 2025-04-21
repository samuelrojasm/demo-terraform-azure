# Asignación de valores a las varibales

location            = "eastus"
service             = "vnet"
purpose             = "demo"
vnet_address_space  = ["10.0.0.0/16"]
subnet_prefix       = ["10.0.1.0/24"]
admin_username      = "azureuser"
cantidad_instancias = 2
size_vm             = "Standard_B1ls"
vm_image = {
  publisher = "Canonical"
  offer     = "0001-com-ubuntu-server-jammy"
  sku       = "22_04-lts"
  version   = "latest"
}

