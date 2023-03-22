#!/bin/bash
set -ex

# Get the path to this file. Needed later when we use the other files relative to this one
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# Setup other packages
cd $SCRIPTPATH
. ./install/setup.sh
. ./neovim/setup.sh
. ./git/setup.sh
. ./fonts.sh

