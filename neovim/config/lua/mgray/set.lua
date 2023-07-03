--
-- This should be in the nvim-tree config but this needs to be at the start of the init.lua.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir/"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.textwidth = 100 -- Much more sensible text width for >=2023
vim.opt.colorcolumn = "100"

vim.opt.list = true
vim.opt.listchars = {
    tab = "» ",
    space = "·",
}
vim.g.mapleader = " "

-- Because I am a big dumb idiot
vim.opt.spelllang = 'en_us' -- ew
-- Uncomment for default spelling
-- vim.opt.spell = true

-- Disable using editor config. My main language is go, and I prefer to have a formatter instead of
-- an editor config. The settings in editor config tend to disagree with the gofmt a lot of the
-- time.
vim.g.editorconfig = false
