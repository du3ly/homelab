#!/bin/bash
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo_step() {
    echo -e "\n${GREEN}==>${NC} $1"
}

echo_warn() {
    echo -e "${YELLOW}WARNING:${NC} $1"
}

echo_error() {
    echo -e "${RED}ERROR:${NC} $1"
}

# Check prerequisites
check_prerequisites() {
    echo_step "Checking prerequisites..."

    if ! command -v minikube &> /dev/null; then
        echo_error "minikube is not installed"
        exit 1
    fi

    if ! command -v kubectl &> /dev/null; then
        echo_error "kubectl is not installed"
        exit 1
    fi

    if ! command -v argocd &> /dev/null; then
        echo_warn "argocd CLI is not installed. Installing..."
        brew install argocd
    fi

    echo -e "${GREEN}All prerequisites met!${NC}"
}

# Step 1: Start minikube
start_minikube() {
    echo_step "Starting Minikube..."

    if minikube status &> /dev/null; then
        echo "Minikube is already running"
    else
        echo "Starting minikube with 8GB RAM and 4 CPUs..."
        minikube start --memory=8192 --cpus=4
    fi

    echo "Enabling ingress addon..."
    minikube addons enable ingress

    echo -e "${GREEN}Minikube is ready!${NC}"
}

# Step 2: Install ArgoCD
install_argocd() {
    echo_step "Installing ArgoCD..."

    # Check if ArgoCD is already installed
    if kubectl get namespace argocd &> /dev/null; then
        echo "ArgoCD namespace already exists"
    else
        kubectl create namespace argocd
    fi

    # Install ArgoCD
    echo "Applying ArgoCD manifests..."
    kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

    # Wait for pods to be ready
    echo "Waiting for ArgoCD pods to be ready..."
    kubectl wait --for=condition=Ready pods -l app.kubernetes.io/name=argocd-server -n argocd --timeout=300s

    echo -e "${GREEN}ArgoCD installed successfully!${NC}"
}

# Step 3: Get admin password
get_admin_password() {
    echo_step "Getting admin password..."

    PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)

    echo -e "ArgoCD admin password: ${GREEN}$PASSWORD${NC}"
    echo "Save this password for later use!"
}

# Step 4: Connect k3s-001 cluster
connect_remote_cluster() {
    echo_step "Connecting k3s-001 cluster..."

    echo "To connect the remote k3s-001 cluster, you need to:"
    echo "1. SSH to k3s-001 VM and get the kubeconfig:"
    echo "   ssh <user>@k3s-001 'sudo cat /etc/rancher/k3s/k3s.yaml'"
    echo ""
    echo "2. Save it to a file (e.g., ~/k3s-001-kubeconfig)"
    echo ""
    echo "3. Add the cluster to ArgoCD:"
    echo "   argocd cluster add <context-name> --name k3s-001 --kubeconfig ~/k3s-001-kubeconfig"
    echo ""
    echo "Alternatively, you can run the interactive command:"
    echo "   argocd cluster add"
}

# Main
main() {
    echo -e "${GREEN}ArgoCD Setup Script${NC}"
    echo "========================="

    check_prerequisites
    start_minikube
    install_argocd
    get_admin_password
    connect_remote_cluster

    echo_step "Setup complete!"
    echo ""
    echo "Next steps:"
    echo "1. Port-forward to ArgoCD: kubectl port-forward svc/argocd-server -n argocd 8080:443"
    echo "2. Access UI at: https://localhost:8080"
    echo "3. Username: admin"
    echo "4. Password: (from above)"
    echo ""
    echo "After logging in, connect your k3s-001 cluster using the instructions above."
}

main "$@"
