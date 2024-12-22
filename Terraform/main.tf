provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "my_resource_group" {
  name     = "my-resource-group"
  location = "West Europe"
}

resource "azurerm_linux_virtual_machine" "my_virtual_machine" {
  name                  = "FruitVision"
  resource_group_name   = azurerm_resource_group.my_resource_group.name
  location              = azurerm_resource_group.my_resource_group.location
  size                  = "Standard_B2s"
  admin_username        = "adminuser"
  network_interface_ids = [azurerm_network_interface.my_network_interface.id]

  disable_password_authentication = true

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  depends_on = [
    azurerm_public_ip.my_public_ip,
  ]
}

data "template_file" "docker_compose" {
  template =file("${path.module}/docker-compose.tpl")

  vars = {
    ip_address = azurerm_public_ip.my_public_ip.ip_address  
  }
}

resource "local_file" "docker_compose_yml" {
  content  = data.template_file.docker_compose.rendered
  filename = "${path.module}/files/docker-compose.yml"
}
