variable "username" {
  description = "Username (without @pve realm)"
  type        = string
}

variable "description" {
  description = "Human-readable description for the user"
  type        = string
  default     = ""
}

variable "token_id" {
  description = "API token identifier"
  type        = string
  default     = "terraform1"
}

variable "role_name" {
  description = "Role name to bind to this user and token"
  type        = string
}

variable "acl_path" {
  description = "Path to grant permissions on"
  type        = string
  default     = "/"
}
