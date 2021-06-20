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

variable "az_subnet_name" {
    type        = string
    description = "The name for the subnet part of the virtual network"
}

variable "az_subnet_vnet_name" {
    type        = string
    description = "The name for the virtual network part of which is the subnet"
}

variable "az_subnet_address_prefixes" {
    type        = list(string)
    description = "The address prefixes for the subnet"
    default     = ["10.0.0.0/24"]
}
