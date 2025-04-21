# Difinción de variables para que el código sea flexible

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