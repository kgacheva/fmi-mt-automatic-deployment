az_rg_name                  = "JenkinsCICD"
az_rg_location              = "westus"
az_vnet_name                = "jenkinsServerVnet"
az_subnet_name              = "jenkinsServerSubnet"
az_pub_ip_name              = "jenkinsAgentPubIP"
az_pub_ip_allocation_method = "Static"
az_nsg_name                 = "jenkinsAgentNetSecGroup"
az_vnic_name                = "jenkinsAgentVNIC"
az_vnic_ip_config_name      = "jenkinsAgentVNICPubIPConfig"
az_vm_name                  = "jenkinsAgentVM"
az_vm_comp_name             = "jenkins-agent001"
az_vm_size                  = "Standard_B2s"
az_vm_os_disk = {
    name             = "os_disk_jenkins_agent"
    caching          = "ReadWrite"
    storage_acc_type = "Standard_LRS"
}
az_vm_ssh_key = {
    admin_username = "jenkins_admin"
    pubkey_path    = "~/.ssh/id_rsa_azure.pub"
    privkey_path   = "~/.ssh/id_rsa_azure"
}
az_vm_provisioner_file_source      = "../../../scripts/jenkins-agent-config.sh"
az_vm_provisioner_file_destination = "/tmp/jenkins-agent-config.sh"
az_vm_remote_exec_commands = [
    "chmod +x /tmp/jenkins-agent-config.sh",
    "sudo /tmp/jenkins-agent-config.sh"
]
az_nsg_security_rule = [{
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
}]
