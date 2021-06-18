# Fichero de Variables.  


variable "location" {
  type = string
  description = "Región de Azure donde vamos a crear nuestra infraestructura con Terraform"
  default = "West Europe"
}

variable "storage_account" {
  type = string
  description = "Nombre para la storage account"
  default = "vdiasan1975"
}

variable "public_key_path" {
  type = string
  description = "Ruta para la clave pública de acceso a las instancias"
  default = "~/.ssh/id_rsa.pub" # Es la ruta correspondiente al utilizar Linux CentOS.
}

variable "ssh_user" {
  type = string
  description = "Usuario para hacer ssh a la máquina virtual creada a través de su IP pública"
  default = "victor"
}





