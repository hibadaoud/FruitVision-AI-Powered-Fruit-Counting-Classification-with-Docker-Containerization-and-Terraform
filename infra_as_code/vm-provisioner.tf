resource "null_resource" "vm_provisioner" {
  # Trigger the provisioners when the public IP changes
  triggers = {
    public_ip = azurerm_public_ip.my_public_ip.ip_address
  }
  depends_on = [
    local_file.docker_compose_yml,
    azurerm_linux_virtual_machine.my_virtual_machine,
    azurerm_public_ip.my_public_ip,
  ]

  # Use the file provisioner to copy the install_docker.sh script
  provisioner "file" {
    source      = "${path.module}/files/install_docker.sh"
    destination = "/home/adminuser/install_docker.sh"
  
    connection {
      type        = "ssh"
      user        = "adminuser"
      private_key = file("~/.ssh/id_rsa")
      host        = "${azurerm_public_ip.my_public_ip.domain_name_label}.${azurerm_public_ip.my_public_ip.location}.cloudapp.azure.com"
    }
  }

  # Use the file provisioner to copy the docker-compose.yml file
  provisioner "file" {
    source      = "${path.module}/files/docker-compose.yml"
    destination = "/home/adminuser/docker-compose.yml"

    connection {
      type        = "ssh"
      user        = "adminuser"
      private_key = file("~/.ssh/id_rsa")
      host        = "${azurerm_public_ip.my_public_ip.domain_name_label}.${azurerm_public_ip.my_public_ip.location}.cloudapp.azure.com"
    }
  }

  # Use the remote-exec provisioner to run the install_docker.sh script
  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/adminuser/install_docker.sh",
      "sudo /home/adminuser/install_docker.sh"
    ]

    connection {
      type        = "ssh"
      user        = "adminuser"
      private_key = file("~/.ssh/id_rsa")
      host        = "${azurerm_public_ip.my_public_ip.domain_name_label}.${azurerm_public_ip.my_public_ip.location}.cloudapp.azure.com"
    }
  }
  
}