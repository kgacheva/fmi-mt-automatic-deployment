resource "azurerm_resource_group" "rg" {
  name     = var.az_rg_name
  location = var.az_rg_location
}

output "out_az_rg" {
  value = azurerm_resource_group.rg
}
