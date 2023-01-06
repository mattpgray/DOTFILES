#!/bin/bash

set -ex

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

rm -fr ~/.config/nvim
ln -s ${SCRIPT_DIR}/config ~/.config/nvim

