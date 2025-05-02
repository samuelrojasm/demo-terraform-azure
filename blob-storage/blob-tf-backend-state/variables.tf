##---------------------------------------------------------------------------
# blob-tf-backend-state
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