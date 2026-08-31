module "instance" {
  source = "../../../modules/proxmox-talos-vm"

  vm_name = "talos-001"
  vm_desc = "Talos Linux control plane node"
  vm_id   = 400

  cores  = 2
  memory = 1024

  iso_file = "metal-amd64.iso"
}
