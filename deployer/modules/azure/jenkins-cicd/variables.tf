### Assigned in the separate tfvars files or provided runtime

variable "az_service_principal" {}

variable "az_rg_name" {}

variable "az_rg_location" {}

variable "az_vnet_name" {}

variable "az_vnet_address_space" {
    default = ["10.0.0.0/24"]
}

variable "az_subnet_name" {}

variable "az_subnet_address_prefixes" {
    default = ["10.0.0.0/26"]
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
    },{
        access                                     = "Allow"
        description                                = ""
        destination_address_prefix                 = "*"
        destination_address_prefixes               = []
        destination_application_security_group_ids = []
        destination_port_range                     = "8080"
        destination_port_ranges                    = []
        direction                                  = "Inbound"
        name                                       = "HTTP"
        priority                                   = 1010
        protocol                                   = "Tcp"
        source_address_prefix                      = "*"
        source_address_prefixes                    = []
        source_application_security_group_ids      = []
        source_port_range                          = "*"
        source_port_ranges                         = []
    }]
}

variable "az_vnic_name" {}

variable "az_vnic_ip_config_name" {}

variable "az_vm_name" {}

variable "az_vm_size" {}

variable "az_vm_os_disk" {}

variable "az_vm_src_img" {
    default = {
        publisher = "cognosys"
        offer     = "ubuntu-18-04-lts-free"
        sku       = "hardened-ubuntu-18-04-lts-freesku"
        version   = "1.2019.0710"
    }
}

variable "az_vm_src_img_plan" {
    default = {
        name      = "hardened-ubuntu-18-04-lts-freesku"
        product   = "ubuntu-18-04-lts-free"
        publisher = "cognosys"
    }
}

variable "az_vm_comp_name" {}

variable "az_vm_ssh_key" {}

variable "az_vm_provisioner_file_source" {}

variable "az_vm_provisioner_file_destination" {}

variable "az_vm_remote_exec_commands" {}
