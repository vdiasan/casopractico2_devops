# Creamos un security group (regla de firewall) para habilitar el puerto 22 (ssh) en cada una de las 4 máquinas virtuales.

resource "azurerm_network_security_group" "mySecGroup3" {
    name                = "sshtraffic3"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = "CP2"
    }
}

# Vinculamos el security group al interface de red de cada una de las 4 máquinas virtuales: NFS, MASTER, WORKER01 y WORKER02. 

resource "azurerm_network_interface_security_group_association" "mySecGroupAssociation3" {
    network_interface_id      = azurerm_network_interface.myNic3.id
    network_security_group_id = azurerm_network_security_group.mySecGroup3.id

}



