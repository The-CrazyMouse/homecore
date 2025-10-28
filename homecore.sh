#!/usr/bin/env bash
# ------------------------------
# This script installs and sets up "hcore" on Arch Linux.
# It works on minimal systems and automatically installs dependencies.
# Comments explain everything for beginners.
# ------------------------------

# Safety options for Bash:
# set -e → stop the script if any command fails
# set -u → treat unset variables as errors (prevents mistakes)
# set -o pipefail → fail if any command in a pipe fails
set -euo pipefail

# IFS = Internal Field Separator
# This controls how Bash splits words. 
# By default it splits on spaces, tabs, and newlines.
# Here we only split on newlines and tabs, so paths with spaces are safe.
IFS='
	'

# ------------------------------
# Maintainer notes:
# ------------------------------
# - REQUIRED_ZIG is the version of Zig that hcore was built with.
# - If Zig is missing or outdated, we install/update it automatically.
# - REPO_DIR is where the hcore Git repository will be cloned temporarily for installation purposes
# - ~/.local/bin is where the hcore binary will be placed.

REQUIRED_ZIG="0.15.0"
REPO_DIR="/tmp/homecore" 

echo "Checking dependencies..."  # Inform the user we are starting dependency checks

# ------------------------------
# Ensure ~/.local/bin exists
# ------------------------------
# This folder is a common place to put user-installed binaries.
# If it doesn't exist, we create it so we can move hcore there later.
mkdir -p "$HOME/.local/bin"

# ------------------------------
# Check for git
# ------------------------------
# "git" is needed to clone the hcore repository from GitHub.
# command -v git → checks if git exists in the system path
# >/dev/null 2>&1 → hides the output, we only care if it exists or not
if ! command -v git >/dev/null 2>&1; then
    echo "[git] not found — installing..."  # Inform the user
    sudo pacman -S --needed --noconfirm git  # Install git automatically
else
    echo "[git] is installed"  # Git is already there
fi

# ------------------------------
# Check for Zig
# ------------------------------
# Zig is the programming language hcore is written in.
# We need the version to match REQUIRED_ZIG or update it.
if ! command -v zig >/dev/null 2>&1; then
    echo "[zig] not found — installing..."
    sudo pacman -S --needed --noconfirm zig
else
    # Get the installed Zig version
    INSTALLED_ZIG=$(zig version)
    
    # Compare with REQUIRED_ZIG
	if [ "$(printf '%s\n' "$REQUIRED_ZIG" "$INSTALLED_ZIG" | sort -V | head -n1)" != "$REQUIRED_ZIG" ]; then
		echo "[zig] version is outdated - updating..."
        sudo pacman -S --needed --noconfirm zig
    else
        echo "[zig] is installed"  # Zig version is good
    fi
fi

# ------------------------------
# Remove old clone
# ------------------------------
# If a previous copy of the repository exists, remove it.
# This avoids errors when cloning the repository.
rm -rf "$REPO_DIR"

# ------------------------------
# Clone the hcore repository
# ------------------------------
# git clone downloads the code from GitHub into REPO_DIR
git clone git@github.com:The-CrazyMouse/homecore.git "$REPO_DIR"

# Move into the repository folder
cd "$REPO_DIR"

# ------------------------------
# Build hcore
# ------------------------------
# "zig build" compiles the code into a binary executable
zig build

# ------------------------------
# Move the compiled binary
# ------------------------------
# We move the built binary to ~/.local/bin so it can be run from anywhere
# -f → overwrite if the file already exists
mv -f "zig-out/bin/homecore" "$HOME/.local/bin/hcore"

echo "Installed hcore to $HOME/.local/bin/hcore"

# ------------------------------
# Run the hcore installer
# ------------------------------
# This runs the internal install command of hcore with verbose output
# install → hcore action to install homecore enviroment
# you can add the following flags if you want to change the commands behavior
# --verbose → to print out every output of every command to the console (default in this script)
# --noconfirm → this will skip the questions and install the recommend/default options
"$HOME/.local/bin/hcore" install --verbose
