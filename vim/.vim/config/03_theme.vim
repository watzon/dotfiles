"03_theme.vim - look and feel.
"
"Copyright (c) 2020; Chris Watson. All rights reserved.
"Use of this source code is governed by an MIT license
"that can be found in the LICENSE file.

"Set the theme to challenger_deep
colorscheme challenger_deep

"Set the lightline theme to challenger_deep
let g:lightline = { 'colorscheme': 'challenger_deep'}

"Turn off mode indicator in status line
set noshowmode

"Transparent background. Defer to terminal theme.
hi Normal guibg=NONE ctermbg=NONE
