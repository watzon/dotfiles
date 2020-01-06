function! myspacevim#before() abort
  " Map jj to Escape
  inoremap jj <Esc>
  nnoremap jj <Esc>
  vnoremap jj <Esc>

  " Allow using Alt+Up and Alt+Down to move lines up and down
  nnoremap <A-Down> :m .+1<CR>==
  nnoremap <A-Up> :m .-2<CR>==
  inoremap <A-Down> <Esc>:m .+1<CR>==gi
  inoremap <A-Up> <Esc>:m .-2<CR>==gi
  vnoremap <A-Down> :m '>+1<CR>gv=gv
  vnoremap <A-Up> :m '<-2<CR>gv=gv

  " Use ,p to paste from clipboard, and ,y to copy
  nnoremap ,p "+p
  vnoremap ,p "+p
  nnoremap ,y "+y
  vnoremap ,y "+y
  
  let g:vimfiler_ignore_pattern = '^\%(\.git\|\.DS_Store\)$'
endfunction

function! myspacevim#after() abort
  let g:github_dashboard = { 'username': 'watzon', 'password': $GITHUB_TOKEN }
  let g:gista#client#default_username = 'watzon'

  call SpaceVim#logger#info('myspacevim.vim loaded')
endfunction

