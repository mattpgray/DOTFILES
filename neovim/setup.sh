#!/bin/bash

set -ex

# Setup the config 
mkdir -p ~/.config/nvim
cp ./neovim/init.vim ~/.config/nvim/init.vim

# Set neovim as the default git interpreter
git config --global core.editor "nvim"

