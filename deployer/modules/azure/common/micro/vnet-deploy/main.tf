resource "azurerm_virtual_network" "vnet" {
  name                = var.az_vnet_name
  address_space       = var.az_vnet_address_space
  location            = var.az_vnet_location
  resource_group_name = var.az_rg_name
}

output "out_az_vnet" {
  value = azurerm_virtual_network.vnet
}
