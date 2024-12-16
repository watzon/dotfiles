# Download and install fzf
FZF_HOME="${XDG_HOME:-${HOME}}/.fzf"
if [ ! -d "$FZF_HOME" ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all
fi

# Download and install asdf
ASDF_HOME="${XDG_HOME:-${HOME}}/.asdf"
if [ ! -d "$ASDF_HOME" ]; then
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf
fi
