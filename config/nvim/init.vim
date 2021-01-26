" Leader space 
let mapleader=" "

" highlight syntax
syntax on 
set number " show line numbers
set noswapfile " disable the swapfile
set hlsearch " highlight all results
set ignorecase " ignore case in search
set incsearch " show search results as you type

set relativenumber

filetype plugin indent on

call plug#begin()

" Fuzzy finder
" Vim-rooter moves current director to project (git) directory
Plug 'airblade/vim-rooter'
" Fuzzy search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Rust
Plug 'rust-lang/rust.vim'

" UI
" Light line
Plug 'itchyny/lightline.vim'
" Nord theme
Plug 'arcticicestudio/nord-vim'

call plug#end()

if has('termguicolors')
  set termguicolors
endif

" Set colors to Nord
colorscheme nord


" map non-recursively fd to Esc in insert mode
inoremap fd <Esc>

" General mappings - some similar to Spacemacs
" Files:
" save
nnoremap <leader>fs :w<CR>

" find - uses FZF
noremap <leader>ff :Files<CR>

" Buffers
nnoremap <leader>bb :Buffers<CR>

" Search
" search in current buffer
nnoremap <leader>ss :BLines<CR>

" Git Repo 
" find files in git repo
nnoremap <leader>gf :GFiles<CR>
" search in files in root
nnoremap <leader>gs :Rg<CR>


" from http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
" found in jonhoo/configs repo. Sets grep to ag or rg if available
if executable('ag')
	set grepprg=ag\ --nogroup\ --nocolor
endif
if executable('rg')
	set grepprg=rg\ --no-heading\ --vimgrep
	set grepformat=%f:%l:%c:%m
endif

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

" Lightline
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ }
" Use mouse in all modes
set mouse=a


