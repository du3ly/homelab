module "registry" {
  source = "../../../modules/synology-container"

  name = "registry"
  run  = true

  services = {
    registry = {
      image = "registry:latest"

      ports = [{
        target    = 5000
        published = "6000"
      }]

      volumes = [{
        type   = "volume"
        source = "registry-data"
        target = "/var/lib/registry"
      }]

      environment = {
        REGISTRY_STORAGE_FILESYSTEM_ROOTDIRECTORY = "/var/lib/registry"
      }
    }
  }

  volumes = {
    registry-data = {
      driver = "local"
    }
  }

  networks = {
    app-network = {
      driver = "bridge"
    }
  }
}
