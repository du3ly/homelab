variable "name" {
  type = string
}

variable "run" {
  type    = bool
  default = true
}

variable "services" {
  type = map(object({
    image       = string
    ports       = optional(list(object({ target = number, protocol = string, published = string })))
    environment = optional(map(string))
    volumes     = optional(list(object({ type = string, source = string, target = string })))
    configs     = optional(list(object({ source = string, target = string })))
  }))
}

variable "configs" {
  type    = any
  default = {}
}

variable "volumes" {
  type    = any
  default = {}
}

variable "networks" {
  type    = any
  default = {}
}
