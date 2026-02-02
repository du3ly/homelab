#!/bin/bash -eux

apt-get update -q
apt-get upgrade -yq
apt-get install -yq \
  python3 \
  python3-dev \
  python3-venv \
  python3-pip \
  build-essential \
  libssl-dev \
  libffi-dev \
  wget \
  ca-certificates

python3 -m venv /tmp/ansible-venv
source /tmp/ansible-venv/bin/activate
pip3 install -qUr /tmp/requirements.txt --no-cache-dir
