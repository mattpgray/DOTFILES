#!/bin/bash

set -ex

# Setup the config 
mkdir -p ~/.config/nvim
cp ./neovim/init.vim ~/.config/nvim/init.vim

# Set neovim as the default git interpreter
git config --global core.editor "nvim"

# Move the plugins to the correct dir
mkdir -p ~/.config/nvim/plugins
cp ./neovim/plugins/* ~/.config/nvim/plugins

