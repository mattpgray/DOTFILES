#!/bin/bash

set -ex

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Install packer for dependencies
rm -fr ~/.local/share/nvim/site/pack/packer/start/packer.nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Copy config for packer sync
rm -fr ~/.config/nvim
mkdir -p ~/.config/nvim
cp  ${SCRIPT_DIR}/config/lua/mgray/packer.lua ~/.config/nvim/init.lua

# Run packer sync on first run
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

# Copy all config
rm -fr ~/.config/nvim
cp -r ${SCRIPT_DIR}/config ~/.config/nvim

