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
# Copy only packer so that we can install the packages before adding all the config.
rm -fr ~/.config/nvim
ln -s ${SCRIPT_DIR}/config ~/.config/nvim

# Run packer sync on first run
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
# Install the spell checker on the first run. This is takes too long to do every time.
# TODO: Learn how to spel.
${SCRIPT_DIR}/coc.sh

