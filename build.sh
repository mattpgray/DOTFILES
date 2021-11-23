#!/bin/bash
set -ex

# install package with apt
# sudo apt update
# sudo apt install -y git-all
# sudo apt install -y neovim
# Git credentials manager
sudo apt install -y libsecret-1-0 libsecret-1-dev
cd /usr/share/doc/git/contrib/credential/libsecret
sudo make
git config --global credential.helper /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret
