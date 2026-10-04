# MetalLB Configuration

This directory contains the Layer 2 (ARP) configuration for MetalLB on the Talos Linux cluster.

## Architecture

- **Subnet:** `192.168.1.0/24`
- **LoadBalancer Pool:** `192.168.1.240 - 192.168.1.250`
- **Mode:** Layer 2 (ARP advertisement)

## Talos Specifics

1. **Privileged Pod Security Admission:**
   The `metallb-system` namespace must be labeled `privileged` because `metallb-speaker` uses `hostNetwork` and network raw capabilities:
   ```bash
   kubectl create namespace metallb-system
   kubectl label namespace metallb-system \
     pod-security.kubernetes.io/enforce=privileged \
     pod-security.kubernetes.io/audit=privileged \
     pod-security.kubernetes.io/warn=privileged
   ```

2. **Single-Node Control Plane Compatibility:**
   Talos control plane nodes are marked with `node.kubernetes.io/exclude-from-external-load-balancers`.
   In a single-node cluster, MetalLB's speaker must have `speaker.ignoreExcludeLB: true` enabled so it will advertise LoadBalancer IPs from the control plane node.

3. **Resource Optimization:**
   BGP / FRR (`frrk8s`) is disabled in `helm/argocd/applications/metallb.yaml` to conserve memory and CPU in home L2 environments.
