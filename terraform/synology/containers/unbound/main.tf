module "unbound" {
  source = "../../../modules/synology-container"

  name = "unbound"
  run  = true

  services = {
    unbound = {
      image   = "alpinelinux/unbound:latest"
      restart = "unless-stopped"

      ports = [
        {
          target    = 53
          protocol  = "tcp"
          published = "53"
        },
        {
          target    = 53
          protocol  = "udp"
          published = "53"
        }
      ]

      configs = [{
        source = "unbound_records"
        target = "/etc/unbound/unbound.conf"
        mode   = "0644"
      }]
    }
  }

  configs = {
    unbound_records = {
      name    = "unbound_records"
      content = file("unbound-records.conf")
    }
  }

  networks = {
    app-network = {
      driver = "bridge"
    }
  }
}
