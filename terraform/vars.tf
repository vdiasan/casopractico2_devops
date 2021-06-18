# Fichero de variables. En concreto, variables localización y tamaño de las máquinas virtuales a desplegar. 



#variable "location" {
#  type = string
#  description = "Región de Azure donde crearemos la infraestructura"
#  default = "West Europe"
#}

variable "vm_size" {
  type = string
  description = "Tamaño de la máquina virtual para workers y nfs"
  default = "Standard_D1_v2" # 3.5 GB, 1 CPU 
}

variable "vm_size1" {
  type = string
  description = "Tamaño de la máquina virtual para master"
  default = "Standard_B2s" # 4 GB, 2 CPU
}

