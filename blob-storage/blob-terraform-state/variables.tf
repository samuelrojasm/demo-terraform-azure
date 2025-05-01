##---------------------------------------------------------------------------
# blob-terraform-state
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

variable "name_storageacct" {
  description = "Nomnre del Storage Account"
  type        = string
}

variable "storage_param" {
  description = "Parametros del Storage Account"
  type = object({
    account_replication_type = string
    account_tier             = string
    public_access            = bool
    kind                     = string
  })
}