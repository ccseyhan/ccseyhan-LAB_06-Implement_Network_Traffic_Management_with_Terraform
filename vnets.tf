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

}

resource "azurerm_subnet" "vnet01_subnet0" {
    name           = "Subnet0"
    resource_group_name = azurerm_resource_group.rg1.name
    virtual_network_name = azurerm_virtual_network.vnet01.name
    address_prefixes = ["10.60.0.0/24"]
    }

resource "azurerm_subnet" "vnet01_subnet1" {
    name           = "Subnet1"
    resource_group_name = azurerm_resource_group.rg1.name
    virtual_network_name = azurerm_virtual_network.vnet01.name
    address_prefixes = ["10.60.1.0/24"]
  }

resource "azurerm_subnet" "vnet01_subnet_appgw"{
    name           = "Subnet-appgw"
    resource_group_name = azurerm_resource_group.rg1.name
    virtual_network_name = azurerm_virtual_network.vnet01.name
    address_prefixes = ["10.60.3.224/27"]
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
