module "lxc" {
  source = "../../../modules/proxmox-lxc"

  vm_id    = 300
  hostname = "gha-runner"

  ssh_key = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA0zcJs8V+rTORGKP+1Khn3sO7oTl/Q6ud82cKRcrU4S du3ly"]
}
