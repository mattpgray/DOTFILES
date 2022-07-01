neovim defines common vim config that can be used in many projects.

It is possible to add custom config for a machine by adding one or more of these files

- `.config/nvim/local/pre-init.vim` - called before the global `init.vim` completes
- `.config/nvim/local/plugins.vim` - called during initialisation of plugins
- `.config/nvim/local/post-init.vim` - called after the global `init.vim` completes

# Roadmap

- Add ability to add local config for a particular code repository, e.g. `.vscode/settings.json`.
  Need to add a custom dir call `.vim/` that can be added. The config will then search the 
  for this directory to see if there is any custom config we can add.

