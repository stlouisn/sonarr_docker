#!/usr/bin/env bash

set -euo pipefail

# Enable docker experimental client
export DOCKER_CLI_EXPERIMENTAL="enabled"

# Login into docker
echo ${DOCKER_PASSWORD} | docker login --username ${DOCKER_USERNAME} --password-stdin

# Create manifest list
docker manifest create ${DOCKER_USERNAME}/${DOCKER_NAME}:${DOCKER_TAG} \
	${DOCKER_USERNAME}/${DOCKER_NAME}:${DOCKER_TAG}-${OS_NAME}-arm \
	${DOCKER_USERNAME}/${DOCKER_NAME}:${DOCKER_TAG}-${OS_NAME}-arm64 \
	${DOCKER_USERNAME}/${DOCKER_NAME}:${DOCKER_TAG}-${OS_NAME}-amd64

# Annotate manifest list
docker manifest annotate \
	--arch arm --os linux \
	${DOCKER_USERNAME}/${DOCKER_NAME}:${DOCKER_TAG} \
	${DOCKER_USERNAME}/${DOCKER_NAME}:${DOCKER_TAG}-${OS_NAME}-arm
docker manifest annotate \
	--arch arm64 --os linux \
	${DOCKER_USERNAME}/${DOCKER_NAME}:${DOCKER_TAG} \
	${DOCKER_USERNAME}/${DOCKER_NAME}:${DOCKER_TAG}-${OS_NAME}-arm64
docker manifest annotate \
	--arch amd64 --os linux \
	${DOCKER_USERNAME}/${DOCKER_NAME}:${DOCKER_TAG} \
	${DOCKER_USERNAME}/${DOCKER_NAME}:${DOCKER_TAG}-${OS_NAME}-amd64

# Push manifest list
docker manifest push ${DOCKER_USERNAME}/${DOCKER_NAME}:${DOCKER_TAG}

# Display manifest list
docker manifest inspect ${DOCKER_USERNAME}/${DOCKER_NAME}:${DOCKER_TAG}
