
resource "azurerm_network_security_group" "my_network_security_group" {
  name                = "my-network-security-group"
  location            = azurerm_resource_group.my_resource_group.location
  resource_group_name = azurerm_resource_group.my_resource_group.name
}

resource "azurerm_network_security_rule" "ssh_access" {
  name                        = "ssh-access"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = var.my_ip
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.my_resource_group.name
  network_security_group_name = azurerm_network_security_group.my_network_security_group.name
}

resource "azurerm_network_security_rule" "allow_all_traffic" {
  name                        = "allow-all-traffic"
  priority                    = 200
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.my_resource_group.name
  network_security_group_name = azurerm_network_security_group.my_network_security_group.name
}

resource "azurerm_network_interface_security_group_association" "my_nic_nsg_association" {
  network_interface_id      = azurerm_network_interface.my_network_interface.id
  network_security_group_id = azurerm_network_security_group.my_network_security_group.id
}