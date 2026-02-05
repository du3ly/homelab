module "instance" {
  source = "../../../modules/proxmox-vm"

  vm_name           = "test-server-terraform"
  vm_clone_template = "debian-12.13.0"
}
