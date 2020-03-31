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

"Nim
let g:tagbar_type_nim = {
    \ 'ctagstype': 'nim',
    \ 'kinds' : [
        \'c:classes',
        \'e:enums',
        \'t:tuples',
        \'r:subranges',
        \'P:proctypes',
        \'p:procedures',
        \'m:methods',
        \'o:operators',
        \'T:templates',
        \'M:macros'
    \ ]
\}

"Zig
let g:tagbar_type_zig = {
    \ 'ctagstype' : 'zig',
    \ 'kinds'     : [
        \ 's:structs',
        \ 'u:unions',
        \ 'e:enums',
        \ 'v:variables',
        \ 'm:members',
        \ 'f:functions',
        \ 'r:errors'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 'e' : 'enum',
        \ 'u' : 'union',
        \ 's' : 'struct',
        \ 'r' : 'error'
    \ },
    \ 'scope2kind' : {
        \ 'enum' : 'e',
        \ 'union' : 'u',
        \ 'struct' : 's',
        \ 'error' : 'r'
    \ },
    \ 'ctagsbin'  : '/usr/bin/ztags',
    \ 'ctagsargs' : ''
\ }
