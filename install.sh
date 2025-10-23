#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -euo pipefail


# Defines HomeCore locations
export HOMECORE_PATH="$HOME/.local/share/homecore"
export HOMECORE_INSTALL="$HOMECORE_PATH/install"
export HOMECORE_CONFIG="$HOMECORE_CONFIG/config"
export HOMECORE_INSTALL_LOG_FILE="$HOME/.local/share/homecore"
export PATH="$HOMECORE_PATH/bin:$PATH"


# Install
source "$HOMECORE_INSTALL/helpers/all.sh"
