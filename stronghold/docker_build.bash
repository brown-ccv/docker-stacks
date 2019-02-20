#!/bin/bash

# Builds and pushes a given image to gcr.io + all nodes in current kubectl
# context

set -e

DOCKER_REPO=""
DOCKER_PUSH="docker push"
FORCE=False

while getopts "fr:" opt; do
    echo $opt
	case $opt in
		f) FORCE=True
		;;
		r) DOCKER_REPO="$OPTARG"
		;;
		\? )
		echo "Usage: $0  [-f:forces build if git out of date] [-r DOCKER_REPO] [ IMAGE_FOLDER ]"
		;;
	esac
done
shift $((OPTIND-1))

# Bail if we're on a dirty git tree
echo "Force Build? $FORCE"
if ! $FORCE; then
	if ! git diff-index --quiet HEAD; then
		echo "You have uncommited changes. Please commit them before building and"
		echo "populating. This helps ensure that all docker images are traceable"
		echo "back to a git commit."
		exit 1
	fi
fi

IFS='-' read -r -a images <<< "$1"

for index in "${!images[@]}"
do
    IMAGE=${images[0]}

	for (( j=1; j<=$index; j++ ))
	do
		IMAGE="${IMAGE}-${images[j]}"
	done

	echo "Building $IMAGE"
	if [ ! -f ${IMAGE}/Dockerfile ]; then
		echo "No such file: ${IMAGE}/Dockerfile"
		exit 1
	fi

	GIT_REV=$(git log -n 1 --pretty=format:%h)
	TAG="${GIT_REV}"

	IMAGE_NAME=sh-${IMAGE}
	IMAGE_SPEC="${DOCKER_REPO}/${IMAGE_NAME}:${TAG}"
	docker build -f ${IMAGE}/Dockerfile -t ${IMAGE_SPEC} .
	${DOCKER_PUSH} ${IMAGE_SPEC}
	echo "Pushed ${IMAGE_SPEC}"

	# Create latest tag
	docker tag ${DOCKER_REPO}/${IMAGE_NAME}:${TAG} ${DOCKER_REPO}/${IMAGE_NAME}:latest
	docker push ${DOCKER_REPO}/${IMAGE_NAME}:latest

	# get julia manifests
	if [[ $IMAGE == *"julia"* ]]; then
		JULIA_VERSION=$(grep "ENV JULIA_VERSION" julia/Dockerfile | cut -f3 -d" " | cut -c1-3)
		docker run -it --mount type=bind,source="$(pwd)/${IMAGE}",target=/app/ ${IMAGE_SPEC} cp /opt/julia/share/julia/environments/v${JULIA_VERSION}/Manifest.toml /app/Manifest.toml
	fi

done
