##---------------------------------------------------------------------------
# vm-same-image
# Difinción de variables para que el código sea flexible
##---------------------------------------------------------------------------

variable "location" {
  description = "Ubicación de los recursos"
  type        = string
}

variable "service" {
  description = "Nombre del servicio"
  type        = string
}

variable "purpose" {
  description = "Proposito de los recursos (demo, lab,dev,prod)"
  type        = string
}

variable "vnet_address_space" {
  description = "Rango de direcciones IP para la VNet"
  type        = list(string)
}

variable "subnet_prefix" {
  description = "Prefijo de la subred"
  type        = list(string)
}

variable "admin_username" {
  description = "Usuario administrador"
  type        = string
}

variable "cantidad_instancias" {
  description = "Cantidad de VM que se crean"
  type        = number
}

variable "size_vm" {
  description = "Tamaño de la VM"
  type        = string
}

variable "vm_image" {
  description = "Referencia de la imagen a usar para la VM"
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
}

variable "vm_os_disk" {
  description = "Diso de SO para la VM"
  type = object({
    caching              = string
    storage_account_type = string
  })
}