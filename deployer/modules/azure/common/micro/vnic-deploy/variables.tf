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

variable "az_vnic_location" {
    type        = string
    description = "The location for the virtual network interface card"
}

variable "az_vnic_name" {
    type        = string
    description = "The name for the virtual network interface card"
}

variable "az_vnic_ip_config_name" {
    type        = string
    description = "The name for the IP configuration for the virtual NIC"
}

variable "az_vnic_subnet_id" {
    type        = string
    description = "The ID for the subnet to which the IP for the virtual NIC connects"
}

variable "az_vnic_priv_ip_allocation" {
    type        = string
    description = "The allocation for the private IP to which the virtual NIC connects"
    default     = "Dynamic"
}

variable "az_vnic_pub_ip_id" {
    type        = string
    description = "The ID for the public IP to which the virtual NIC connects"
}

variable "az_vnic_nsg_assoc_nsg_id" {
    type        = string
    description = "The ID for the security group to establish the association with the security group"
}
