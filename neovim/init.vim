" Functions for local vim config plugins.

let local_config_dir = finddir(".nvim", "." . ";")

function SourceIfExists(file)
  if filereadable(expand(a:file))
    exec "source " . a:file
  endif
endfunction

" Can add config from local machine and from local dir.
function SourceConfigFile(filename)
  call SourceIfExists("~/.config/nvim/local/" . a:filename)
  if !empty(g:local_config_dir)
    call SourceIfExists(g:local_config_dir . "/" . a:filename)
  endif
endfunction

call SourceConfigFile("pre-init.vim")

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
set list
set listchars=trail:·
set mouse=a
set scrolloff=8
set sidescrolloff=8
set encoding=UTF-8
set wildmenu
set wildmode=longest,list,full
set hidden

"/ --- Key mappings

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
" Status bar
source ~/.config/nvim/plugins/airline.vim
Plug 'vim-airline/vim-airline-themes'
" Multiple language support
Plug 'sheerun/vim-polyglot'
" https://github.com/tpope/vim-surround
Plug 'tpope/vim-surround'
" Title case. Title case a line with gzz
Plug 'christoomey/vim-titlecase'
" Easy aligning
source ~/.config/nvim/plugins/vim-easy-align.vim
" Render markdown file in browser. Call :MarkdownPreview
" https://github.com/iamcco/markdown-preview.nvim
source ~/.config/nvim/plugins/markdown-preview.vim

call SourceConfigFile("plugins.vim")

call plug#end()

" Allow config to happen after loaded plugins
doautocmd User PlugLoaded

" Miscellaneous

" spell check for git commits and markdown. It can be annoying if this is
" enabled all the time.
autocmd FileType gitcommit setlocal spell
autocmd FileType markdown  setlocal spell
autocmd FileType gitcommit setlocal complete+=kspell
autocmd FileType markdown  setlocal complete+=kspell

call SourceConfigFile("post-init.vim")

