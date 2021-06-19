resource "azurerm_public_ip" "pub_ip" {
  name                = var.az_pub_ip_name
  allocation_method   = var.az_pub_ip_allocation_method
  location            = var.az_pub_ip_location
  resource_group_name = var.az_rg_name
}

output "out_az_public_ip" {
  value = azurerm_public_ip.pub_ip
}
