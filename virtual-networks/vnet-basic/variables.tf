# Difinción de variables para que el código sea flexible

variable "resource_group_name" {
  description = "Nombre del grupo de recursos"
  type        = string
  default     = "rg-vnet-demo"
}

variable "location" {
  description = "Ubicación de la VNet"
  type        = string
  default     = "eastus"
}

variable "vnet_name" {
  description = "Nombre de la VNet"
  type        = string
  default     = "vnet-demo"
}

variable "vnet_address_space" {
  description = "Rango de direcciones IP para la VNet"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_name" {
  description = "Nombre de la subred"
  type        = string
  default     = "subnet-demo"
}

variable "subnet_prefix" {
  description = "Prefijo de la subred"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}
