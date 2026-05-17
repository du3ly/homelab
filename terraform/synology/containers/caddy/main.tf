module "caddy" {
  source = "../../../modules/synology-container"

  name = "caddy"
  run  = true

  services = {
    caddy = {
      image   = "caddy:latest"
      restart = "unless-stopped"

      ports = [
        {
          target    = 80
          protocol  = "tcp"
          published = "80"
        },
        {
          target    = 443
          protocol  = "tcp"
          published = "443"
        }
      ]

      configs = [{
        source = "caddyfile"
        target = "/etc/caddy/Caddyfile"
        mode   = "0644"
      }]
    }
  }

  configs = {
    caddyfile = {
      name    = "caddyfile"
      content = file("Caddyfile")
    }
  }

  networks = {
    app-network = {
      driver = "bridge"
    }
  }
}
