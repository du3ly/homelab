# Garage

A S3-like software that is running in Synology DSM Container Manager that is used to store state for Terraform.

## Instruction
1. Create a directory under `/volume1/docker/garage`
2. Copy `garage.toml` to `/volume1/docker/garage/garage.toml`
3. Copy `garage-synology-docker-compose.yaml` to Synology Container Manager
4. Manual configuration (https://garagehq.deuxfleurs.fr/documentation/quick-start/#manual-configuration)
5. Enable SSH on Synology DSM to run the garage cli from the container
6. After everything is working, then disable SSH

## Updating garage.toml
In case `garage.toml` needs to be updated, please do the following:
1. Create a PR to update `homelab/synology/garage.toml`
2. Manually update `garage.toml` in `/volume1/docker/garage/garage.toml`

## Thoughts
Ideally, this should be automated, but it might run into a chicken and egg situation if we were to use Terraform to manage state. In addition,
I do not want to enable SSH on the Synology NAS.
