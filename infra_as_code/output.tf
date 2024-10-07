output "public_ip_address" {
  value = azurerm_public_ip.my_public_ip.ip_address
  description = "The public IP address of the virtual machine."
}