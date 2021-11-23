" --- General

syntax on

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set number
set numberwidth=4
set relativenumber
set termguicolors
set hidden
set mouse=a
set scrolloff=8
set sidescrolloff=8

" --- Key mappings

" Reselect visual selection after indenting
vnoremap < <gv
vnoremap > >gv

" --- Plugins

" Auto install vim plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(data_dir . '/plugins')

source ~/.config/nvim/plugins/dracula.vim

call plug#end()

" Allow config to happen after loaded plugins
doautocmd User PlugLoaded
