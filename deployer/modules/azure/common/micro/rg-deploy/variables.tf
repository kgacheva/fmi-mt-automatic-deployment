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

variable "az_rg_location" {
    type        = string
    description = "The location of the resource group"
}
