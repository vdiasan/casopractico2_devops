# casopractico2_devops - Víctor Manuel Díaz Sánchez

Repositorio para Caso Práctico 2 - Experto DevOps y Cloud.

**TERRAFORM**

Los pasos a seguir para el despliegue automático de las máquinas virtuales (master, nfs, worker01 y worker02) en MS Azure son: 

```
NOTA: todos los pasos se encuentran documentados en: CasoPráctico2_VíctorDíazSánchez_Entregable.doc
```

1.-Creación de máquina virtual local con sistema operativo Linux CentOS.

Características: 

- Linux CentOS;
- CPUs;
- 4 Gbs RAM;
- 20 Gbs HDD.

2.-Instalación de Azure CLI para Linux.

- & sudo dnf install azure-cli

3.-Login en MS Azure.

- & az login

4.-Subscripción en Azure con los datos de nuestra cuenta de alumno.

- & az account set --subscription=xxxxxxxxxxxxxxxxxxxxxxxxx

5.-Creación de Service Principal.

- & az ad sp create-for-rbac --role="Contributor"

6.-Instalación de aplicación Terraform 1.0.0. en máquina virtual local.

- & dnf install terraform

7.-Creación del plan de Terraform. Creación de ficheros .tf: 

- vars.tf, 
- credentiales.tf, 
- correcion-vars.tf, 
- vm.tf, 
- main.tf, etc.

8.-Genración de claves privada y pública a través del comando ssh-keygen. 

- & ssh-keygen

9.-Validación de las imágenes a utilizar para el despliegue de nuestro entorno en MS Azure.

- & az vm image accept-terms --urn cognosys:centos-8-stream-free:centos-8-stream-free:1.2019.0810

10.-Despliegue del plan de Terraform a través de los comandos: 

- terraform init
- terraform validate
- terraform apply 

---
NOTA: terraform destroy sirve para eliminar todo el entorno desplegado en MS AZURE. 
---

**ANSIBLE**

El despliegue de nuestro clúster de Kubernetes en MS AZURE de forma automatizada a través de Ansible se dividirá en dos fases distintas:

**1.-Despliegue de clúster Kubernetes con Ansible en Entorno Local.**

**2.-Despliegue de clúster Kubernetes con Ansible en MS AZURE.** 



**1.-Despliegue de clúster Kubernetes con Ansible en Entorno Local.** 

1.1.-Máquinas virtuales Entorno Local: 

- master.example.com # Rol máster de clúster Kubernetes - 192.168.1.102
- nfs.example.com # Rol nfs de clúster Kubernetes - 192.168.1.107
- worker01.example.com # Rol worker01 de clúster Kubernetes - 192.168.1.108 
- worker02.example.com # Rol worker02 de clúster Kubernetes - 192.168.1.109
- terraform.example.com # Máquina local para el despliegue de Terraform y Ansible - 192.168.1.111

1.2.-Ficheros hosts Plan Ansible

- [master] - master.example.com
- [nfs] - nfs.example.com
- [worker01] - worker01.example.com
- [worker02] - worker02.example.com
- [kubernetes:children] - master, worker01, worker02
- [workers:children] - worker01, worker02

1.3.-Roles

- 01_rol_prerrequisitos # Tareas de instalación de prerrequisitos en todos los nodos del clúster Kubernetes
- 02_rol_instalacion_nfs # Tareas de instalación de requisitos para instalación de nfs
- 03_rol_master_workers # Tareas de instalación 
- 04_rol_kubernetes_workers #
- 05_rol_calico_redlocal # 
- 06_rol_kubernetes_workers # 
- 07_rol_ingress_controller_master #
- 08_rol_usuario_noroot_master #




























 
