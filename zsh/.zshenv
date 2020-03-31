export EDITOR="nvim"
export XDG_CONFIG_HOME="$HOME/.config"
export ERL_AFLAGS="-kernel shell_history enabled"
export CHROME_EXECUTABLE="/usr/bin/chromium"

export GOPATH="$HOME/Projects/golang"

export PATH="$HOME/.npm-global/bin":$PATH
export PATH=$PATH:"$GOPATH/bin"
export PATH=$PATH:"$HOME/.nimble/bin"
export PATH="$HOME/.nimble/bin:$PATH"
export PATH=$PATH:"$HOME/.local/scripts"
export PATH=$PATH:"$HOME/.local/bin"
export PATH=$PATH:"$HOME/.cargo/bin"
export PATH=$PATH:"$HOME/.pub-cache/bin"
export PATH=$PATH:"$HOME/.vim/plugged/vim-superman/bin"
export PATH=$PATH:"$HOME/.asdf/installs/rust/nightly/bin"

export LIBRARY_PATH="$LIBRARY_PATH:/usr/local/lib:/usr/lib"

export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/rust/src
