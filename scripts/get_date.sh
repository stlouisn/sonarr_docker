#!/usr/bin/env bash

set -euo pipefail

# Build date
BUILD_DATE="$(date -u +%Y-%m-%d\ %H:%M:%SZ)"

# Export BUILD_DATE
echo "export BUILD_DATE=\""$BUILD_DATE"\"" >> $BASH_ENV
