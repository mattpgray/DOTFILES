#!/bin/bash

set -ex

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

rm -fr ~/.config/nvim
cp -r ${SCRIPT_DIR}/config ~/.config/nvim

