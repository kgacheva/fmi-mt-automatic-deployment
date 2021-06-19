### Assigned in the separate tfvars files or provided runtime

variable "az_service_principal" {}

variable "az_rg_name" {}

variable "az_rg_location" {}

variable "az_vnet_name" {}

variable "az_vnet_address_space" {
    default = ["10.0.0.0/24"]
}
