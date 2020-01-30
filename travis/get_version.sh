#!/usr/bin/env bash

set -euo pipefail

# Output sonarr version from github:sonarr releases
echo "$(curl -fsSL --retry 5 --retry-delay 2 https://github.com/Sonarr/Sonarr/releases | grep '.tar.gz' | head -n 1 | awk -F '/v' {'print $2'} | awk -F '.tar' {'print $1'})"
