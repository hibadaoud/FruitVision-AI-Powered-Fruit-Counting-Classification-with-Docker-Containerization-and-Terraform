resource "azurerm_virtual_network" "my_virtual_network" {
  name                = "P2M-virtual-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.my_resource_group.location
  resource_group_name = azurerm_resource_group.my_resource_group.name
}

resource "azurerm_subnet" "my_subnet" {
  name                 = "my-subnet"
  resource_group_name  = azurerm_resource_group.my_resource_group.name
  virtual_network_name = azurerm_virtual_network.my_virtual_network.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "my_public_ip" {
  name                = "FruitVision-public-ip"
  location            = azurerm_resource_group.my_resource_group.location
  resource_group_name = azurerm_resource_group.my_resource_group.name
  allocation_method   = "Dynamic"
  domain_name_label   = "p2mproject${random_id.unique_id.hex}" # Ensure this is unique
}

resource "random_id" "unique_id" {
  byte_length = 8
}

resource "azurerm_network_interface" "my_network_interface" {
  name                = "my-network-interface"
  location            = azurerm_resource_group.my_resource_group.location
  resource_group_name = azurerm_resource_group.my_resource_group.name

  ip_configuration {
    name                          = "my-ip-configuration"
    subnet_id                     = azurerm_subnet.my_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.my_public_ip.id
  }
}
