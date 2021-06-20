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

variable "az_vnet_location" {
    type        = string
    description = "The location for the virtual network"
}

variable "az_vnet_name" {
    type        = string
    description = "The name for the virtual network"
}

variable "az_vnet_address_space" {
    type        = list(string)
    description = "The address space for the virtual network"
    default     = ["10.0.0.0/16"]
}
