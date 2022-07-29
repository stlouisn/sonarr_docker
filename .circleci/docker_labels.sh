#!/usr/bin/env bash

set -euo pipefail

# Build variables
BUILD_DATE="$(date -u +%Y-%m-%d\ %H:%M:%SZ)"

# Schema version
SCHEMA_VERSION="1.0"

# Output labels to console
echo build_date = $BUILD_DATE
echo maintainer = $C_MAINTAINER
echo image_name = $C_NAME:$C_TAG
echo description = $C_DESCRIPTION
echo image_version = $C_VERSION
echo

# Append labels to dockerfile
cat <<- EOF >> dockerfile

LABEL \\
org.label-schema.build-date="$BUILD_DATE" \\
org.label-schema.description="$C_DESCRIPTION" \\
org.label-schema.maintainer="$C_MAINTAINER" \\
org.label-schema.name="$C_NAME" \\
org.label-schema.version="$C_VERSION" \\
org.label-schema.schema-version="$SCHEMA_VERSION"
EOF
