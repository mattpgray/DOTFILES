#!/usr/bin/env bash

set -euxo pipefail

# Commands to make ~/.gitconfig how I want it. Requires git to be installed which
# uses the top level script. 
git config --global core.editor "nvim"
# The best alias -- allows "fixing-up" a previous commit.
git config --global alias.fixup '!sh -c '"'"'(git diff-files --quiet || (echo Unstaged changes, please commit or stash with --keep-index; exit 1)) && COMMIT=$(git rev-parse $1) && git commit --fixup=$COMMIT && git rebase -i --autosquash $COMMIT~1'"'"' -'
# Allows for signing a range of commits.
git config --global alias.sign '!re() { git rebase --exec '"'"'git commit --amend --no-edit -n -S'"'"' -i  $1; }; re'

# Interactive git branch switching
git config --global alias.checkoutinteractive '!git checkout $(git branch $@ | fzf | xargs)'

