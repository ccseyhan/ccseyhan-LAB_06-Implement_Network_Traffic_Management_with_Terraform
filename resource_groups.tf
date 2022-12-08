resource "azurerm_resource_group" "rg1" {
  name     = var.rg1_name
  location = var.location
}

resource "azurerm_resource_group" "rg4" {
  name     = var.rg4_name
  location = var.location

}

resource "azurerm_resource_group" "rg5" {
  name     = var.rg5_name
  location = var.location
}