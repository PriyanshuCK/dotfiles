# ── PATH ──────────────────────────────────────────────────────
# Remove Windows paths from WSL PATH (clean slate)
export PATH=$(echo $PATH | tr ':' '\n' | grep -v '/mnt/c' | tr '\n' ':' | sed 's/:$//')

# WSL-native tools
export PATH="$HOME/.bun/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# ── SHELL INIT ────────────────────────────────────────────────
eval "$(starship init zsh)"
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"

# ── SHELL ALIASES ─────────────────────────────────────────────
alias cd="z"
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias lg='lazygit'

# ── PROJECT NAVIGATION ────────────────────────────────────────
alias cdg="cd /mnt/c/gwr/"
alias gn='cd /mnt/c/gwr/gwr-brochure-website && nvim .'
alias go='cd /mnt/c/gwr/gwr-brochure-website && opencode'
alias gc='cd /mnt/c/gwr/gwr-brochure-website && claude'

# ── GWR NPM COMMANDS ──────────────────────────────────────────
alias rlb='cd /mnt/c/gwr/gwr-brochure-website/src/rendering && npm run lint && npm run build'
alias gwr='cd /mnt/c/gwr/gwr-brochure-website/src/rendering && npm run start:connected_onpremise_ssl'
alias urlb='cd /mnt/c/gwr/gwr-brochure-website-upgrade-may26/src/rendering && npm run lint && npm run build'
alias ugwr='cd /mnt/c/gwr/gwr-brochure-website-upgrade-may26/src/rendering && npm run start:connected_onpremise_ssl'

# ── FUZZY BRANCH SWITCHER ─────────────────────────────────────
gch() {
  local branch
  branch=$(git branch -a | grep -v HEAD | sed 's/remotes\/origin\///' | sort -u | fzf --height=40% --prompt="checkout: ")
  [ -n "$branch" ] && git checkout $(echo "$branch" | xargs)
}

# ── WINDOWS BINARIES ──────────────────────────────────────────
# Node / npm (Windows — project requires v16.16.0)
alias node='/mnt/c/nvm4w/nodejs/node.exe'
alias npm='/mnt/c/nvm4w/nodejs/node.exe "C:\nvm4w\nodejs\node_modules\npm\bin\npm-cli.js"'

# Claude / Opencode (Windows)
alias claude='/mnt/c/Users/priyanshu.sharma1/.local/bin/claude.exe'
alias opencode='/mnt/c/Users/priyanshu.sharma1/.bun/bin/opencode.exe'
alias agy='/mnt/c/Users/priyanshu.sharma1/AppData/Local/agy/bin/agy.exe'
alias codex='/mnt/c/Users/priyanshu.sharma1/AppData/Local/Programs/OpenAI/Codex/bin/codex.exe'
alias cl='claude'
alias oc='opencode'
alias cx='codex'

# dotnet (Windows)
alias dotnet='"/mnt/c/Program Files/dotnet/dotnet.exe"'

# Bun (Windows)
alias bun='/mnt/c/Users/priyanshu.sharma1/.bun/bin/bun.exe'
