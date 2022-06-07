#!/bin/bash

set -ex

# Get the path to this file. Needed later when we use the other files relative to this one
OLD_WD=${PWD}
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
cd ${SCRIPTPATH}

# Setup the config 
mkdir -p ~/.config/nvim
cp ./init.vim ~/.config/nvim/init.vim

# Set neovim as the default git interpreter
git config --global core.editor "nvim"

# Move the plugins to the correct dir
mkdir -p ~/.config/nvim/plugins
cp ./plugins/* ~/.config/nvim/plugins

# Fix state
cd ${OLD_WD}

