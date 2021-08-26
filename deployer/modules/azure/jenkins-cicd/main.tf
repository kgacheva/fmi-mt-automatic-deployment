locals {
    az_service_principal = {
        subscription_id = var.az_subscription_id
        client_id       = var.az_client_id
        tenant_id       = var.az_tenant_id
        client_secret   = var.az_client_secret
    }
}

module "azure-vm-rg" {
    source                      = "../common/micro/rg-deploy"
    az_rg_name                  = var.az_rg_name
    az_rg_location              = var.az_rg_location
    az_service_principal        = local.az_service_principal
}

module "azure-vm-vnet" {
    source                      = "../common/micro/vnet-deploy"
    az_vnet_name                = var.az_vnet_name
    az_vnet_location            = module.azure-vm-rg.out_az_rg.location
    az_rg_name                  = module.azure-vm-rg.out_az_rg.name
    az_service_principal        = local.az_service_principal
    az_vnet_address_space       = var.az_vnet_address_space
}

module "azure-vm-subnet" {
    source                      = "../common/micro/subnet-deploy"
    az_subnet_name              = var.az_subnet_name
    az_rg_name                  = module.azure-vm-rg.out_az_rg.name
    az_service_principal        = local.az_service_principal
    az_subnet_vnet_name         = module.azure-vm-vnet.out_az_vnet.name
    az_subnet_address_prefixes  = var.az_subnet_address_prefixes
}

module "azure-vm-net-sec-group" {
    source                      = "../common/micro/net-sec-group-deploy"
    az_nsg_name                 = var.az_nsg_name
    az_nsg_location             = module.azure-vm-rg.out_az_rg.location
    az_rg_name                  = module.azure-vm-rg.out_az_rg.name
    az_service_principal        = local.az_service_principal
    az_nsg_security_rule        = var.az_nsg_security_rule
}

module "azure-jenkins-cicd-vm" {
    source                             = "../common/vm-linux-in-rg-deploy"
    az_service_principal               = local.az_service_principal
    az_rg_name                         = module.azure-vm-rg.out_az_rg.name
    az_rg_location                     = module.azure-vm-rg.out_az_rg.location
    az_vnic_subnet_id                  = module.azure-vm-subnet.out_az_subnet.id
    az_vnic_nsg_assoc_nsg_id           = module.azure-vm-net-sec-group.out_az_net_sec_group.id
    az_pub_ip_name                     = var.az_pub_ip_name
    az_pub_ip_allocation_method        = var.az_pub_ip_allocation_method
    az_nsg_name                        = var.az_nsg_name
    az_vnic_name                       = var.az_vnic_name
    az_vnic_ip_config_name             = var.az_vnic_ip_config_name
    az_vm_name                         = var.az_vm_name
    az_vm_size                         = var.az_vm_size
    az_vm_os_disk                      = var.az_vm_os_disk
    az_vm_src_img                      = var.az_vm_src_img
    az_vm_src_img_plan                 = var.az_vm_src_img_plan
    az_vm_comp_name                    = var.az_vm_comp_name
    az_vm_ssh_key                      = var.az_vm_ssh_key
    az_vm_provisioner_file_source      = var.az_vm_provisioner_file_source
    az_vm_provisioner_file_destination = var.az_vm_provisioner_file_destination
    az_vm_remote_exec_commands         = var.az_vm_remote_exec_commands
}
