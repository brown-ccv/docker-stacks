#!/bin/bash

# Builds and pushes a given image to gcr.io + all nodes in current kubectl
# context

set -e

DOCKER_REPO=""
DOCKER_PUSH="docker push"

while getopts ":r:" opt; do
	case $opt in
		r) DOCKER_REPO="$OPTARG" ;;
	esac
done
shift $((OPTIND-1))

if [ -z "$1" ]; then
	echo "Usage: $0 [ -r DOCKER_REPO ] [ base | {user_image_type} ]"
	exit 1
fi

# Bail if we're on a dirty git tree
if ! git diff-index --quiet HEAD; then
    echo "You have uncommited changes. Please commit them before building and"
    echo "populating. This helps ensure that all docker images are traceable"
    echo "back to a git commit."
    exit 1
fi

IMAGE="$1"
echo $IMAGE
if [ ! -f ${IMAGE}/Dockerfile ]; then
	echo "No such file: ${IMAGE}/Dockerfile"
	exit 1
fi

GIT_REV=$(git log -n 1 --pretty=format:%h -- ${IMAGE})
TAG="${GIT_REV}"

IMAGE_SPEC="${DOCKER_REPO}/jupyterhub-${IMAGE}:${TAG}"
docker build -f ${IMAGE}/Dockerfile -t ${IMAGE_SPEC} .
${DOCKER_PUSH} ${IMAGE_SPEC}
echo "Pushed ${IMAGE_SPEC}"
