# azure-iac

# Define um grupo de recursos
resource "azurerm_resource_group" "az_iac" {
  name     = "Resource_Group_Azure_IaC"
  location = "West US 2"
}

# Cria uma rede virtial
resource "azurerm_virtual_network" "az_vnet" {
  name                = "vnet_terr_az"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.az_iac.location
  resource_group_name = azurerm_resource_group.az_iac.name
}

# Cria a subnet da rede virtual (os recursos de rede ficam dentro da subnet)
resource "azurerm_subnet" "az_subnet_1" {
  name                 = "subnet_trr_az"
  resource_group_name  = azurerm_resource_group.az_iac.name
  virtual_network_name = azurerm_virtual_network.az_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# A principal diferneça entre os dois range ip é a escala de rede:
# "10.0.0.0/16" é uma redemuito maior que abrange todos os endereços IP sob o "10.0.x.x",
# enquanto "10.0.1.0/24" é uma subnet muito menor que inclui apenas os endereços sob "10.0.1.x".

# Cria uma interface de rede para a máquina virtual
resource "azurerm_network_interface" "azr_ni" {
  name                = "ni_trr_az"
  location            = azurerm_resource_group.az_iac.location
  resource_group_name = azurerm_resource_group.az_iac.name

  # Configuralçao de IP para a interface de rede

  ip_configuration {
    name                          = "vm_az"
    subnet_id                     = azurerm_subnet.az_subnet_1.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Cria uma maquina virtual Linux
resource "azurerm_linux_virtual_machine" "az_vm" {
  name                            = "vmaz"
  resource_group_name             = azurerm_resource_group.az_iac.name
  location                        = azurerm_resource_group.az_iac.location
  size                            = "Standard_D2s_v3"
  admin_username                  = "adminuser"
  disable_password_authentication = false
  admin_password                  = "mLMpVC1qqnoq795z"
  network_interface_ids           = [azurerm_network_interface.azr_ni.id]


  # Configuração do disco para o sistema operaconal
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  # Imagem do sistema operacional da maquina virtual
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
