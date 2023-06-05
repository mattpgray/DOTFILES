#!/bin/bash

set -ex

echo "Installing coc-spell-checker. The logs are misleading. Please wait..."
nvim --headless +"CocInstall -sync coc-spell-checker|qa"

