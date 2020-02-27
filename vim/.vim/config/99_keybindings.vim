"99_keybindings.vim - keybindings for all the things.
"
"Copyright (c) 2020; Chris Watson. All rights reserved.
"Use of this source code is governed by an MIT license
"that can be found in the LICENSE file.

"Close and save buffer instead of editor
:cnoreabbrev wq w<bar>bd
:cnoreabbrev q bd

"Cycle through buffers
:nnoremap <Tab> :bnext<CR>
:nnoremap <S-Tab> :bprevious<CR>

"Change windows
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h

"Use jj in place of escape
set timeout timeoutlen=1000 ttimeoutlen=100
inoremap <nowait> jj <Esc>

"Duplicate a line with <C-d>
imap <C-d> <Esc>YPji
nmap <C-d> YPj

"Move the current line up and down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

"NERDTree
map <C-n> :NERDTreeToggle<CR>

"NERDCommenter
nmap <C-_>   <Plug>NERDCommenterToggle
vmap <C-_>   <Plug>NERDCommenterToggle<CR>gv
