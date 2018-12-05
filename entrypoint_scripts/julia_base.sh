#!/bin/bash

# This adds the home directory to depot path - 
# so that julia cache files are go into writable location
rm -rf $JULIA_DEPOT_PATH/compiled
export JULIA_DEPOT_PATH="$HOME/.julia:$JULIA_DEPOT_PATH"

# Pass all arguments
exec "$@"
