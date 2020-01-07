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
&& curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash \
&& export NVM_DIR="$HOME/.nvm" 
