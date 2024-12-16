# Function to highlight arbitrary text using zsh-syntax-highlighting
highlight_text() {
    local text="$1"
    
    # Create a temporary file to store the highlighting configuration
    local tmp_config=$(mktemp)
    
    # Source the zsh-syntax-highlighting plugin
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null || \
    source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null || \
    { echo "Error: zsh-syntax-highlighting not found"; return 1; }
    
    # Configure highlighting to work in non-interactive mode
    cat > "$tmp_config" <<EOL
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main)
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[alias]='fg=green'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=green'
ZSH_HIGHLIGHT_STYLES[function]='fg=green'
ZSH_HIGHLIGHT_STYLES[command]='fg=green'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=green,underline'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=blue'
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=yellow'
EOL
    
    # Load the configuration
    source "$tmp_config"
    
    # Create a buffer with the text
    BUFFER="$text"
    
    # Apply highlighting
    _zsh_highlight
    
    # Print the highlighted text
    print -r -- "$BUFFER"
    
    # Clean up
    rm "$tmp_config"
}

# Example usage:
# highlight_text "ls -la /path/to/dir | grep 'pattern'"
# highlight_text "if [[ -f file.txt ]]; then echo 'exists'; fi"
