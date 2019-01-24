#!/bin/bash

# Builds and pushes a given image to gcr.io + all nodes in current kubectl
# context

set -e

DOCKER_REPO=""
DOCKER_PUSH="docker push"
FORCE=False
while getopts ":r:" opt; do
	case $opt in
		r) DOCKER_REPO="$OPTARG" ;;
		f) FORCE=True ;;
	esac
done
shift $((OPTIND-1))

if [ -z "$1" ]; then
	echo "Usage: $0 [ -r DOCKER_REPO ] [ base | {user_image_type} ]"
	exit 1
fi

# Bail if we're on a dirty git tree
# echo $FORCE
# if ! $FORCE; then
# 	if ! git diff-index --quiet HEAD; then
# 		echo "You have uncommited changes. Please commit them before building and"
# 		echo "populating. This helps ensure that all docker images are traceable"
# 		echo "back to a git commit."
# 		exit 1
# 	fi
# fi

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

	GIT_REV=$(git log -n 1 --pretty=format:%h -- ${IMAGE})
	TAG="${GIT_REV}"

	IMAGE_NAME=jupyterhub-${IMAGE}
	IMAGE_SPEC="${DOCKER_REPO}/${IMAGE_NAME}:${TAG}"
	docker build -f ${IMAGE}/Dockerfile -t ${IMAGE_SPEC} .
	${DOCKER_PUSH} ${IMAGE_SPEC}
	echo "Pushed ${IMAGE_SPEC}"

	# Create latest tag
	docker tag ${DOCKER_REPO}/${IMAGE_NAME}:${TAG} ${DOCKER_REPO}/${IMAGE_NAME}:latest
	docker push ${DOCKER_REPO}/${IMAGE_NAME}:latest

done

