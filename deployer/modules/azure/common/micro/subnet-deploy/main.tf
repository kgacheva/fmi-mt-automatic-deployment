resource "azurerm_subnet" "subnet" {
  name                 = var.az_subnet_name
  resource_group_name  = var.az_rg_name
  virtual_network_name = var.az_subnet_vnet_name
  address_prefixes     = var.az_subnet_address_prefixes
}

output "out_az_subnet" {
  value = azurerm_subnet.subnet
}
