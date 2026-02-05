module "instance" {
  source = "../../../modules/proxmox-vm"

  vm_name = "k3s-001"
  # vm_clone_template = "debian-bullseye"
  full_clone = false

  cores  = 2
  memory = 4096
}
