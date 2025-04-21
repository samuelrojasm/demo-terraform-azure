## 🛠️  Demo: Azure Virtual Machine - Varias VM (misma imagen)

[![Azure](https://badgen.net/badge/icon/azure?icon=azure&label)](https://azure.microsoft.com)
[![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform&logoColor=white)](#)
[![HCL](https://img.shields.io/badge/Language-HCL-blueviolet)](#)

## 🎯 Objetivo (Target)
- Creación de múltiples VM de la misma imagen

---

## ✅ Prerequisitos
- Previo a la ejecución es necesario tener listo los siguientes recursos:

1. Crear par de llaves (privada y pública)
    - Se requiere la llave púbica para poder crear y acceder a las VMs
    - Para la creación del par de llaves se ejecuta:
        ```bash
        ssh-keygen -t rsa -b 4096 -f ~/.ssh/dummy_key -N ""
        ```
    - Crear directorio en el módulo principal de Terraform y copiar llave pública
        ```bash
        mkdir .ssh
        cd .ssh
        cp ~/.ssh/dummy_key.pub .
        ```

---

## 🚀 Resultado (Outcome)
### Terraform apply (outputs)
<p align="center">
<img src="assets/imagenes/terraform_apply_vm_linux.png" alt="Terraform apply" width="60%">
</p>

### Terraform state list
<p align="center">
<img src="assets/imagenes/terraform_state_list.png" alt="Terraform state list" width="60%">
</p>

### Acceso a la VM Linux
- Usar el comando para acceder a la VM (sin contraseña o llave privada)
    ```bash
    az ssh vm \
    --name vm-entraid-demo-eastus-001 \
    --resource-group rg-vnet-entraid-demo-001
    ```
    <p align="center">
    <img src="assets/imagenes/login_vm_linux.png" alt="Login VM Linux" width="70%">
    </p>


![Private Subnet](assets/imagenes/terraform_apply.png)
### Resource map (Private Subnets)
![Private Subnet](assets/imagenes/private_subnets.png)

---