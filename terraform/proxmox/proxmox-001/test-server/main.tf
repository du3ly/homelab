module "instance" {
  source = "../../../modules/proxmox-vm"

  vm_name = "test-server-terraform"
  vm_id   = 102

  vm_clone_template = 201 # debian-12.13.0
}
