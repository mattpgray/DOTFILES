#!/bin/bash
set -ex

# Get the path to this file. Needed later when we use the other files relative to this one
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
# install package with apt
sudo apt update
sudo apt install -y curl
sudo apt install -y git-all
# Git credentials manager
sudo apt install -y gcc make

# Setup other packages
cd $SCRIPTPATH
. ./neovim/setup.sh
. ./git/setup.sh

