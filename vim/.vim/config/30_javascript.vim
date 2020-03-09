"30_javascript.vim - config for javascript/typescript.
"
"Copyright (c) 2020; Chris Watson. All rights reserved.
"Use of this source code is governed by an MIT license
"that can be found in the LICENSE file.

"Enable syntax highlighting for JSDocs.
let g:javascript_plugin_jsdoc = 1

"Enable syntax highlighing for Flow.
let g:javascript_plugin_flow = 1

"Disable hiding quotes in JSON files
let g:vim_json_syntax_conceal = 0

"Clean things up by hiding certain keywords behind a glyph.
set conceallevel=1

"Enable code folding for javascript based on our syntax file.
augroup javascript_folding
    au!
    au FileType javascript setlocal foldmethod=syntax
augroup END
