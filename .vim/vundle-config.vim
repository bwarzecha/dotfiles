"
" Vundle configuration
"
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vundle
call vundle#begin('~/.vundles')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'

" All of your Plugins must be added before the following line
call vundle#end()
filetype plugin indent on
