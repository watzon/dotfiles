"18_tagbar.vim - config for tagbar.
"
"Copyright (c) 2020; Chris Watson. All rights reserved.
"Use of this source code is governed by an MIT license
"that can be found in the LICENSE file.

"Crystal
let g:tagbar_type_crystal = {
    \ 'ctagstype': 'crystal',
    \ 'kinds' : [
        \'d:defs',
        \'f:functions',
        \'c:classes',
        \'m:modules',
        \'l:libs',
        \'s:structs'
    \]
    \}

"Zig
let g:tagbar_type_zig = {
    \ 'ctagstype': 'zig',
    \ 'kinds' : [
        \'f:functions',
        \'s:structs',
        \'e:enums',
        \'u:unions',
        \'E:errors'
    \]
    \}

