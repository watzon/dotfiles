"Source the default vimrc. It gives some nice defaults.
"source $XDG_CONFIG_HOME/nvim/init.vim 

"Source custom config files from ~/.vim/config
for f in glob('~/.config/nvim/config/*.vim', 0, 1)
    execute 'source' f
endfor
