variable "proxmox_token" {
  type    = string
  sensitive = true
  default = "${env("PROXMOX_TOKEN")}"
}

variable "proxmox_user" {
  type    = string
  default = "packer@pve!packer1"
}

variable "preseed_file" {
  type    = string
  default = "http/debian.preseed"
}

variable "ssh_username" {
  type    = string
  default = "ansible"
}

variable "ssh_password" {
  type    = string
  sensitive = true
  default = "${env("SSH_PASSWORD")}"
}
