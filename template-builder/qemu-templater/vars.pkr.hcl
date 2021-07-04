variable "templ_os_version" {
  type        = object({
    major = string
    minor = string
    build = string
  })
  description = "The OS version for the template VM: major, minor, build"
}

variable "templ_iso_path" {
  type        = string
  description = "The name for the target path in which the ISO files are downloaded"
  default     = "isos"
}

variable "templ_http_dir" {
  type        = string
  description = "The directory containing installer files to be served over HTTP"
  default     = "installers"
}

variable "templ_boot_wait" {
  type        = string
  description = "The time to wait after bootng the VM before typing the boot command"
  default     = "5s"
}

variable "templ_cpus" {
  type        = number
  description = "The number of CPUs for the template VM"
}

variable "templ_memory" {
  type        = number
  description = "The amount of memory for the template VM, in MB"
}

variable "templ_disk_size" {
  type        = string
  description = "The size for the hard disk for the template VM"
}

variable "templ_ssh_username" {
  type        = string
  description = "The username for the account used to SSH to the template VM"
}

variable "templ_ssh_password" {
  type        = string
  description = "The password for the account used to SSH to the template VM"
  sensitive   = true
}

variable "templ_ssh_timeout" {
  type        = string
  description = "The time to wait for SSH to become available"
  default     = "20m"
}

variable "templ_depl_environment" {
  type        = string
  description = "The environment in which the template will be later deployed"
}
