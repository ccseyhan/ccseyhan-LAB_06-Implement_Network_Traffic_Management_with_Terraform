#VM0


resource "azurerm_network_interface" "vm0_nic" {
  name                 = "${var.vm0_name}-nic"
  location             = var.location
  resource_group_name  = azurerm_resource_group.rg1.name
  enable_ip_forwarding = true


  ip_configuration {
    name                          = "vm0_configuration"
    subnet_id                     = azurerm_subnet.vnet01_subnet0.id
    private_ip_address_allocation = "Dynamic"
    # load_balancer_backend_address_pools_ids = azurerm_network_interface_backend_address_pool_association.vm0_lb_config.id
    
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
  size                = "Standard_B1s"
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
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

#VM0 extensions


resource "azurerm_virtual_machine_extension" "vm01-extensions" {
  name                 = "vm01-ext-webserver"
  virtual_machine_id   = azurerm_windows_virtual_machine.vm0.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  settings = <<SETTINGS
    {
        "commandToExecute": "powershell Add-WindowsFeature Web-Server"
    }
SETTINGS

}


  #  resource "azurerm_virtual_machine_extension" "vm_extension_install_21" {
  #    name                       = "vm_extension_21"
  #    virtual_machine_id         = azurerm_windows_virtual_machine.vm0.id
  #    publisher                  = "Microsoft.Azure.Extensions"
  #    type                       = "CustomScript"
  #    type_handler_version       = "2.0"

  #    settings = <<SETTINGS
  #      {
  #          "commandToExecute": "powershell -Install-WindowsFeature -Name Routing -IncludeManagementTools -IncludeAllSubFeature"
  #      }
  #  SETTINGS
  #  }

#   resource "azurerm_virtual_machine_extension" "vm_extension_install_3" {
#     name                       = "vm_extension_3"
#     virtual_machine_id         = azurerm_windows_virtual_machine.vm0.id
#     publisher            = "Microsoft.Azure.Extensions"
#     type                 = "CustomScript"
#     type_handler_version = "2.0"

#     settings = <<SETTINGS
#       {
#           "commandToExecute": "powershell -Install-WindowsFeature -Name RSAT-RemoteAccess-Powershell"
#       }
#   SETTINGS
#   }

#   resource "azurerm_virtual_machine_extension" "vm_extension_install_4" {
#     name                       = "vm_extension_4"
#     virtual_machine_id         = azurerm_windows_virtual_machine.vm0.id
#     publisher            = "Microsoft.Azure.Extensions"
#     type                 = "CustomScript"
#     type_handler_version = "2.0"

#     settings = <<SETTINGS
#       {
#           "commandToExecute": "powershell -Install-RemoteAccess -VpnType RoutingOnly"
#       }
#   SETTINGS
#   }

#  resource "azurerm_virtual_machine_extension" "vm_extension_install_5" {
#    name                       = "vm_extension_5"
#    virtual_machine_id         = azurerm_windows_virtual_machine.vm0.id
#    publisher                  = "Microsoft.Compute"
#    type                       = "CustomScriptExtension"
#    type_handler_version       = "1.10"

#    settings = <<SETTINGS
#      {
#          "commandToExecute": "powershell -Get-NetAdapter | Set-NetIPInterface -Forwarding Enabled"
#      }
#  SETTINGS
#  }


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
  size                = "Standard_B1s"
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
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

resource "azurerm_virtual_machine_extension" "vm1-extensions" {
  name                 = "vm1-ext-webserver"
  virtual_machine_id   = azurerm_windows_virtual_machine.vm1.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  settings = <<SETTINGS
    {
        "commandToExecute": "powershell Add-WindowsFeature Web-Server"
    }
SETTINGS

}


#VM2

resource "azurerm_network_interface" "vm2_nic" {
  name                = "${var.vm2_name}-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg1.name

  ip_configuration {
    name                          = "vm2_configuration"
    subnet_id                     = azurerm_subnet.vnet2_subnet0.id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_network_interface_security_group_association" "vm2_nsg_config" {
  network_interface_id      = azurerm_network_interface.vm2_nic.id
  network_security_group_id = azurerm_network_security_group.appgw_vms_nsg.id
}
resource "azurerm_windows_virtual_machine" "vm2" {
  name                = var.vm2_name
  resource_group_name = azurerm_resource_group.rg1.name
  location            = var.location
  size                = "Standard_B1s"
  admin_username      = var.vm2_username
  admin_password      = var.vm2_password
  network_interface_ids = [
    azurerm_network_interface.vm2_nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

#VM 2 webserver extension
resource "azurerm_virtual_machine_extension" "vm2-extensions" {
  name                 = "vm2-ext-webserver"
  virtual_machine_id   = azurerm_windows_virtual_machine.vm2.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  settings = <<SETTINGS
    {
        "commandToExecute": "powershell Add-WindowsFeature Web-Server"
    }
SETTINGS

}





#VM3

resource "azurerm_network_interface" "vm3_nic" {
  name                = "${var.vm3_name}-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg1.name

  ip_configuration {
    name                          = "vm3_configuration"
    subnet_id                     = azurerm_subnet.vnet3_subnet0.id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_network_interface_security_group_association" "vm3_nsg_config" {
  network_interface_id      = azurerm_network_interface.vm3_nic.id
  network_security_group_id = azurerm_network_security_group.appgw_vms_nsg.id
}
resource "azurerm_windows_virtual_machine" "vm3" {
  name                = var.vm3_name
  resource_group_name = azurerm_resource_group.rg1.name
  location            = var.location
  size                = "Standard_B1s"
  admin_username      = var.vm3_username
  admin_password      = var.vm3_password
  network_interface_ids = [
    azurerm_network_interface.vm3_nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

resource "azurerm_virtual_machine_extension" "vm3-extensions" {
  name                 = "vm3-ext-webserver"
  virtual_machine_id   = azurerm_windows_virtual_machine.vm3.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  settings = <<SETTINGS
    {
        "commandToExecute": "powershell Add-WindowsFeature Web-Server"
    }
SETTINGS

}