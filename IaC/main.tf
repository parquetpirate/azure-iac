# azure-iac

# Define a resource group
resource "azurerm_resource_group" "az_iac" {
  name     = "Resource_Group_Azure_IaC"
  location = "West US 2"
}

# Create a virtual network
resource "azurerm_virtual_network" "az_vnet" {
  name                = "vnet_terr_az"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.az_iac.location
  resource_group_name = azurerm_resource_group.az_iac.name
}

# Create a subnet within the virtual network (network resources live inside the subnet)
resource "azurerm_subnet" "az_subnet_1" {
  name                 = "subnet_trr_az"
  resource_group_name  = azurerm_resource_group.az_iac.name
  virtual_network_name = azurerm_virtual_network.az_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# The main difference between the two IP ranges is network scale:
# "10.0.0.0/16" is a much larger network covering all IP addresses under "10.0.x.x",
# while "10.0.1.0/24" is a much smaller subnet covering only addresses under "10.0.1.x".

# Create a network interface for the virtual machine
resource "azurerm_network_interface" "azr_ni" {
  name                = "ni_trr_az"
  location            = azurerm_resource_group.az_iac.location
  resource_group_name = azurerm_resource_group.az_iac.name

  # IP configuration for the network interface

  ip_configuration {
    name                          = "vm_az"
    subnet_id                     = azurerm_subnet.az_subnet_1.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Create a Linux virtual machine
resource "azurerm_linux_virtual_machine" "az_vm" {
  name                            = "vmaz"
  resource_group_name             = azurerm_resource_group.az_iac.name
  location                        = azurerm_resource_group.az_iac.location
  size                            = "Standard_D2s_v3"
  admin_username                  = "adminuser"
  disable_password_authentication = false
  admin_password                  = "mLMpVC1qqnoq795z"
  network_interface_ids           = [azurerm_network_interface.azr_ni.id]


  # OS disk configuration
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  # Operating system image for the virtual machine
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
