# Add bun to PATH
export PATH="$HOME/.bun/bin:$PATH"

# Initialize starship prompt
eval "$(starship init zsh)"

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# Set up zoxide
eval "$(zoxide init zsh)"

alias cd="z"

# eza

alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
