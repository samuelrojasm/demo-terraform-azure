## 🛠️  Demo: Azure Virtual Machine Linux

## 🎯 Objetivo (Target)
Este ejemplo ejecuta las siguientes acciones: 
- Crea un Grupo de Recursos (RG)
- Asigna del rol: **"Virtual Machine User Login"** al grupo creado previamente (por ejemplo: grp-vm-user-login)
- Crea una VM Linux
- Activa el acceso a la VM con Microsoft Entra ID (az ssh vm)
    - Para permitir que usuarios inicien sesión en la máquina virtual Linux en Azure utilizando credenciales de Microsoft Entra ID y el comando **az ssh vm**
-  Uso de los proveedores de Azure Resource Manager (**azurerm**) y Microsoft Entra ID (**azuread**).

<br>
<p align="center">
  <img src="assets/imagenes/VM_Entra_ID_RBAC.png" alt="Arquitectura Entra ID + RBAC" width="80%">
</p>
<br>

---

## Prerequisitos
Previo a la ejecución es necesario tener listo los siguientes recursos:
- Usuario de Entra ID (por ejemplo: vm-user-login)
- Grupo de Entra ID (por ejemplo: grp-vm-user-login)
- Agregar usuario al grupo

## 🚀 Resultado (Outcome)
### Terraform apply
![Private Subnet](assets/imagenes/terraform_apply.png)
### Resource map (Private Subnets)
![Private Subnet](assets/imagenes/private_subnets.png)

---