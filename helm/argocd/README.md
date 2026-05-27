# ArgoCD Installation

This directory contains the manifests for ArgoCD.

## Installation

```bash
kubectl create namespace argocd
kubectl apply --server-side --force-conflicts -n argocd -f install.yaml
```

## Post-Installation

### 1. Expose Server (LoadBalancer)
By default, the server is a ClusterIP. To expose it:
```bash
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
```

### 2. Get Admin Password
```bash
argocd admin initial-password -n argocd
```

### 3. Login
```bash
argocd login <LOAD_BALANCER_IP>
```
