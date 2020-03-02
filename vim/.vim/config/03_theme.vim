"03_theme.vim - look and feel.
"
"Copyright (c) 2020; Chris Watson. All rights reserved.
"Use of this source code is governed by an MIT license
"that can be found in the LICENSE file.

"Set the theme to challenger_deep
colorscheme base16-gruvbox-dark-hard

"Set the airline (status line) theme
let g:airline_theme='base16_gruvbox_dark_hard'

"Turn off mode indicator in status line
set noshowmode

"Transparent background. Defer to terminal theme.
hi Normal guibg=NONE ctermbg=NONE
