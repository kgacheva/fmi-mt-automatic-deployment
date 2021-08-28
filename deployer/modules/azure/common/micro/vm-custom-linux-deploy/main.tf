resource "azurerm_linux_virtual_machine" "vm_linux" {
  name                  = var.az_vm_name
  location              = var.az_vm_location
  resource_group_name   = var.az_rg_name
  network_interface_ids = var.az_vm_vnic_ids
  size                  = var.az_vm_size

  os_disk {
    name                 = var.az_vm_os_disk.name
    caching              = var.az_vm_os_disk.caching
    storage_account_type = var.az_vm_os_disk.storage_acc_type
  }

  source_image_id = var.az_vm_src_img_id

  computer_name  = var.az_vm_comp_name
  admin_username = var.az_vm_ssh_key.admin_username
  disable_password_authentication = var.az_vm_disable_pass_auth

  admin_ssh_key {
    username   = var.az_vm_ssh_key.admin_username
    public_key = file(var.az_vm_ssh_key.pubkey_path)
  }

  provisioner "file" {
    source      = var.az_vm_provisioner_file_source
    destination = var.az_vm_provisioner_file_destination

    connection {
      type        = "ssh"
      user        = var.az_vm_ssh_key.admin_username
      private_key = file(var.az_vm_ssh_key.privkey_path)
      host        = azurerm_linux_virtual_machine.vm_linux.public_ip_address
    }
  }

  provisioner "remote-exec" {
    inline     = var.az_vm_remote_exec_commands
    on_failure = continue

    connection {
      type        = "ssh"
      user        = var.az_vm_ssh_key.admin_username
      private_key = file(var.az_vm_ssh_key.privkey_path)
      host        = azurerm_linux_virtual_machine.vm_linux.public_ip_address
    }
  }
}

output "out_az_vm_linux" {
  value = azurerm_linux_virtual_machine.vm_linux
}
