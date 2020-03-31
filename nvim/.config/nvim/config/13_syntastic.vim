"13_syntastic.vim - config for syntastic.
"
"Copyright (c) 2020; Chris Watson. All rights reserved.
"Use of this source code is governed by an MIT license
"that can be found in the LICENSE file.

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"Configure filetypes
augroup filetype
    autocmd! BufRead,BufNewFile  *.h  set filetype=c
augroup END
let g:syntastic_filetype_map = { "h": "c" }

" let g:syntastic_mode_map = {
"     \"mode": "active",
"     \"passive_filetypes": ["c", "cpp", "h", "hpp"]
" \}

"JavaScript
let g:syntastic_javascript_checkers = ['eslint']

"C
let g:syntastic_c_config_file = ".ccls"
let g:syntastic_c_checkers = [ "gcc" ]

"C++
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_checkers = ["clang_check", "gcc", "cppcheck"]
let g:syntastic_cpp_compiler = "clang"
let g:syntastic_cpp_compiler_options = "-Wall -Wextra -Werror -pthread "
let g:syntastic_cpp_compiler_options += "-std=c++2a -I. -g -fPIC fsanitize=address "
let g:syntastic_cpp_clang_check_args = "-Wall -Wextra -Werror -pthread "
let g:syntastic_cpp_clang_check_args += "-std=c++2a -I. -g -fPIC fsanitize=address "

