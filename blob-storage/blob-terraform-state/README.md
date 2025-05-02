## 🛠️  Demo: Azure Blob Storage - Almacenamiento para el estado de Terraform

[![Azure](https://badgen.net/badge/icon/azure?icon=azure&label)](https://azure.microsoft.com)
[![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform&logoColor=white)](#)
[![HCL](https://img.shields.io/badge/Language-HCL-blueviolet)](#)

## 🎯 Objetivo (Target)
- Proporcionar los recursos mínimos necesarios para habilitar el uso de **azurerm** como backend remoto para otros proyectos Terraform.
- Recursos que se crean:
    - Azure Resource Group
    - Azure Storage Account (tipo StorageV2, replicación LRS)
    - Blob Container privado (tfstate)

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
- [Introduction to Azure Storage](https://learn.microsoft.com/en-us/azure/storage/common/storage-introduction)
- [Herramientas o productos de Azure Storage](https://azure.microsoft.com/es-es/products/category/storage)
- [Store Terraform state in Azure Storage](https://learn.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage?tabs=azure-cli)