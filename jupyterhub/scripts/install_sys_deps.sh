#!/bin/bash

# System dependencies common to all images
DEBIAN_FRONTEND=noninteractive
apt-get update && apt-get -yq dist-upgrade \
&& apt-get install -yq --no-install-recommends \
openssh-client \
vim \
curl \
git-lfs \
nodejs \
&& apt-get clean
