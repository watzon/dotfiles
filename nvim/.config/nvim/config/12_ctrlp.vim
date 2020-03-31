"12_ctrlp.vim - config for ctrlp.
"
"Copyright (c) 2020; Chris Watson. All rights reserved.
"Use of this source code is governed by an MIT license
"that can be found in the LICENSE file.

"Ignore specific files
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

"Some custom root markers
let g:ctrlp_root_markers = ['shard.yml', 'README.md']

"Ignore files in .git
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
