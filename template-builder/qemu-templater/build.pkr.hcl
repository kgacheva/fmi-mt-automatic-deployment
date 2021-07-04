locals {
  # templ_os_vers_full = "${join(keys(var.templ_os_version), ".")}"
  templ_os_vers_full = "${var.templ_os_version.major}.${var.templ_os_version.minor}.${var.templ_os_version.build}"
  ks_filename_min = "${var.templ_os_version.major}_${var.templ_os_version.minor}_minimal.cfg" 
}

source "qemu" "centos79_minimal" {
  boot_command     = [
    "<tab> text ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/centos/${local.ks_filename_min}<enter><wait>"
  ]
  boot_wait         = "${var.templ_boot_wait}"
  cpus              = "${var.templ_cpus}"
  memory            = "${var.templ_memory}"
  disk_size         = "${var.templ_disk_size}"
  headless          = true
  format            = "raw"
  http_directory    = "${var.templ_http_dir}"
  iso_checksum      = "file:https://mirrors.neterra.net/centos/${local.templ_os_vers_full}/isos/x86_64/sha256sum.txt"
  iso_target_path   = "${var.templ_iso_path}"
  iso_urls          = [
    "${var.templ_iso_path}/CentOS-${var.templ_os_version.major}-x86_64-Minimal-${var.templ_os_version.build}.iso",
    "https://mirrors.neterra.net/centos/${local.templ_os_vers_full}/isos/x86_64/CentOS-${var.templ_os_version.major}-x86_64-Minimal-${var.templ_os_version.build}.iso"
  ]
  shutdown_command  = "echo '${var.templ_ssh_password}' | sudo -S /sbin/halt -h -p"
  ssh_timeout       = "${var.templ_ssh_timeout}"
  ssh_username      = "${var.templ_ssh_username}"
  ssh_password      = "${var.templ_ssh_password}"
}

build {
  sources = ["source.qemu.centos79_minimal"]

  provisioner "shell" {
    execute_command   = "chmod +x {{ .Path }}; {{ .Vars }} sudo -E sh '{{ .Path }}'"
    expect_disconnect = true
    script            = "provisioners/prepare-for-${var.templ_depl_environment}.sh"
  }
}
