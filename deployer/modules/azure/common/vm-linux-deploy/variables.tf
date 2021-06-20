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

variable "az_vm_location" {
    type        = string
    description = "The location for the virtual machine"
    default     = "westus"
}

variable "az_vm_name" {
    type        = string
    description = "The name for the virtual machine"
}

variable "az_vm_vnic_ids" {
    type        = list(string)
    description = "The IDs for the virtual NICs connected to the virtual machine"
}

variable "az_vm_size" {
    type        = string
    description = "The size for the virtual machine"
    default     = "Standard_B1s"
}

variable "az_vm_os_disk" {
    type = object({
        name             = string
        caching          = string
        storage_acc_type = string
    })
    description = "The OS disk for the virtual machine"
    default = {
        name             = "os_disk_1"
        caching          = "ReadWrite"
        storage_acc_type = "Standard_LRS"
    }
}

variable "az_vm_src_img" {
    type = object({
        publisher = string
        offer     = string
        sku       = string
        version   = string
    })
    description = "The source image from which the virtual machine is created (marketplace one)"
}

variable "az_vm_src_img_plan" {
    type = object({
        name      = string
        product   = string
        publisher = string
    })
    description = "The plan for the source image from which the virtual machine is created (marketplace one)"
}

variable "az_vm_comp_name" {
    type        = string
    description = "The computer name for the virtual machine"
}

variable "az_vm_admin_username" {
    type        = string
    description = "The username for the admin account for the virtual machine"
}

variable "az_vm_disable_pass_auth" {
    type        = bool
    description = "Flag whether the password-based authentication for the admin account is disabled"
    default     = true
}

variable "az_vm_ssh_key" {
    type = object({
        admin_username = string
        pubkey_path    = string
    })
    description = "The SSH key configuration used for authentication with the virtual machine"
}
