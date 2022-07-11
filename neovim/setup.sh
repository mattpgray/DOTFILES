#!/bin/bash

set -ex

# Get the path to this file. Needed later when we use the other files relative to this one
SCRIPT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
echo $SCRIPT_PATH

# Setup the config 
mkdir -p ~/.config/nvim
cp ${SCRIPT_PATH}/init.vim ~/.config/nvim/init.vim

# Set neovim as the default git interpreter
git config --global core.editor "nvim"

# Move the plugins to the correct dir
mkdir -p ~/.config/nvim/plugins
cp ${SCRIPT_PATH}/plugins/* ~/.config/nvim/plugins

