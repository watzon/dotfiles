"11_nerdtree.vim - config for nerdtree.
"
"Copyright (c) 2020; Chris Watson. All rights reserved.
"Use of this source code is governed by an MIT license
"that can be found in the LICENSE file.

"Set the default NERDTree window size to 30
let g:NERDTreeWinSize=30

"Show hidden files by default
let g:NERDTreeShowHidden=1

"Ignore certain patterns
let g:NERDTreeIgnore = ['.git$[[dir]]', '.vscode$[[dir]]']

"Show the git ignored status of a file
let g:NERDTreeShowIgnoredStatus = 1

"Allow vim to be closed if NERDTree is the only thing opened.
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"Open NERDTree automatically if vim is opened in a directory.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif


