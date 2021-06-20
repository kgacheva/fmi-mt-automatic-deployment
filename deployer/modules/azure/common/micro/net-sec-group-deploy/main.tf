resource "azurerm_network_security_group" "net_sec_group" {
  name                = var.az_nsg_name
  location            = var.az_nsg_location
  resource_group_name = var.az_rg_name
  security_rule       = var.az_nsg_security_rule
}

output "out_az_net_sec_group" {
  value = azurerm_network_security_group.net_sec_group
}
