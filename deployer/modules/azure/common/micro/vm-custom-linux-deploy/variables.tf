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
}

variable "az_vm_src_img_id" {
    type = string
    description = "The id for the source image from which the virtual machine is created (custom one)"
}

variable "az_vm_comp_name" {
    type        = string
    description = "The computer name for the virtual machine"
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
        privkey_path   = string
    })
    description = "The SSH key configuration used for authentication with the virtual machine"
}

variable "az_vm_provisioner_file_source" {
    type        = string
    description = "Path to a source script file to be run on the virtual machine; defaults to an empty one"
    default     = "../../../scripts/empty.sh"
}

variable "az_vm_provisioner_file_destination" {
    type        = string
    description = "Path to where to put the script file on the virtual machine; defaults to /dev/null"
    default     = "/dev/null"
}

variable "az_vm_remote_exec_commands" {
    type        = list(string)
    description = "List of commands to run on the virtual machine; defaults to the date command"
    default     = ["date"]
}
