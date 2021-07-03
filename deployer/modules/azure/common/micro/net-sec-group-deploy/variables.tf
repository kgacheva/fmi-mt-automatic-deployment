variable "az_service_principal" {
    type = object({
        subscription_id = string
        client_id       = string
        client_secret   = string
        tenant_id       = string
    })

    description = "The service principal for authenticating the Azure Provider"
    sensitive   = true
}


variable "az_rg_name" {
    type        = string
    description = "The name of the resource group"
}

variable "az_nsg_location" {
    type        = string
    description = "The location for the network security group"
}

variable "az_nsg_name" {
    type        = string
    description = "The name for the network security group"
}

variable "az_nsg_security_rule" {
    type = list(object({
        access                                     = string
        description                                = string
        destination_address_prefix                 = string
        destination_address_prefixes               = list(string)
        destination_application_security_group_ids = list(string)
        destination_port_range                     = string
        destination_port_ranges                    = list(string)
        direction                                  = string
        name                                       = string
        priority                                   = number
        protocol                                   = string
        source_address_prefix                      = string
        source_address_prefixes                    = list(string)
        source_application_security_group_ids      = list(string)
        source_port_range                          = string
        source_port_ranges                         = list(string)
    }))
    description = "The list of security rules for the network security group"
}
