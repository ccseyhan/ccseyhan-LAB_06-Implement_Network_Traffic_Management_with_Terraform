resource "azurerm_lb" "lb1" {
  name                = var.lb1_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg4.name
  sku = "Standard"

  frontend_ip_configuration {
    name                 = "lb_pip"
    public_ip_address_id = azurerm_public_ip.pip4.id
    }

}

resource "azurerm_lb_backend_address_pool" "lb1_backend" {
  loadbalancer_id = azurerm_lb.lb1.id
  name            = "lb1_backend"
}


resource "azurerm_lb_rule" "lb_rules" {
  loadbalancer_id                = azurerm_lb.lb1.id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "lb_pip"
  disable_outbound_snat = true
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.lb1_backend.id]
}

resource "azurerm_lb_probe" "lb1_health_probe" {
  loadbalancer_id = azurerm_lb.lb1.id
  name            = "lb1_health_probe"
  port            = 80
  protocol = "Tcp"
  interval_in_seconds = 5
}



resource "azurerm_network_interface_backend_address_pool_association" "vm0_lb_config" {
  network_interface_id    = azurerm_network_interface.vm0_nic.id
  ip_configuration_name   = "vm0_configuration"
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb1_backend.id
}

resource "azurerm_network_interface_backend_address_pool_association" "vm1_lb_config" {
  network_interface_id    = azurerm_network_interface.vm1_nic.id
  ip_configuration_name   = "vm1_configuration"
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb1_backend.id
}