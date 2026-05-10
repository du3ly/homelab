#!/bin/bash
set -e

# Variables
REPO_URL="https://github.com/du3ly/terraform-provider-synology"
BINARY_NAME="terraform-provider-synology"
VERSION="0.6.11-local"
REGISTRY="registry.terraform.io"
NAMESPACE="synology-community"
NAME="synology"

# 1. Create a clean workspace in /tmp
echo "Setting up workspace in /tmp..."
rm -rf /tmp/terraform-provider-synology
git clone $REPO_URL /tmp/terraform-provider-synology
cd /tmp/terraform-provider-synology

# 2. Build the binary
echo "Building $BINARY_NAME..."
# Use go build directly to ensure we are at the root of the cloned repo
go build -o $BINARY_NAME .

# 3. Determine OS and Architecture
OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)
if [ "$ARCH" == "arm64" ]; then
    S_ARCH="darwin_arm64"
elif [ "$ARCH" == "x86_64" ]; then
    S_ARCH="darwin_amd64"
else
    S_ARCH="linux_amd64"
fi

# 4. Install to Local Mirror
INSTALL_DIR="$HOME/.terraform.d/plugins/$REGISTRY/$NAMESPACE/$NAME/$VERSION/$S_ARCH"

echo "Installing binary to $INSTALL_DIR..."
mkdir -p "$INSTALL_DIR"
cp $BINARY_NAME "$INSTALL_DIR/$BINARY_NAME"

echo "-------------------------------------------------------------------"
echo "Successfully installed your forked provider!"
echo "Target: $INSTALL_DIR"
echo "Now you can run 'terraform init' in your project directory."
echo "-------------------------------------------------------------------"
