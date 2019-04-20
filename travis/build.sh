#!/usr/bin/env bash

set -u

# Architectures to build
architectures="arm arm64 amd64"

for arch in $architectures; do

	# Login into docker
	echo ${DOCKER_PASSWORD} | docker login --username ${DOCKER_USERNAME} --password-stdin

	# Build temporary image
	buildctl build \
		--frontend dockerfile.v0 \
		--opt platform=linux/$arch \
		--opt filename=docker/Dockerfile.${DOCKER_NAME}-${DOCKER_TAG}-$arch \
		--local dockerfile=. \
		--local context=. \
		--output type=image,name=docker.io/${DOCKER_USERNAME}/${DOCKER_NAME}:${DOCKER_TAG}-$arch,push=true

done
