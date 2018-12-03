#!/bin/bash

# This adds the home directory to depot path - 
# so that julia cache files are go into writable location
export JULIA_DEPOT_PATH=${HOME}:${JULIA_DEPOT_PATH}
