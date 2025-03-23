# 🛠️ Terraform Microsoft Azure Demos 

- Este repositorio contiene una serie de demos prácticas que muestran cómo utilizar Terraform para desplegar y gestionar recursos en **Microsoft Azure**. 
- El objetivo es proporcionar ejemplos básicos y avanzados que sirvan como referencia para implementar infraestructuras reproducibles y escalables.
- Cada demo cubre un escenario específico, desde configuraciones básicas hasta despliegues más avanzados.

---

## 🚀 **Requisitos**
- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- Cuenta de **Azure** con permisos adecuados
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
# Uso de comandos de Terraform
- Inicializa y aplica la infraestructura
    ```bash
    terraform init 
    terraform apply
    ```

- Versión específica del proveedor que Terraform ha seleccionado
    ```bash
    terraform providers
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

## 📚 Referencias
- [Terraform - Azure Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)

---