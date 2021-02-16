let g:which_key_use_floating_win = 1
let g:which_key_map =  {}

let g:which_key_exit = ["\<C-g>", "\<Esc>"]

let g:which_key_map.q = {
			\'name': '+quit',
	\'q': [':q!', 'quit'],
	\}

" s is for search
let g:which_key_map.s = {
      \ 'name' : '+search' ,
      \ ';' : [':Commands'                 , 'commands'],
      \ 'a' : [':Ag'                       , 'text Ag'],
      \ 'b' : [':BLines'                   , 'current buffer'],
      \ 'B' : [':Buffers'                  , 'open buffers'],
      \ 'c' : [':Commits'                  , 'commits'],
      \ 'C' : [':BCommits'                 , 'buffer commits'],
      \ 'f' : [':Files'                    , 'files'],
      \ 'g' : [':GFiles'                   , 'git files'],
      \ 'G' : [':GFiles?'                  , 'modified git files'],
      \ 'h' : [':History'                  , 'file history'],
      \ 'H' : [':History:'                 , 'command history'],
      \ 'l' : [':Lines'                    , 'lines'] ,
      \ 'm' : [':Marks'                    , 'marks'] ,
      \ 'M' : [':Maps'                     , 'normal maps'] ,
      \ 'p' : [':Helptags'                , 'help tags'] ,
      \ 'P' : [':Tags'                     , 'project tags'],
      \ 's' : [':CocList snippets'         , 'snippets'],
      \ 'S' : [':Colors'                   , 'color schemes'],
      \ 't' : [':Rg'                       , 'Rg text'],
      \ 'T' : [':BTags'                    , 'buffer tags'],
      \ 'w' : [':Windows'                  , 'search windows'],
      \ 'y' : [':Filetypes'                , 'file types'],
      \ 'z' : [':FZF'                      , 'FZF'],
      \ }


nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>s
call which_key#register('<Space>', "g:which_key_map")

set timeoutlen=100

let g:which_key_map['w'] = {
      \ 'name' : '+windows' ,
      \ 'w' : ['<C-W>w'     , 'other-window']          ,
      \ 'd' : ['<C-W>c'     , 'delete-window']         ,
      \ '-' : ['<C-W>s'     , 'split-window-below']    ,
      \ '/' : ['<C-W>v'     , 'split-window-right']    ,
      \ '2' : ['<C-W>v'     , 'layout-double-columns'] ,
      \ 'h' : ['<C-W>h'     , 'window-left']           ,
      \ 'j' : ['<C-W>j'     , 'window-below']          ,
      \ 'l' : ['<C-W>l'     , 'window-right']          ,
      \ 'k' : ['<C-W>k'     , 'window-up']             ,
      \ 'q' : ['q'          , 'close' ]                ,
      \ 'H' : ['<C-W>5<'    , 'expand-window-left']    ,
      \ 'J' : [':resize +5'  , 'expand-window-below']   ,
      \ 'L' : ['<C-W>5>'    , 'expand-window-right']   ,
      \ 'K' : [':resize -5'  , 'expand-window-up']      ,
      \ '=' : ['<C-W>='     , 'balance-window']        ,
      \ 's' : ['<C-W>s'     , 'split-window-below']    ,
      \ 'v' : ['<C-W>v'     , 'split-window-below']    ,
      \ '?' : ['Windows'    , 'fzf-window']            ,
      \ }

" General mappings - some similar to Spacemacs
" Files:
" save
let g:which_key_map.f = { 'name' : '+file' }
nnoremap <silent> <leader>fs :update<CR>
let g:which_key_map.f.s = 'save-file'


" find - uses FZF
let g:which_key_map.f.f = 'find-file'
nnoremap <expr> <leader>ff (len(system('git rev-parse')) ? ':Files' : ':GFiles --exclude-standard --others --cached')."\<cr>"


let g:which_key_map.f.t = [':NERDTreeFind','find-nerdtree'] 

" Buffers
let g:which_key_map.b = {
      \ 'name' : '+buffer' ,
      \ '1' : ['b1'        , 'buffer 1']        ,
      \ '2' : ['b2'        , 'buffer 2']        ,
      \ 'd' : ['bd'        , 'delete-buffer']   ,
      \ 'f' : ['bfirst'    , 'first-buffer']    ,
      \ 'h' : ['Startify'  , 'home-buffer']     ,
      \ 'l' : ['blast'     , 'last-buffer']     ,
      \ 'n' : ['bnext'     , 'next-buffer']     ,
      \ 'p' : ['bprevious' , 'previous-buffer'] ,
      \ 'b' : ['Buffers'   , 'fzf-buffer']      ,
      \ }

let g:which_key_map.c = { 
			\'name' : '+code/coc',
			\ 'r' : ['<Plug>(coc-rename)','rename'],
			\ 'c' : ['<plug>NERDCommenterToggle', 'comment'],
			\ 'F' : ['<Plug>(coc-format)', "format code"],
			\}
let g:which_key_map.c.g = { 'name' : 'goto'}
let g:which_key_map.c.g.d = ['<Plug>(coc-definition)', "definition"]
let g:which_key_map.c.g.t = ['<Plug>(coc-type-definition)', "type-definition"]
let g:which_key_map.c.g.i = ['<Plug>(coc-implementation)', "implementation"]
let g:which_key_map.c.g.r = ['<Plug>(coc-references)', "references"]
let g:which_key_map.c.R = ['<Plug>(coc-refactor)', "Refactor"]
let g:which_key_map.c.f = [':CocFix', 'fix']

" -- find errors

let g:which_key_map.c.e = { 'name' : 'errors'}
let g:which_key_map.c.e.n = ['<Plug>(coc-diagnostic-next)', 'goto next error']
let g:which_key_map.c.e.p = ['<Plug>(coc-diagnostic-prev)', 'goto previous error']

" -- list
let g:which_key_map.c.l = { 'name' : 'list' }
let g:which_key_map.c.l.d = [':CocList -A diagnostics', 'diagnostics']
let g:which_key_map.c.l.e = [':CocList extensions', 'extensions']
let g:which_key_map.c.l.p = [':CocList preview', 'preview']
let g:which_key_map.c.l.o = [':CocList outline', 'outline']
let g:which_key_map.c.l.r = [':CocListResume', 'resume']
let g:which_key_map.c.l.n = [':CocNext', 'next']
let g:which_key_map.c.l.c = [':CocList commands', 'commands']
let g:which_key_map.c.l.s = [':CocList -I symbols', 'symbols']

let g:which_key_map.j = {
      \ 'name' : '+jump' ,
      \ 'j' : ['<Plug>(easymotion-s2)'        , 'character anywhere']        ,
      \ 'w' : ['<Plug>(easymotion-bd-w)'        , 'start of the word']        ,
      \ 'e' : ['<Plug>(easymotion-bd-e)'        , 'end of the word']        ,
      \ 'l' : ['<Plug>(easymotion-bd-jk)'        , 'beginnig of the line']        ,
      \ 'f' : ['<C-i>'        , 'jump forward']        ,
      \ 'b' : ['<C-o>'        , 'jump back']        ,
      \ }

let g:which_key_map.t = {
      			\ 'name' : '+toggle/tabs' ,
			\ 'f' : [':NERDTreeToggle', 'NERDTreeToggle'],
			\ 'b' : [':tab ball', 'buffers to tabs'],
			\ 'n' : [':tabn', 'next tab'],
			\ 'p' : [':tabp', 'prev tab'],
			\ 'q' : [':tabclose', 'close tab'],
			\}

let g:which_key_map.h = { 
			\ 'name' : '+help' ,
			\ 'r' : [':source $MYVIMRC', 'reload config']        ,
      \}

" Hide statusline

autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

let g:which_key_map.r = {
      			\ 'name' : '+rust' ,
			\ 'f' : [':RustFmt', 'rust-fmt'],
			\ 'r' : [':RustRun', 'run file'],
			\ 't' : [':RustTest', 'run test'],
			\}


