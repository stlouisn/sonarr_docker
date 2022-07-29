#!/usr/bin/env bash

set -euo pipefail

# Application version
APP_VERSION="$(curl -sSL --retry 5 --retry-delay 2 "http://services.sonarr.tv/v1/releases" | jq -r '.[].version' | head -n 1)"
echo "$APP_VERSION"
