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

variable "az_pub_ip_location" {
    type        = string
    description = "The location for the public IP"
}

variable "az_pub_ip_name" {
    type        = string
    description = "The name for the public IP"
}

variable "az_pub_ip_allocation_method" {
    type        = string
    description = "The allocation method for the public IP"
    default     = "Dynamic"
}
