#!/usr/bin/env bash

set -euxo pipefail

# Install the various tools used both for setting up and for work flow
sudo apt-get update

PACKAGES=(
    # curl required for some packages.
    curl
    # git because of course.
    git-all 
    # Build tools required for some config for dotfiles.
    gcc make 
    # tmux - I don't really use it. Maybe I should get rid?
    tmux 
    # ripgrep is required for the telescope neovim plugin.
    ripgrep
)

sudo apt-get install -y ${PACKAGES[@]}

# Install neovim
mkdir -p ~/tools/nvim/
NVIM_FILE=~/tools/nvim/nvim_v0.9.4.appimage
NVIM_URL=https://github.com/neovim/neovim/releases/download/v0.9.4/nvim.appimage
wget -O "$NVIM_FILE" "$NVIM_URL"
chmod u+x "$NVIM_FILE"
rm /user/local/bin/nvim || true
sudo ln --symbolic "$NVIM_FILE" /usr/local/bin/nvim 

# Install fircode font
mkdir -p ~/.fonts \
~/.fonts

# # Install fonts
# FONT_NAME=FiraCodeRegular
# FONT_FILE=~/.fonts/${FONT_NAME}.otf 
# rm ${FONT_FILE} || true
# curl -fLo "${FONT_FILE}" \
# https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/FiraCode/Regular/complete/Fira%20Code%20Regular%20Nerd%20Font%20Complete%20Mono.ttf

