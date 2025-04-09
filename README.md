# 🛠️ Terraform Microsoft Azure Demos 

[![Azure](https://badgen.net/badge/icon/azure?icon=azure&label)](https://azure.microsoft.com)
[![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform&logoColor=white)](#)
[![HCL](https://img.shields.io/badge/Language-HCL-blueviolet)](#)

- Este repositorio contiene una serie de demos prácticas que muestran cómo utilizar Terraform para desplegar y gestionar recursos en **Microsoft Azure**. 
- El objetivo es proporcionar ejemplos básicos y avanzados que sirvan como referencia para implementar infraestructuras reproducibles y escalables.
- Cada demo cubre un escenario específico, desde configuraciones básicas hasta despliegues más avanzados.

---

## 📂 Contenido
### Ejemplos Virtual Networks (VNet)
- [Virtual Network con una subnet](https://github.com/samuelrojasm/demo-terraform-azure/tree/main/virtual-networks/vnet-basic)
### Ejemplos Virtual Machine (VM)
- []()

## 🚀 **Requisitos**
- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- Cuenta de **Azure** con permisos adecuados:
    - En mi caso uso un usuario de Azure con el rol: **```Contributor```** de Azure RBAC (Role-Based Access Control)
    - Este rol se asigna en: ```Azure subscription -> Access control (IAM) -> Add role assignment -> Role -> Privileged administrator roles```

- Azure CLI instalado:
    ```bash
    brew install azure-cli
    ```
- Login 
    - Método interactivo (usando el navegador)
        ```bash
        az login
        ```
    - Método con autenticación interactiva en CLI (sin navegador)
        ```bash
        az login --use-device-code
        ```
- Configurar la variable de entorno:
    ```bash
    export ARM_SUBSCRIPTION_ID="<SUBSCRIPTION_ID>"
    ```
---

## ⚙️ Estructura del repositorio
```
📁 Recurso-Azure                     # Servicio específico de Azure  
 ├── /nombre-demo-azure              # Nombre que describe la demo  
 │      ├── main.tf                  # Configuración principal  de Terraform
 │      ├── variables.tf             # Declaración de variables (Variables utilizadas)
 │      ├── outputs.tf               # Salidas de Terraform  
 │      ├── providers.tf             # Configuración del proveedor (Azure)  
 │      ├── README.md                # Explicación del ejemplo   
 │      └── terraform.tfvars         # Valores para las variables 
 └── ...                             # Más ejemplos  
📁 modules                           # Módulos reutilizables  
📄 README.md                         # Explicación general del repositorio  
```

---

## 💻 Uso de comandos de Terraform
- Inicializa lq configuración de Terraform
    ```bash
    terraform init
    ```

- Versión específica del proveedor que Terraform ha seleccionado
    ```bash
    terraform providers
    ```

- Aplica formato y valida la configuración
    ```bash
    terraform fmt
    terraform validate
    ```

- Aplica la configuración de Terraform
    ```bash
    terraform apply
    ```

- Inspeccionar el estado
    ```bash
     # Estado actual
    terraform show
     # Listar los recursos creados
    terraform state list
    ```

- Destruye la infraestructura si ya no se requiere
    ```bash
    terraform destroy
    ```

---

## 🎯 Prácticas recomendadas

- Usar variables y archivos **`.tfvars`** para manejar configuraciones reutilizables.
- Aplicar módulos para evitar repetición de código.
- Usar **`terraform fmt`** y **`terraform validate`** para mantener un código limpio y coherente.

---

## 🔐 Acceso a Virtual Machine con Microsoft Entra ID login
-Para acceder a una máquina virtual (VM) en Azure utilizando **Managed Identity** y **Microsoft Entra ID** (anteriormente Azure AD), es necesario configurar inicio de sesión con **Entra ID para la VM**. -Esto permite autenticarse a través de identidades corporativas en lugar de usar credenciales locales como usuario/contraseña o claves SSH. 
### Requisitos previos
- Tener una cuenta con permisos suficientes en la VM.
- La VM debe estar unida a Microsoft Entra ID.
- Estar utilizando una imagen de Windows Server 2019 o posterior o Ubuntu 20.04 o posterior.
- Tener Azure CLI instalado y autenticado (az login).
### Paso 1: Habilitar Entra ID Login en la VM
- Extensión para Linux
    ```bash
    AADSSHLoginForLinux
    ```
- Extensión para Windows
    ```bash
    AADLoginForWindows
    ```
### Paso 2: Asignar roles Entra ID al usuario



---

## 📚 Referencias
- [Terraform - Azure Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Define your naming convention](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming)
- [Build Azure infrastructure](https://developer.hashicorp.com/terraform/tutorials/azure-get-started/azure-build)
- [Azure regions](https://azure.microsoft.com/en-us/explore/global-infrastructure/geographies/)
- [Azure regions mapping list](https://github.com/claranet/terraform-azurerm-regions/blob/master/REGIONS.md)
- [Azure classic subscription administrators](https://learn.microsoft.com/en-us/azure/role-based-access-control/classic-administrators)

---