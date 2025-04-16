## 🛠️  Demo: Azure Virtual Machine Linux

[![Azure](https://badgen.net/badge/icon/azure?icon=azure&label)](https://azure.microsoft.com)
[![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform&logoColor=white)](#)
[![HCL](https://img.shields.io/badge/Language-HCL-blueviolet)](#)

## 🎯 Objetivo (Target)
Este ejemplo ejecuta las siguientes acciones: 
- Activa el acceso a la VM con Microsoft Entra ID (az ssh vm)
    - Para permitir que usuarios inicien sesión en la máquina virtual Linux en Azure utilizando credenciales de Microsoft Entra ID y el comando **az ssh vm**
- Crea un Grupo de Recursos (RG)
- Asigna el rol: **`Virtual Machine User Login`** al grupo creado previamente (por ejemplo: grp-vm-user-login)
- Crea una VM Linux
- Instalar en la VM la extensión **`AADSSHLoginForLinux`**, permite validar y aceptar las credenciales de Microsoft Entra ID para conexión SSH
- Activar en la VM **`System Assigned Managed Identity`**
- Uso de los proveedores de Azure Resource Manager (**`azurerm`**) y Microsoft Entra ID (**`azuread`**).

<br>
<p align="center">
  <img src="assets/imagenes/VM_Entra_ID_RBAC.png" alt="Arquitectura Entra ID + RBAC" width="70%">
</p>
<br>

---

## ✅ Prerequisitos
Previo a la ejecución es necesario tener listo los siguientes recursos:
- Usuario de Entra ID (por ejemplo: vm-user-login)
- Grupo de Entra ID (por ejemplo: grp-vm-user-login)
- Agregar usuario al grupo

<br>
<p align="center">
  <img src="assets/imagenes/azure_entra_id_grupo_usuario.png" alt="Entra ID Grupo y Usuario" width="80%">
</p>
<br>

---

## 🚀 Resultado (Outcome)
### Terraform apply
![Private Subnet](assets/imagenes/terraform_apply.png)
### Resource map (Private Subnets)
![Private Subnet](assets/imagenes/private_subnets.png)

---