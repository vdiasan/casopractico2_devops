# Eliminamos la red y la subred porque ya se han creado en el fichero network.tf

# Creación de la tarjeta de red o NIC4 (network interface card).

resource "azurerm_network_interface" "myNic4" {
  name                = "vmnic4"  
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
    name                           = "myipconfiguration4"
    subnet_id                      = azurerm_subnet.mySubnet.id 
    private_ip_address_allocation  = "Static"
    private_ip_address             = "10.0.1.13"
    public_ip_address_id           = azurerm_public_ip.myPublicIp4.id
  }

    tags = {
        environment = "CP2"
    }

}

# IP pública para poder acceder a la máquina virtual a través de SSH.


resource "azurerm_public_ip" "myPublicIp4" {
  name                = "vmip4"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"

    tags = {
        environment = "CP2"
    }

}
