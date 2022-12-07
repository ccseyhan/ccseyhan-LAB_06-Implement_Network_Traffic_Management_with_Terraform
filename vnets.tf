resource "azurerm_network_security_group" "lb_vms_nsg" {
  name                = "lb_vms_nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg1.name
}

resource "azurerm_network_security_group" "appgw_vms_nsg" {
  name                = "appgw_vms_nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg1.name
}


resource "azurerm_virtual_network" "vnet01" {
  name                = var.vnet01_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg1.name
  address_space       = ["10.60.0.0/22"]

  subnet {
    name           = "Subnet0"
    address_prefix = "10.60.0.0/24"
  }

  subnet {
    name           = "Subnet1"
    address_prefix = "10.60.1.0/24"
  }

  subnet {
    name           = "Subnet-appgw"
    address_prefix = "10.60.3.224/27"
  }


}






resource "azurerm_virtual_network" "vnet2" {
  name                = var.vnet2_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg1.name
  address_space       = ["10.62.0.0/22"]
  

  subnet {
    name           = "subnet0"
    address_prefix = "10.62.0.0/24"
  }






}

resource "azurerm_virtual_network" "vnet3" {
  name                = var.vnet3_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg1.name
  address_space       = ["10.63.0.0/22"]
  

  subnet {
    name           = "subnet0"
    address_prefix = "10.63.0.0/24"
  }


}
