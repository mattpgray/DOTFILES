#! /usr/bin/env bash
#

set -ex

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Download the plugin manager
rm -fr ~/.tmux/plugins/tpm/ > /dev/null 2>&1 || true
mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm --depth 1

# Link the tmux file
rm ~/.tmux.conf > /dev/null 2>&1 || true
ln -s ${SCRIPT_DIR}/.tmux.conf ~/.tmux.conf


