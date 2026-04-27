module "lxc" {
  source = "../../../modules/proxmox-lxc"

  vm_id    = 300
  hostname = "gha-runner"
}
