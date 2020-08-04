export EDITOR="nvim"
export XDG_CONFIG_HOME="$HOME/.config"
export ERL_AFLAGS="-kernel shell_history enabled"
export CHROME_EXECUTABLE="/usr/bin/chromium"

export GOPATH="$HOME/Projects/golang"

export N_PREFIX="$HOME/.n"

export DENO_INSTALL="/home/watzon/.deno"

export PATH=$PATH:"$HOME/.asdf/shims"
export PATH=$PATH:"$HOME/.pub-cache/bin"
export PATH=$PATH:"$HOME/.pyenv/shims"
export PATH=$PATH:"$N_PREFIX/bin"
export PATH=$PATH:"$DENO_INSTALL/bin"
export PATH=$PATH:"$HOME/.npm-global/bin"
export PATH=$PATH:"$GOPATH/bin"
export PATH=$PATH:"$HOME/.nimble/bin"
export PATH=$PATH:"$HOME/.nimble/bin"
export PATH=$PATH:"$HOME/.local/scripts"
export PATH=$PATH:"$HOME/.local/bin"
export PATH=$PATH:"$HOME/.cargo/bin"
export PATH=$PATH:"$HOME/.pub-cache/bin"
export PATH=$PATH:"$HOME/.vim/plugged/vim-superman/bin"
export PATH=$PATH:"$HOME/.asdf/installs/rust/nightly/bin"

export NODE="$HOME/.n/bin/node"

export LIBRARY_PATH="$LIBRARY_PATH:/usr/local/lib:/usr/lib"

export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/rust/src
