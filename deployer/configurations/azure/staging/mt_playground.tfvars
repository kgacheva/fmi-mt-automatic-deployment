az_rg_name                  = "TemplateBuilderWorker"
az_rg_location              = "westus"
az_vnet_name                = "builderWorkerVnet"
az_subnet_name              = "builderWorkerSubnet"
az_pub_ip_name              = "builderWorkerPubIP"
az_pub_ip_allocation_method = "Static"
az_nsg_name                 = "builderWorkerNetSecGroup"
az_vnic_name                = "builderWorkerVNIC"
az_vnic_ip_config_name      = "builderWorkerVNICPubIPConfig"
az_vm_name                  = "builderWorkerNestedVM"
az_vm_comp_name             = "builder-worker001"
az_vm_size                  = "Standard_D2s_v3"
az_vm_os_disk = {
    name             = "os_disk_builder"
    caching          = "ReadWrite"
    storage_acc_type = "Standard_LRS"
}
az_vm_ssh_key = {
    admin_username = "packer_admin"
    pubkey_path    = "~/.ssh/id_rsa_azure.pub"
    privkey_path   = "~/.ssh/id_rsa_azure"
}
az_vm_provisioner_file_source      = "../../../scripts/builder-worker-config.sh"
az_vm_provisioner_file_destination = "/tmp/builder-worker-config.sh"
az_vm_remote_exec_commands = [
    "chmod +x /tmp/builder-worker-config.sh",
    "sudo /tmp/builder-worker-config.sh"
]
