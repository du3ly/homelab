# ArgoCD on Minikube

Run ArgoCD locally on Minikube to manage your remote k3s cluster (k3s-001 on Proxmox) using GitOps.

## Prerequisites

- minikube installed
- kubectl installed
- argocd CLI installed
- SSH access to k3s-001 VM

## Quick Start

Run the automated setup:

```bash
./setup.sh
```

## Manual Setup

### Step 1: Start Minikube

```bash
minikube start --memory=8192 --cpus=4
minikube addons enable ingress
```

### Step 2: Install ArgoCD

```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

Wait for pods to be ready:

```bash
kubectl wait --for=condition=Ready pods -l app.kubernetes.io/name=argocd-server -n argocd --timeout=300s
```

### Step 3: Access ArgoCD UI

Port-forward to ArgoCD server:

```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

Get initial admin password:

```bash
kubectl -n argocn get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

Access UI at: https://localhost:8080

### Step 4: Connect k3s-001 Cluster

Get kubeconfig from remote k3s-001 VM:

```bash
# SSH to k3s-001 and copy kubeconfig
ssh <user>@k3s-001 "sudo cat /etc/rancher/k3s/k3s.yaml"
```

Add cluster to ArgoCD:

```bash
argocd login localhost:8080
argocd cluster add <context-name> --name k3s-001
```

Verify connection:

```bash
argocd cluster list
```

## Usage

### Port-forward to ArgoCD

```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

### Login to ArgoCD CLI

```bash
argocd login localhost:8080
# Username: admin
# Password: (from Step 3)
```

### List Clusters

```bash
argocd cluster list
```

### Create Application

```bash
argocd app create my-app \
  --repo https://github.com/myrepo/myapp.git \
  --path . \
  --dest-server https://<k3s-001-api-server> \
  --dest-namespace default
```

## Troubleshooting

### Check ArgoCD pods

```bash
kubectl get pods -n argocd
```

### View ArgoCD server logs

```bash
kubectl logs -n argocd -l app.kubernetes.io/name=argocd-server
```

### Reset admin password

```bash
kubectl -n argocd delete secret argocd-initial-admin-secret
```

Then restart the argocd-server pod and get the new password:

```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```
