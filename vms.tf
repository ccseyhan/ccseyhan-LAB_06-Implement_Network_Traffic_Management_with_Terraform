#VM0


resource "azurerm_network_interface" "vm0_nic" {
  name                = "${var.vm0_name}-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg1.name

  ip_configuration {
    name                          = "vm0_configuration"
    subnet_id                     = azurerm_subnet.vnet01_subnet0.id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_network_interface_security_group_association" "vm0_nsg_config" {
  network_interface_id      = azurerm_network_interface.vm0_nic.id
  network_security_group_id = azurerm_network_security_group.lb_vms_nsg.id
}
resource "azurerm_windows_virtual_machine" "vm0" {
  name                = var.vm0_name
  resource_group_name = azurerm_resource_group.rg1.name
  location            = var.location
  size                = "Standard_F2"
  admin_username      = var.vm0_username
  admin_password      = var.vm0_password
  network_interface_ids = [
    azurerm_network_interface.vm0_nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
}


#VM1

resource "azurerm_network_interface" "vm1_nic" {
  name                = "${var.vm1_name}-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg1.name

  ip_configuration {
    name                          = "vm1_configuration"
    subnet_id                     = azurerm_subnet.vnet01_subnet1.id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_network_interface_security_group_association" "vm1_nsg_config" {
  network_interface_id      = azurerm_network_interface.vm1_nic.id
  network_security_group_id = azurerm_network_security_group.lb_vms_nsg.id
}
resource "azurerm_windows_virtual_machine" "vm1" {
  name                = var.vm1_name
  resource_group_name = azurerm_resource_group.rg1.name
  location            = var.location
  size                = "Standard_F2"
  admin_username      = var.vm1_username
  admin_password      = var.vm1_password
  network_interface_ids = [
    azurerm_network_interface.vm1_nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
}