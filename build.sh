#!/bin/bash
set -ex

# Get the path to this file. Needed later when we use the other files relative to this one
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
# install package with apt
sudo apt update
sudo apt install -y curl
sudo apt install -y git-all
sudo apt install -y neovim
# Git credentials manager
sudo apt install -y gcc make
sudo apt install -y libsecret-1-0 libsecret-1-dev
cd /usr/share/doc/git/contrib/credential/libsecret
sudo make
git config --global credential.helper /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret

# Setup other packages
cd $SCRIPTPATH
. ./neovim/setup.sh

