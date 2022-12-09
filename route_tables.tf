resource "azurerm_route_table" "route23" {
  name                = var.route23_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg1.name
}

resource "azurerm_route" "routefrom2to3" {
  name                = "routefrom2to3"
  resource_group_name = azurerm_resource_group.rg1.name
  route_table_name    = azurerm_route_table.route23.name
  address_prefix      = "10.63.0.0/20"
  next_hop_type       = "VirtualAppliance"
  next_hop_in_ip_address ="10.60.0.4"
}

resource "azurerm_subnet_route_table_association" "rt23_association" {
  subnet_id      = azurerm_subnet.vnet2_subnet0.id
  route_table_id = azurerm_route_table.route23.id
}

resource "azurerm_route_table" "route32" {
  name                = var.route32_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg1.name
}

resource "azurerm_route" "routefrom3to2" {
  name                = "routefrom3to2"
  resource_group_name = azurerm_resource_group.rg1.name
  route_table_name    = azurerm_route_table.route32.name
  address_prefix      = "10.62.0.0/20"
  next_hop_type       = "VirtualAppliance"
  next_hop_in_ip_address ="10.60.0.4"
}

resource "azurerm_subnet_route_table_association" "tr32_association" {
  subnet_id      = azurerm_subnet.vnet3_subnet0.id
  route_table_id = azurerm_route_table.route32.id
}