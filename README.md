# casopractico2_devops - Víctor Manuel Díaz Sánchez

Repositorio para Caso Práctico 2 - Experto DevOps y Cloud.

**TERRAFORM**

Los pasos a seguir para el despliegue automático de las máquinas virtuales (master, nfs, worker01 y worker02) en MS Azure son: 

```
NOTA: todos los pasos se encuentran documentados en: CasoPráctico2_VíctorDíazSánchez_Entregable.doc
```

1.-Creación de máquina virtual local con sistema operativo Linux CentOS.

```
Características: 

- Linux CentOS;
- 2 CPUs;
- 4 Gbs RAM;
- 20 Gbs HDD.
```

2.-Instalación de Azure CLI para Linux.

- & sudo dnf install azure-cli

3.-Login en MS Azure.

- & az login

4.-Subscripción en Azure con los datos de nuestra cuenta de alumno.

- & az account set --subscription=xxxxxxxxx

5.-Creación de Service Principal.

- & az ad sp create-for-rbac --role="Contributor"

6.-Instalación de aplicación Terraform 1.0.0. en máquina virtual local.

- & dnf install terraform

7.-Creación del plan de Terraform. Creación de ficheros .tf: 

```
- vars.tf, 
- credentiales.tf, 
- correcion-vars.tf, 
- vm.tf, 
- main.tf, etc.
```

8.-Generación de claves privada y pública a través del comando ssh-keygen. 

- & ssh-keygen

9.-Validación de las imágenes a utilizar para el despliegue de nuestro entorno en MS Azure.

- & az vm image accept-terms --urn cognosys:centos-8-stream-free:centos-8-stream-free:1.2019.0810

10.-Despliegue del plan de Terraform a través de los comandos: 

- terraform init
- terraform validate
- terraform apply 

```
NOTA: terraform destroy sirve para eliminar todo el entorno desplegado en MS AZURE. 
```

**ANSIBLE**

El despliegue de nuestro clúster de Kubernetes en MS AZURE de forma automatizada a través de Ansible se dividirá en dos fases distintas:

```
**1.-Despliegue de clúster Kubernetes con Ansible en Entorno Local.**

**2.-Despliegue de clúster Kubernetes con Ansible en MS AZURE.** 
```


**1.-Despliegue de clúster Kubernetes con Ansible en Entorno Local.** 

1.1.-Máquinas virtuales Entorno Local: 

```
- master.example.com # Rol máster de clúster Kubernetes - 192.168.1.102
- nfs.example.com # Rol nfs de clúster Kubernetes - 192.168.1.107
- worker01.example.com # Rol worker01 de clúster Kubernetes - 192.168.1.108 
- worker02.example.com # Rol worker02 de clúster Kubernetes - 192.168.1.109
- terraform.example.com # Máquina local para el despliegue de Terraform y Ansible - 192.168.1.111
```

1.2.-Fichero hosts Plan Ansible Entorno Local

```
- [master] - master.example.com
- [nfs] - nfs.example.com
- [worker01] - worker01.example.com
- [worker02] - worker02.example.com
- [kubernetes:children] - master, worker01, worker02
- [workers:children] - worker01, worker02
```

1.3.-Roles Plan Ansible Entorno Local

```
- 01_rol_prerrequisitos # Tareas de instalación de prerrequisitos en todos los nodos del clúster Kubernetes.
- 02_rol_instalacion_nfs # Tareas de instalación de requisitos para instalación de nfs.
- 03_rol_master_workers # Tareas de instalación conjuntas nodos master y workers. 
- 04_rol_kubernetes_master # Tareas exclusivas a realizar en nodo master.
- 05_rol_calico_redlocal # Tareas de instalación de la red Calico.
- 06_rol_kubernetes_workers # Tareas exclusivas a realizar en nodos workers.
- 07_rol_ingress_controller_master # Tareas para instalación de ingless controller para la exposición a exterior.
- 08_rol_usuario_noroot_master # Tarea de creación de usuario no root.
```

1.4.-Ficheros Auxiliares Plan Ansible Entorno Local

```
- custom-resources.yaml
- haproxy-ingress.yaml
- tigera-operator.yaml
- join-token.yaml
```

1.5.-Playbooks de Ansible Entorno Local

```
- 01_playbook_prerrequisitos_todos.yaml
- 02_playbook_instalacion_nfs.yaml
- 03_playbook_tareascomunes_masterworkers.yaml
- 04_playbook_configuracion_kubernetes_master.yaml
- 05_playbook_instalacion_calico_redlocal.yaml
- 06_playbook_configuracion_kubernetes_workers.yaml
- 07_playbook_ingress_controller_master.yaml
- 08_playbook_creacion_usuario_noroot_master.yaml
```

**2.-Despliegue del clúster de Kubernetes con Ansible en entorno MS AZURE.**

Para el despliegue del clúster de Kubernetes en el entorno de nube pública MS AZURE se deben de tener en cuenta diversas consideraciones: 

```
- Los nombres de los equipos que conformarán el clúster de Kubernetes ya vienen definidos en los ficheros vm.tf de nuestro plan de Terraform.
- Dentro del fichero correccion-vars.tf ya se han definido: cuenta de almacenamiento en MS AZURE, usuario SSH y ruta para clave pública. 
- Dentro del fichero main.tf ya se ha definido el grupo de recursos a crear en MS AZURE. 
- El fichero hosts de nuestro plan de Ansible debe de cambiar los nombres de dominio asociados a las máquinas virtuales a desplegar. 

```

2.1.-Fichero hosts plan Ansible entorno MS AZURE

```
- [master] - master.victor.com # IP 10.0.1.10
- [nfs] - nfs.victor.com # IP 10.0.1.11
- [worker01] - worker01.victor.com # IP 10.0.1.12
- [worker02] - worker02.victor.com # IP 10.0.1.13
- [kubernetes:children] - master, worker01, worker02
- [workers:children] - worker01, worker02
```

2.2.-Roles Plan Ansible entorno MS AZURE

```
- 01_rol_prerrequisitos # Tareas de instalación de prerrequisitos en todos los nodos del clúster Kubernetes.
- 02_rol_instalacion_nfs # Tareas de instalación de requisitos para instalación de nfs.
- 03_rol_master_workers # Tareas de instalación conjuntas nodos master y workers.
- 04_rol_kubernetes_master # Tareas exclusivas a realizar en nodo master.
- 05a_rol_SDN_redazure # Tareas de instalación de la red SDN AZURE.
- 06_rol_kubernetes_workers # Tareas exclusivas a realizar en nodos workers.
- 07_rol_ingress_controller_master # Tareas para instalación de ingless controller para la exposición a exterior.
- 08_rol_usuario_noroot_master # Tarea de creación de usuario no root.
```

2.2.-Ficheros Auxiliares Plan Ansible entorno MS AZURE

```
- custom-resources.yaml
- haproxy-ingress.yaml
- tigera-operator.yaml
- join-token.yaml
- canal.yaml
```

2.4.-Playbooks de Ansible entorno MS AZURE

```
- 01_playbook_prerrequisitos_todos.yaml
- 02_playbook_instalacion_nfs.yaml
- 03_playbook_tareascomunes_masterworkers.yaml
- 04_playbook_configuracion_kubernetes_master.yaml
- 05a_playbook_instalacion_sdn_azure.yaml
- 06_playbook_configuracion_kubernetes_workers.yaml
- 07_playbook_ingress_controller_master.yaml
- 08_playbook_creacion_usuario_noroot_master.yaml
```

**3.-Despliegue Aplicación con Ansible en clúster Kubernetes entorno Microsoft Azure**

La aplicación a desplegar dentro de nuestro clúster de Kubernetes será:

```
- nginx # Servidor web
- redis # Base de datos clave/valor

3.1.-Fichero .yaml con Aplicación nginx y redis

```
- aplicacion_nginx_redis.yaml # Con dos contenedores para albergar ambas aplicaciones
```

3.2.-Rol de Ansible Aplicación nginx y redis

```
- 09_rol_despliegue_aplicacion # Con la ejecución del comando kubectl apply -f aplicacion_nginx_redis.yaml

```

3.3.-Playbook de Ansible Aplicación nginx y redis

```
- 09_playbook_aplicacion_kubernetes.yaml

```

Por último, podremos comprobar el correcto despliegue de nuestra aplicación a través de los comandos de Kubernetes: 

```
- kubectl get pods -A # Veremos los dos contenedores desplegados correctamente.
- kubectl get pod mi-app # Veremos todos los pasos describiendo de forma detallada la instalación de nuestra aplicación. 
```
















 
