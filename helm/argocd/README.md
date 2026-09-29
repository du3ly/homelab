# ArgoCD Installation

This directory contains the ArgoCD configurations, AppProjects, applications, and bootstrap manifests for GitOps management.

## Installation (Helm)

To bootstrap ArgoCD so that it cleanly aligns with the self-managed configuration in `applications/argocd-self-manage.yaml`:

```bash
# 1. Add Argo Helm repository
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update

# 2. Create namespace
kubectl create namespace argocd

# 3. Install ArgoCD via Helm
helm install argocd argo/argo-cd -n argocd --version 9.5.17 \
  --set dex.enabled=false \
  --set notifications.enabled=false \
  --set applicationSet.enabled=false \
  --set server.service.type=NodePort \
  --set server.service.nodePortHttps=30443
```

## Bootstrap App-of-Apps

Once the base ArgoCD pods are running, bootstrap the GitOps root application:

```bash
# 1. Apply system AppProject
kubectl apply -f helm/argocd/app-projects/system.yaml

# 2. Apply root application (recursively manages applications/)
kubectl apply -f helm/argocd/bootstrap/root-app.yaml
```

## Post-Installation

### 1. GitHub Actions Runner Secret (Required for ARC)

If using the GitHub Actions Runner Controller (`arc-runner-set`), create the GitHub PAT secret:

```bash
kubectl create namespace arc-runners
kubectl create secret generic pre-defined-secret \
  -n arc-runners \
  --from-literal=github_token=<YOUR_GITHUB_PAT>
```

### 2. Get Initial Admin Password

```bash
argocd admin initial-password -n argocd
```

### 3. Access UI & Login

- **UI (NodePort):** `https://<NODE_IP>:30443`
- **CLI Login:**
  ```bash
  argocd login <NODE_IP>:30443
  ```

> [!NOTE]
> Once MetalLB is running and configured with an IP pool, ArgoCD can be switched to `LoadBalancer` directly in `helm/argocd/applications/argocd-self-manage.yaml`.
