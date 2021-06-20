resource "azurerm_network_interface" "vnic" {
  name                = var.az_vnic_name
  location            = var.az_vnic_location
  resource_group_name = var.az_rg_name

  ip_configuration {
    name                          = var.az_vnic_ip_config_name
    subnet_id                     = var.az_vnic_subnet_id
    private_ip_address_allocation = var.az_vnic_priv_ip_allocation
    public_ip_address_id          = var.az_vnic_pub_ip_id
  }
}

# Connect security group to network interface
resource "azurerm_network_interface_security_group_association" "vnic_nsg" {
    network_interface_id      = azurerm_network_interface.vnic.id
    network_security_group_id = var.az_vnic_nsg_assoc_nsg_id
}

output "out_az_vnic" {
  value = azurerm_network_interface.vnic
}
