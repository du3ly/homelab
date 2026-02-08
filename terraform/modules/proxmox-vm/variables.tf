variable "cores" {
  type    = number
  default = 1
}

variable "disk_size_gb" {
  type    = number
  default = 32
}

variable "disk_storage" {
  type        = string
  description = "The ID of the storage pool on which to store the disk"
  default     = "vmstore"
}

variable "memory" {
  type    = number
  default = 1024
}

variable "pm_api_url" {
  type    = string
  default = "192.168.1.20"
}

variable "target_node" {
  type        = string
  description = "The name of the Proxmox Node on which to place the VM"
  default     = "proxmox-001"
}

variable "vm_desc" {
  type        = string
  description = "The description of the VM. Shows as the 'Notes' field in the Proxmox GUI"
  default     = ""
}

variable "vm_name" {
  type    = string
  default = ""
}

variable "vm_id" {
  type    = number
}

variable "clone_vm_id" {
  type        = number
  description = "VMID of the template to clone from"
  default     = 0
}

variable "disk_backup" {
  type    = bool
  default = true
}
