#!/usr/bin/env bash

set -euo pipefail

mkdir -p /etc/docker

cat <<'EOF' > /etc/docker/daemon.json
{
    "storage-driver": "overlay2",
    "experimental":true
}
EOF

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

apt-get update -q

apt-get install -y docker-ce

service docker restart
 
docker info
