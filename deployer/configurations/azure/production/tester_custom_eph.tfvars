az_rg_name                  = "TesterCustomEphemeral"
az_rg_location              = "eastus"
az_vnet_name                = "testerCustomEphVnet"
az_subnet_name              = "testerCustomEphSubnet"
az_pub_ip_name              = "testerCustomEphPubIP"
az_pub_ip_allocation_method = "Static"
az_nsg_name                 = "testerCustomEphNetSecGroup"
az_vnic_name                = "testerCustomEphVNIC"
az_vnic_ip_config_name      = "testerCustomEphVNICPubIPConfig"
az_vm_name                  = "testerCustomEphVM"
az_vm_comp_name             = "tester-custom-eph001"
az_vm_size                  = "Standard_B1s"
az_vm_os_disk = {
    name             = "os_disk_tester_custom_eph"
    caching          = "ReadWrite"
    storage_acc_type = "Standard_LRS"
}
az_vm_ssh_key = {
    admin_username = "tester"
    pubkey_path    = "~/.ssh/id_rsa_azure.pub"
    privkey_path   = "~/.ssh/id_rsa_azure"
}
