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
TEMP_DEB="$(mktemp)".deb
wget -O "$TEMP_DEB" https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb
sudo apt-get install "$TEMP_DEB"
rm -f "$TEMP_DEB"

# Install fircode font
mkdir -p ~/.fonts \
~/.fonts

# Install fonts
FONT_NAME=FiraCodeRegular
FONT_FILE=~/.fonts/${FONT_NAME}.otf 
rm ${FONT_FILE}
curl -fLo "${FONT_FILE}" \
https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/FiraCode/Regular/complete/Fira%20Code%20Regular%20Nerd%20Font%20Complete%20Mono.ttf

