module "instance" {
  source = "../../../modules/proxmox-vm"

  vm_name           = "test-server-terraform"
  vm_id             = 102
  
  clone_vm_id       = 201 # debian-12.13.0
}
