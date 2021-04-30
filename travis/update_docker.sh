#!/usr/bin/env bash

set -euo pipefail

# Create /etc/docker directory
mkdir -p /etc/docker

# Enable overlay2 and experimental mode
cat <<'EOF' > /etc/docker/daemon.json
{
    "storage-driver": "overlay2",
    "experimental":true
}
EOF

# Add docker repository
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Update apt-cache
apt-get update -q

# Update docker
apt-get install -y docker-ce

# Restart docker
service docker restart

# Display docker version
docker info
