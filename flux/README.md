# FluxCD Bootstrap for k3s

This directory contains the FluxCD bootstrap configuration for managing an external k3s cluster using minikube as the bootstrap cluster.

## Architecture

- **Bootstrap Cluster**: minikube runs locally and hosts the Flux controllers
- **Managed Cluster**: External k3s cluster (on Proxmox) managed via Flux's multi-cluster setup
- **Git Source**: This repository contains the cluster manifests

## Prerequisites

- minikube installed and running
- kubectl configured
- flux CLI installed

## Setup

### 1. Start minikube

```bash
minikube start --cpus 2 --memory 4096
```

### 2. Install Flux controllers

```bash
flux install \
  --namespace=flux-system \
  --network-policy=false \
  --components=source-controller,kustomize-controller,helm-controller,notification-controller
```

### 3. Add your Git repository

```bash
flux create source git flux-system \
  --url=https://github.com/duelyyung/homelab \
  --branch=main \
  --interval=30s \
  --namespace=flux-system
```

### 4. Create k3s cluster secret

```bash
# Get your k3s kubeconfig
kubectl create secret generic k3s-cluster \
  --from-file=value=kubeconfig-k3s.yaml \
  --namespace=flux-system
```

### 5. Apply the cluster configuration

```bash
kubectl apply -f clusters/
```

## Directory Structure

```
flux/
├── README.md
├── clusters/
│   └── k3s/
│       ├── kustomization.yaml
│       └── flux-sync.yaml
├── bootstrap/
│   └── flux-install.yaml
└── scripts/
    └── bootstrap.sh
```

## Verification

```bash
# Check flux status
flux get sources git
flux get kustomizations

# Check reconciliation
flux reconcile kustomization flux-system
```

## Troubleshooting

```bash
# View flux logs
kubectl logs -n flux-system deploy/source-controller
kubectl logs -n flux-system deploy/kustomize-controller
```
