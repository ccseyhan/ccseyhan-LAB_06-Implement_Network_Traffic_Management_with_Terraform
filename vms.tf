resource "azurerm_network_interface" "vm0_nic" {
  name                = "${var.vm01_name}-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg1.name

  ip_configuration {
    name                          = "vm0_configuration"
    subnet_id                     = azurerm_subnet.vnet01_subnet0.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "example" {
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