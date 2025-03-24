# Difinción de variables para que el código sea flexible

variable "location" {
  description = "Ubicación de la VNet"
  type        = string
}

variable "vnet_address_space" {
  description = "Rango de direcciones IP para la VNet"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_prefix" {
  description = "Prefijo de la subred"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "purpose" {
  description = "Proposito de los recursos (demo,lab,dev,prod)"
  type        = string
}

variable "service" {
  description = "Nombre del servicio"
  type        = string
}

# Nombres generados dinámicamente 
variable "vnet_name" {
  description = "Nombre de la VNet"
  type        = string
  default     = ""
}

variable "subnet_name" {
  description = "Nombre de la subred"
  type        = string
  default     = ""
}

variable "resource_group_name" {
  description = "Nombre del grupo de recursos"
  type        = string
  default     = ""
}