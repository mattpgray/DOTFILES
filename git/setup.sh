# Commands to make ~/.gitconfig how I want it. Requires git to be installed which
# uses the top level script. 
git config --global core.editor "nvim"
# The best alias
git config --global alias.fixup "!sh -c '(git diff-files --quiet || (echo Unstaged changes, please commit or stash with --keep-index; exit 1)) && COMMIT=$(git rev-parse $1) && git commit --fixup=$COMMIT && git rebase -i --autosquash $COMMIT~1' -"
