#!/bin/bash
set -euo pipefail

# FluxCD Bootstrap Script for k3s via minikube
# This script bootstraps FluxCD in minikube to manage an external k3s cluster

NAMESPACE="${FLUX_NAMESPACE:-flux-system}"
K3S_SECRET_NAME="${K3S_SECRET_NAME:-k3s-cluster}"
K3S_KUBECONFIG="${K3S_KUBECONFIG:-$HOME/.kube/config-k3s}"

echo "=== FluxCD Bootstrap for k3s ==="
echo ""

# Check prerequisites
command -v flux >/dev/null 2>&1 || { echo "flux CLI not found. Please install flux."; exit 1; }
command -v kubectl >/dev/null 2>&1 || { echo "kubectl not found. Please install kubectl."; exit 1; }
command -v minikube >/dev/null 2>&1 || { echo "minikube not found. Please install minikube."; exit 1; }

# 1. Start minikube if not running
echo "[1/6] Checking minikube status..."
if ! minikube status >/dev/null 2>&1; then
    echo "Starting minikube..."
    minikube start --cpus 2 --memory 4096
else
    echo "Minikube is already running"
fi

# 2. Create namespace
echo "[2/6] Creating $NAMESPACE namespace..."
kubectl create namespace $NAMESPACE --dry-run=client -o yaml | kubectl apply -f -

# 3. Install Flux controllers
echo "[3/6] Installing Flux controllers..."
if ! flux check --namespace=$NAMESPACE 2>/dev/null | grep -q "installed"; then
    flux install \
        --namespace=$NAMESPACE \
        --network-policy=false \
        --components=source-controller,kustomize-controller,helm-controller,notification-controller \
        --export | kubectl apply -f -
    echo "Flux installed successfully"
else
    echo "Flux is already installed"
fi

# 4. Create GitRepository source
echo "[4/6] Creating GitRepository source..."
cat <<EOF | kubectl apply -f -
apiVersion: source.toolkit.fluxcd.io/v1
kind: GitRepository
metadata:
  name: flux-system
  namespace: $NAMESPACE
spec:
  interval: 30s
  ref:
    branch: main
  url: https://github.com/duelyyung/homelab
EOF

# 5. Create K3s cluster secret (if kubeconfig exists)
echo "[5/6] Setting up k3s cluster secret..."
if [ -f "$K3S_KUBECONFIG" ]; then
    kubectl create secret generic $K3S_SECRET_NAME \
        --from-file=value=$K3S_KUBECONFIG \
        --namespace=$NAMESPACE \
        --dry-run=client -o yaml | kubectl apply -f -
    echo "k3s cluster secret created"
else
    echo "k3s kubeconfig not found at $K3S_KUBECONFIG, skipping secret creation"
fi

# 6. Apply cluster configurations
echo "[6/6] Applying cluster configurations..."
kubectl apply -f "$(dirname "$0")/../clusters/"

echo ""
echo "=== Bootstrap complete ==="
echo ""
echo "Verify with:"
echo "  flux get sources git"
echo "  flux get kustomizations"
echo "  kubectl get pods -n $NAMESPACE"
