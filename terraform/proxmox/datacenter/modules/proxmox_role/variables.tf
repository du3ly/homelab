variable "role_name" {
  description = "Name of the Proxmox role"
  type        = string
}

variable "privileges" {
  description = "List of Proxmox privileges to assign to the role"
  type        = list(string)
}
