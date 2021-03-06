"02_plugins.vim - loading of plugins.
"
"Copyright (c) 2020; Chris Watson. All rights reserved.
"Use of this source code is governed by an MIT license
"that can be found in the LICENSE file.

"Install plug if it doesn't exist
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
	\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"Easy conditional plugin activation
"See: https://github.com/junegunn/vim-plug/wiki/tips#conditional-activation
function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.config/nvim/plugins')

"https://github.com/farmergreg/vim-lastplace
Plug 'farmergreg/vim-lastplace'

"https://github.com/brooth/far.vim
Plug 'brooth/far.vim'

"https://github.com/pechorin/any-jump.nvim
"Requires ripgrep or ag be installed.
Plug 'pechorin/any-jump.nvim'

"https://github.com/craigemery/vim-autotag
" Plug 'craigemery/vim-autotag'

"https://github.com/majutsushi/tagbar
Plug 'majutsushi/tagbar'

"https://github.com/jez/vim-superman
Plug 'jez/vim-superman'

"https://github.com/chriskempson/base16-vim
Plug 'chriskempson/base16-vim'

"https://github.com/vim-airline/vim-airline
Plug 'vim-airline/vim-airline'

"https://github.com/vim-airline/vim-airline-themes
Plug 'vim-airline/vim-airline-themes'

"https://github.com/antoyo/vim-licenses
Plug 'antoyo/vim-licenses'

"https://github.com/junegunn/fzf
Plug 'junegunn/fzf'

"https://github.com/preservim/nerdtree
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

"https://github.com/godlygeek/tabular
Plug 'godlygeek/tabular'

"https://github.com/ryanoasis/vim-devicons
Plug 'ryanoasis/vim-devicons'

"https://github.com/tiagofumo/vim-nerdtree-syntax-highlight
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

"https://github.com/neoclide/coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"https://github.com/ycm-core/YouCompleteMe
" Plug 'ycm-core/YouCompleteMe'

"https://github.com/yggdroot/indentline
Plug 'yggdroot/indentline'

"https://github.com/vim-syntastic/syntastic
Plug 'vim-syntastic/syntastic'

"https://github.com/justinmk/vim-sneak
Plug 'justinmk/vim-sneak'

"https://github.com/tpope/vim-surround
Plug 'tpope/vim-surround'

"https://github.com/tpope/vim-fugitive
Plug 'tpope/vim-fugitive'

"https://github.com/ColinKennedy/vim-gitgutter
Plug 'airblade/vim-gitgutter'

"https://github.com/preservim/nerdcommenter
Plug 'preservim/nerdcommenter'

"https://github.com/jiangmiao/auto-pairs
Plug 'jiangmiao/auto-pairs'

"https://github.com/editorconfig/editorconfig-vi
Plug 'editorconfig/editorconfig-vim'

"https://github.com/prettier/vim-prettier
Plug 'prettier/vim-prettier', { 'do': 'npm install' }

"https://github.com/ervandew/supertab
" Plug 'ervandew/supertab'

"https://github.com/mattn/emmet-vim
Plug 'mattn/emmet-vim'

"https://github.com/aquach/vim-http-client
Plug 'aquach/vim-http-client'

"https://github.com/tpope/vim-scriptease
Plug 'tpope/vim-scriptease'

"https://github.com/google/vim-codefmt
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Programming Languages
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"https://github.com/reasonml-editor/vim-reason-plus
Plug 'reasonml-editor/vim-reason-plus'

"https://github.com/rust-lang/rust.vim
Plug 'rust-lang/rust.vim'

"https://github.com/bfrg/vim-cpp-modern
Plug 'bfrg/vim-cpp-modern'

"https://github.com/zah/nim.vim
Plug 'zah/nim.vim'

"https://github.com/ziglang/zig.vim
Plug 'ziglang/zig.vim'

"https://github.com/rhysd/vim-crystal
Plug 'rhysd/vim-crystal'

"https://vimawesome.com/plugin/python-mode
Plug 'klen/python-mode'
Plug 'jmcantrell/vim-virtualenv'
Plug 'PieterjanMontens/vim-pipenv', {'branch': 'master'}

"https://github.com/pangloss/vim-javascript
Plug 'pangloss/vim-javascript'
Plug 'elzr/vim-json'
Plug 'Quramy/tsuquyomi'

"https://github.com/moll/vim-node
Plug 'moll/vim-node'
Plug '~/.vim/development/vim-edge-template'

"https://github.com/vim-ruby/vim-ruby
Plug 'vim-ruby/vim-ruby'

"https://github.com/tpope/vim-rails
Plug 'tpope/vim-rails'

"https://github.com/posva/vim-vue
Plug 'leafOfTree/vim-vue-plugin'

Plug 'JulesWang/css.vim'
Plug 'cakebaker/scss-syntax.vim'
Plug 'wavded/vim-stylus'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
