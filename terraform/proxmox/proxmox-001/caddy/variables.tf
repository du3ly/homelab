variable "ssh_public_key" {
  type        = string
  description = "SSH public key for the root account on the container"
  sensitive   = true
}

variable "ssh_private_key_path" {
  type        = string
  description = "Path to the SSH private key used by the remote-exec provisioner"
  default     = "~/.ssh/id_ed25519"
}
