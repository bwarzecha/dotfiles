" Leader space 
let g:mapleader = "\<Space>"
let g:maplocalleader = ','
" highlight syntax
syntax on 
set number " show line numbers
set noswapfile " disable the swapfile
set hlsearch " highlight all results
set ignorecase " ignore case in search
set incsearch " show search results as you type
set nowrap " do not wrap lines
set relativenumber

filetype plugin indent on

call plug#begin()

" Fuzzy finder
" Vim-rooter moves current director to project (git) directory
Plug 'airblade/vim-rooter'
" Fuzzy search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Programing
" Code complitition. Requires node 10+
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Rust
Plug 'rust-lang/rust.vim'

" UI
" Light line
Plug 'itchyny/lightline.vim'
" Nord theme
Plug 'arcticicestudio/nord-vim'
Plug 'joshdick/onedark.vim'

" Which Key - spacemacs like key combination helper 
Plug 'liuchengxu/vim-which-key'
Plug 'preservim/nerdtree'
" Markdown live preview (+mermaid support)
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

Plug 'easymotion/vim-easymotion'
Plug 'preservim/nerdcommenter'
call plug#end()

if has('termguicolors')
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
endif

" Set colors to OneHalfDark 
set t_Co=256
set cursorline
colorscheme onedark

" map non-recursively fd to Esc in insert mode
inoremap fd <Esc>

" from http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
" found in jonhoo/configs repo. Sets grep to ag or rg if available
if executable('ag')
	set grepprg=ag\ --nogroup\ --nocolor
endif
if executable('rg')
	set grepprg=rg\ --no-heading\ --vimgrep
	set grepformat=%f:%l:%c:%m
endif

"Esc exits terminal mode
:tnoremap <Esc> <C-\><C-n>
:tnoremap fd  <C-\><C-n>

" Ctrl-c copy
" Ctrl-a select all
" Ctrl-v paste
vnoremap <C-a> ggVG
nnoremap <C-a> ggVG
vnoremap <C-c> "+y
" In normal mode copy will copy full line
nnoremap <C-c> "+yy
nnoremap <C-v> "+p
vnoremap <C-v> "+p

" " Copy to sytem clipboard - from  https://www.reddit.com/r/neovim/comments/3fricd/easiest_way_to_copy_from_neovim_to_system/ctrru3b/?utm_source=reddit&utm_medium=web2x&context=3
" visual mode - copy selection
vnoremap  <leader>y  "+y
" normal mode copy from current character to last non blank character
nnoremap  <leader>Y  "+yg_
" normal mode copy - needs additional verbs like: <leader>y y -> "+yy, this
" will copy full line
nnoremap  <leader>y  "+y

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P


source 	~/.config/nvim/plugins/coc.vim
source 	~/.config/nvim/plugins/lightline.vim
source 	~/.config/nvim/plugins/which-key.vim
source ~/.config/nvim/plugins/nerdcommenter.vim
source ~/.config/nvim/plugins/nerdtree.vim
