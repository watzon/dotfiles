alias vim = nvim
alias cls = printf '\033c'; clear
alias fuck = with-env {TF_ALIAS: "fuck", PYTHONIOENCODING: "utf-8"} {
    thefuck (history | last 1 | get command.0)
}
