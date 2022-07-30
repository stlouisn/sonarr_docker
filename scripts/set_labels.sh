#!/usr/bin/env bash

set -euo pipefail

# Schema version
SCHEMA_VERSION="1.0"

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
