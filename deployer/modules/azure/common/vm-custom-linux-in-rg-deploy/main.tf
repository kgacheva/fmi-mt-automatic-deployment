module "azure-vm-pub-ip" {
    source                      = "../micro/public-ip-deploy"
    az_pub_ip_name              = var.az_pub_ip_name
    az_pub_ip_allocation_method = var.az_pub_ip_allocation_method
    az_pub_ip_location          = var.az_rg_location
    az_rg_name                  = var.az_rg_name
    az_service_principal        = var.az_service_principal
}

module "azure-vm-vnic" {
    source                      = "../micro/vnic-deploy"
    az_vnic_name                = var.az_vnic_name
    az_vnic_location            = var.az_rg_location
    az_rg_name                  = var.az_rg_name
    az_service_principal        = var.az_service_principal
    az_vnic_ip_config_name      = var.az_vnic_ip_config_name
    az_vnic_pub_ip_id           = module.azure-vm-pub-ip.out_az_public_ip.id
    az_vnic_subnet_id           = var.az_vnic_subnet_id
    az_vnic_nsg_assoc_nsg_id    = var.az_vnic_nsg_assoc_nsg_id
}

module "azure-vm-vm" {
    source                      = "../micro/vm-custom-linux-deploy"
    az_vm_name                  = var.az_vm_name
    az_vm_location              = var.az_rg_location
    az_rg_name                  = var.az_rg_name
    az_service_principal        = var.az_service_principal
    az_vm_vnic_ids              = [module.azure-vm-vnic.out_az_vnic.id]
    az_vm_size                  = var.az_vm_size
    az_vm_os_disk               = var.az_vm_os_disk
    az_vm_src_img_id            = var.az_vm_src_img_id
    az_vm_comp_name             = var.az_vm_comp_name
    az_vm_ssh_key               = var.az_vm_ssh_key
    az_vm_provisioner_file_source      = var.az_vm_provisioner_file_source
    az_vm_provisioner_file_destination = var.az_vm_provisioner_file_destination
    az_vm_remote_exec_commands         = var.az_vm_remote_exec_commands
}

output "az_vm_linux" {
    value = module.azure-vm-vm.out_az_vm_linux
}
