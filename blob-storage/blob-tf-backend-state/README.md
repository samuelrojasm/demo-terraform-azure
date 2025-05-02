## 🛠️  Demo: Azure Blob Storage - Almacenar el estado de Terraform en Azure Storage

[![Azure](https://badgen.net/badge/icon/azure?icon=azure&label)](https://azure.microsoft.com)
[![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform&logoColor=white)](#)
[![HCL](https://img.shields.io/badge/Language-HCL-blueviolet)](#)

## 🎯 Objetivo (Target)
- En versiones recientes de Terraform (desde v1.1 en adelante), se peude usar el **bloque backend** dentro de terraform {} para definir el almacenamiento remoto del estado, incluyendo Azure como **backend** a través de **Azure Blob Storage**.

---

## ✅ Prerequisitos
- Para usar la función de **backend state** es necesario tener listo los siguientes recursos:
    - Azure Resource Group (correspondinete al Azure Blob definido para almacenar el estado de Terraform)
    - Azure Storage Account
    - Azure Container 
- Para configurar el estado de backend, necesita la siguiente información de almacenamiento Azure:
    - storage_account_name: El nombre de Azure Storage account.
    - container_name: El nombre del blob container.
    - key: El nombre del archivo del almacenamsiento de estado que se va a generar.
- Este el bloque de código del  **backend state** que se adiciona en el proyecto de Terraform
    ```hcl
    backend "azurerm" {
      resource_group_name  = "rg-blob-tf-state-demo"
      storage_account_name = "<storage_account_name>"
      container_name       = "tfstate"
      key                  = "terraform.tfstate"
    }
    ```
---

## 🚀 Resultado (Outcome)
### Terraform apply (outputs)
- El output incluirá el nombre del **storage_account** y del **container**, necesarios para configurar el backend remoto en otros proyectos.
<p align="center">
<img src="assets/imagenes/blob_outputs.png" alt="Terraform apply" width="60%">
</p>

### Terraform state list
<p align="center">
<img src="assets/imagenes/blob_state_list.png" alt="Terraform State" width="50%">
</p>

### Storage Account de Azure Blob Storage
 <p align="center">
    <img src="assets/imagenes/blob_stotage_account.png" alt="Storage Account" width="70%">
    </p>

### Container remoto pare el estado de Terraform en Azure Blob Storage
 <p align="center">
    <img src="assets/imagenes/blob_container.png" alt="Container" width="70%">
    </p>

---

## 📚 Referencias
- [Store Terraform state in Azure Storage](https://learn.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage/)

---



---