#!/bin/bash

# System dependencies common to all images
DEBIAN_FRONTEND=noninteractive
apt-get update && apt-get -yq dist-upgrade \
&& apt-get install -yq --no-install-recommends \
curl \
dirmngr \
apt-transport-https \
lsb-release \
ca-certificates \
openssh-client \
vim \
curl \
git-lfs \
&& apt-get clean \
&& curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - \
&& apt -yq install nodejs
