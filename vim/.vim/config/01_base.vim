"01_base.vim - base settings; many coming from sensible.vim.
"
"Copyright (c) 2020; Chris Watson. All rights reserved.
"Use of this source code is governed by an MIT license
"that can be found in the LICENSE file.

"Synchronize the unnamed register with the system clipboard.
set clipboard^=unnamed

"Important for syntax highlighting
if has('autocmd')
  filetype plugin indent on
endif

"Make sure syntax highlighing is enabled
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

"Keep indentation going
set autoindent

"Set which characters get deleted by a backspace
set backspace=indent,eol,start

"No idea what this does
"TODO: Figure it out
set complete-=i

"Turn on smart tabs
set smarttab

"Make sure neovim has a decent timeout
if !has('nvim') && &ttimeoutlen == -1
  set ttimeout
  set ttimeoutlen=100
endif

"Show the search pattern while typing
set incsearch

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

"Last window will always have a status line
set laststatus=2

"Turn the ruler on
set ruler

"Turn "wildmode" on. :help wildmenu
set wildmenu

"Keep a minimal amount of padding above and below the cursor.
if !&scrolloff
  set scrolloff=5
endif

"Keep a minimal amount of padding to the left and right of the cursor.
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline

"Make sure the encoding is utf8 in the gui
if &encoding ==# 'latin1' && has('gui_running')
  set encoding=utf-8
endif

"Strings to use for :list command
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

"Delete comment character when joining commented lines
if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j
endif

"
if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

"Reread a file if it has been modified outside of vim
set autoread

"Set command history 
set history=1000

"Set max tab pages
set tabpagemax=50

"
if !empty(&viminfo)
  set viminfo^=!
endif

"Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^Eterm'
  set t_Co=16
endif

"Allow termgui colors
if has('nvim') || has('termguicolors')
  set termguicolors
endif

"Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

"Turn relative number mode on
set relativenumber

"NERDCommenter needs it
filetype plugin on

"vim:set ft=vim et sw=2:
