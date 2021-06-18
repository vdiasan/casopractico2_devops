# Fichero Principal de Terraform. Está compuesto de varias secciones que se describen a continuación: 

# Provider. Se indica el provider a utilizar. En nuestro caso MS Azure. 

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.1"
    }
  }
}

# No hace falta introducir las credenciales porque ya están creadas en el fichero credentials.tf


# Grupo de Recursos. Se indica un nombre y variable de localización. 

resource "azurerm_resource_group" "rg" {
    name     =  "kubernetes_rg"
    location = var.location

    tags = {
        environment = "CP2"
    }

}

# Cuenta de almacenamiento.  

resource "azurerm_storage_account" "stAccount" {
    name                     = var.storage_account 
    resource_group_name      = azurerm_resource_group.rg.name
    location                 = azurerm_resource_group.rg.location
    account_tier             = "Standard"
    account_replication_type = "LRS"

    tags = {
        environment = "CP2"
    }

}
