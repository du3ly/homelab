module "unbound" {
  source = "../../../modules/synology-container"

  name = "unbound"
  run  = true

  services = {
    unbound = {
      image = "mvout/unbound:latest"

      ports = [
        {
          target    = 53
          published = "53"
        }
      ]

      volumes = [
        {
          type   = "volume"
          source = "unbound-data"
          target = "/opt/unbound/etc/unbound"
        }
      ]
    }
  }

  volumes = {
    unbound-data = {
      driver = "local"
    }
  }

  networks = {
    unbound-network = {
      driver = "bridge"
    }
  }
}
