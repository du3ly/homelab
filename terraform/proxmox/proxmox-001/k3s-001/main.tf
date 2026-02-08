module "instance" {
  source = "../../../modules/proxmox-vm"

  vm_name = "k3s-001"
  vm_id   = 100

  cores  = 2
  memory = 4096
}
