### Assigned in the separate tfvars files or provided runtime

variable "az_service_principal" {}

variable "az_rg_name" {}

variable "az_rg_location" {}

variable "az_vnet_name" {}

variable "az_vnet_address_space" {
    default = ["10.0.0.0/24"]
}

variable "az_pub_ip_name" {}

variable "az_pub_ip_allocation_method" {}

variable "az_nsg_name" {}

variable "az_nsg_security_rule" {
    default = [{
        access                                     = "Allow"
        description                                = ""
        destination_address_prefix                 = "*"
        destination_address_prefixes               = []
        destination_application_security_group_ids = []
        destination_port_range                     = "22"
        destination_port_ranges                    = []
        direction                                  = "Inbound"
        name                                       = "SSH"
        priority                                   = 1001
        protocol                                   = "Tcp"
        source_address_prefix                      = "*"
        source_address_prefixes                    = []
        source_application_security_group_ids      = []
        source_port_range                          = "*"
        source_port_ranges                         = []
    },]
}
