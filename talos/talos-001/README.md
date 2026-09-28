# Talos - talos-001

Single-node Talos Linux cluster running on Proxmox (`proxmox-001`, VM ID 400).

## Prerequisites

- VM provisioned via Terraform: `terraform/proxmox/proxmox-001/talos-001`
- `talosctl` installed (see `Brewfile`)

## Applying Patches

To apply a patch to the running cluster:

```bash
talosctl patch machineconfig --nodes <CONTROL_PLANE_IP> \
  --patch @talos/talos-001/patches/controlplane.yaml
```

## Patches

| Patch | Purpose |
|-------|---------|
| `patches/controlplane.yaml` | Allow workload scheduling on control plane (single-node cluster) |

## Fresh Install Reference

If rebuilding from scratch:

```bash
# 1. Generate secrets (do NOT commit)
talosctl gen secrets -o talos/talos-001/secrets.yaml

# 2. Generate config with patches
talosctl gen config talos-001 https://<CONTROL_PLANE_IP>:6443 \
  --with-secrets talos/talos-001/secrets.yaml \
  --config-patch @talos/talos-001/patches/controlplane.yaml \
  --output talos/talos-001/generated/

# 3. Apply config
talosctl apply-config --insecure \
  --nodes <NODE_IP> \
  --file talos/talos-001/generated/controlplane.yaml

# 4. Bootstrap
talosctl bootstrap --nodes <CONTROL_PLANE_IP> \
  --endpoints <CONTROL_PLANE_IP> \
  --talosconfig talos/talos-001/generated/talosconfig

# 5. Get kubeconfig
talosctl kubeconfig --nodes <CONTROL_PLANE_IP> \
  --endpoints <CONTROL_PLANE_IP> \
  --talosconfig talos/talos-001/generated/talosconfig
```
