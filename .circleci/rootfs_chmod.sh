#!/usr/bin/env bash

set -euo pipefail

if
    [ -f rootfs/usr/local/bin/docker_entrypoint.sh ]
then
    chmod +x rootfs/usr/local/bin/docker_entrypoint.sh
    ls -lA --color=auto rootfs/usr/local/bin/docker_entrypoint.sh
fi
