export ZSH_HOME="$HOME/.zsh/"

export EDITOR="nvim"
export SUDOEDITOR="nvim"
export DOCKER_HOST=unix:///run/user/1000/docker.sock
export CHROME_EXECUTABLE="/snap/bin/brave"

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="$HOME/development/flutter/bin/:$PATH"

source "$ZSH_HOME/secrets.zsh"
source "$ZSH_HOME/prereqs.zsh"
source "$ZSH_HOME/p10k.zsh"
source "$ZSH_HOME/zinit.zsh"
source "$ZSH_HOME/settings.zsh"
source "$ZSH_HOME/completions.zsh"
source "$ZSH_HOME/aliases.zsh"

# Shell integrations
[ -f ~/.cargo ] && source ~/.cargo/env
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(zoxide init --cmd cd zsh)"
