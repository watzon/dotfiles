"Source the default vimrc. It gives some nice defaults.
source /etc/vimrc

"Source custom config files from ~/.vim/config
for f in glob('~/.vim/config/*.vim', 0, 1)
    execute 'source' f
endfor
