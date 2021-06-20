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

  source_image_reference {
    publisher = var.az_vm_src_img.publisher
    offer     = var.az_vm_src_img.offer
    sku       = var.az_vm_src_img.sku
    version   = var.az_vm_src_img.version
  }

  plan {
    name      = var.az_vm_src_img_plan.name
    product   = var.az_vm_src_img_plan.product
    publisher = var.az_vm_src_img_plan.publisher
  }

  computer_name  = var.az_vm_comp_name
  admin_username = var.az_vm_admin_username
  disable_password_authentication = var.az_vm_disable_pass_auth

  admin_ssh_key {
    username       = var.az_vm_ssh_key.admin_username
    public_key     = file(var.az_vm_ssh_key.pubkey_path)
  }
}

output "out_az_vm_linux" {
  value = azurerm_linux_virtual_machine.vm_linux
}
