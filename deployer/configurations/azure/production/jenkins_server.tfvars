az_rg_name                  = "JenkinsCICD"
az_rg_location              = "westus"
az_vnet_name                = "jenkinsServerVnet"
az_subnet_name              = "jenkinsServerSubnet"
az_pub_ip_name              = "jenkinsServerPubIP"
az_pub_ip_allocation_method = "Static"
az_nsg_name                 = "jenkinsServerNetSecGroup"
az_vnic_name                = "jenkinsServerVNIC"
az_vnic_ip_config_name      = "jenkinsServerVNICPubIPConfig"
az_vm_name                  = "jenkinsServerVM"
az_vm_comp_name             = "jenkins-server001"
az_vm_size                  = "Standard_B1s"
az_vm_os_disk = {
    name             = "os_disk_jenkins_server"
    caching          = "ReadWrite"
    storage_acc_type = "Standard_LRS"
}
az_vm_ssh_key = {
    admin_username = "jenkins_admin"
    pubkey_path    = "~/.ssh/id_rsa_azure.pub"
    privkey_path   = "~/.ssh/id_rsa_azure"
}
az_vm_provisioner_file_source      = "../../../scripts/jenkins-server-config.sh"
az_vm_provisioner_file_destination = "/tmp/jenkins-server-config.sh"
az_vm_remote_exec_commands = [
    "chmod +x /tmp/jenkins-server-config.sh",
    "sudo /tmp/jenkins-server-config.sh"
]
