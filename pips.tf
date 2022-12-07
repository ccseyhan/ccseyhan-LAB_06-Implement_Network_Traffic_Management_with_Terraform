resource "azurerm_public_ip" "pip4" {
  name                = var.pip4_name
  resource_group_name = azurerm_resource_group.rg4.name
  location            = var.location
  allocation_method   = "Static"


}


resource "azurerm_public_ip" "pip5" {
  name                = var.pip5_name
  resource_group_name = azurerm_resource_group.rg5.name
  location            = var.location
  allocation_method   = "Static"


}
