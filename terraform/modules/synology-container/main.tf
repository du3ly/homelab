resource "synology_container_project" "this" {
  name = var.name
  run  = var.run

  services = var.services
  configs  = var.configs
  volumes  = var.volumes
  networks = var.networks
}
