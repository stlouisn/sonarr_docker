#!/usr/bin/env bash

set -u

# Architectures to build
ARCHITECTURES="arm arm64 amd64"

for ARCH in $ARCHITECTURES; do

	# Set dockerfile directory/filename
	DOCKERFILE="dockerfiles/${DOCKER_NAME}_${DOCKER_TAG}_${ARCH}.dockerfile"

	# Append labels to dockerfile
	cat <<- EOF >> ${DOCKERFILE}
	LABEL \
	org.label-schema.build-date="${BUILD_DATE}" \
	org.label-schema.build-number="${BUILD_NUMBER}" \
	org.label-schema.description="${DOCKER_DESCRIPTION}" \
	org.label-schema.maintainer="${DOCKER_MAINTAINER}" \
	org.label-schema.name="${DOCKER_NAME}" \
	org.label-schema.url="${DOCKER_URL}" \
	org.label-schema.version="${DOCKER_VERSION}" \
	org.label-schema.schema-version="${SCHEMA_VERSION}" \
	org.label-schema.vcs-ref="${VCS_REF}" \
	org.label-schema.vcs-url="${VCS_URL}"
	EOF

	# Login into docker
	echo ${DOCKER_PASSWORD} | docker login --username ${DOCKER_USERNAME} --password-stdin

	# Build docker image
	buildctl build \
		--frontend dockerfile.v0 \
		--progress plain \
		--opt platform=linux/${ARCH} \
		--opt filename=${DOCKERFILE} \
		--local dockerfile=. \
		--local context=. \
		--output type=image,name=docker.io/${DOCKER_USERNAME}/${DOCKER_NAME}:${DOCKER_TAG}-${ARCH},push=true

done
