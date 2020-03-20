"99_keybindings.vim - keybindings for all the things.
"
"Copyright (c) 2020; Chris Watson. All rights reserved.
"Use of this source code is governed by an MIT license
"that can be found in the LICENSE file.

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
imap <C-S-d> <Esc>YPji
nmap <C-S-d> YPj

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

"AnyJump
nnoremap <leader>j :AnyJump<CR>
nnoremap <leader>ab :AnyJumpBack<CR>
nnoremap <leader>al :AnyJumpLastResults<CR>

"Tagbar
nnoremap <leader>k :TagbarToggle<CR>

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

"Coc
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"Emmet
let g:user_emmet_expandabbr_key = '<A-e>,'
let g:user_emmet_expandword_key = '<A-e>;'
let g:user_emmet_update_tag = '<A-e>u'
let g:user_emmet_balancetaginward_key = '<A-e>d'
let g:user_emmet_balancetagoutward_key = '<A-e>D'
let g:user_emmet_next_key = '<A-e>n'
let g:user_emmet_prev_key = '<A-e>N'
let g:user_emmet_imagesize_key = '<A-e>i'
let g:user_emmet_togglecomment_key = '<A-e>/'
let g:user_emmet_splitjointag_key = '<A-e>j'
let g:user_emmet_removetag_key = '<A-e>k'
let g:user_emmet_anchorizeurl_key = '<A-e>a'
let g:user_emmet_anchorizesummary_key = '<A-e>A'
let g:user_emmet_mergelines_key = '<A-e>m'
let g:user_emmet_codepretty_key = '<A-e>c'

"FZF
nmap <silent> <C-p> :FZF<CR>
