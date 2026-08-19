# ── PATH ──────────────────────────────────────────────────────
# Remove Windows paths from WSL PATH (clean slate)
export PATH=$(echo $PATH | tr ':' '\n' | grep -v '/mnt/c' | tr '\n' ':' | sed 's/:$//')

# WSL-native tools
export PATH="$HOME/.bun/bin:$PATH"

# Shims for the Windows toolchain (node, npm, npx, bun, dotnet). These are
# real executables, so npm scripts, git hooks, and separate processes like
# starship can find them — which aliases could never do.
# Node lives on the Windows side only, managed by nvm4w:
#   /mnt/c/nvm4w/nodejs -> AppData/Local/nvm/<version>
# There is deliberately no WSL node and no WSL nvm; sourcing nvm.sh was one
# of the slowest lines in shell startup and had nothing left to manage.
export PATH="$HOME/.local/bin:$PATH"

# ── SHELL INIT ────────────────────────────────────────────────
eval "$(starship init zsh)"
eval "$(fzf --zsh)"
# --cmd cd defines cd itself, which keeps `cd -`, bare `cd`, and completions
# working. `alias cd=z` threw those away. `cdi` gives the interactive picker.
eval "$(zoxide init zsh --cmd cd)"

# ── SHELL ALIASES ─────────────────────────────────────────────
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias lg='lazygit'

# ── PROJECT NAVIGATION ────────────────────────────────────────
alias cdg="cd /mnt/c/GWR/"
alias gn='cd /mnt/c/GWR/gwr-brochure-website && nvim .'
alias go='cd /mnt/c/GWR/gwr-brochure-website && opencode'
alias gc='cd /mnt/c/GWR/gwr-brochure-website && claude'

# ── GWR NPM COMMANDS ──────────────────────────────────────────
alias rlb='cd /mnt/c/GWR/gwr-brochure-website/src/rendering && npm run lint && npm run build'
alias gwr='cd /mnt/c/GWR/gwr-brochure-website/src/rendering && npm run start:connected_onpremise_ssl'
alias urlb='cd /mnt/c/GWR/gwr-brochure-website-upgrade-may26/src/rendering && npm run lint && npm run build'
alias ugwr='cd /mnt/c/GWR/gwr-brochure-website-upgrade-may26/src/rendering && npm run start:connected_onpremise_ssl'

# ── FUZZY BRANCH SWITCHER ─────────────────────────────────────
gch() {
  local branch
  branch=$(git branch -a | grep -v HEAD | sed 's/remotes\/origin\///' | sort -u | fzf --height=40% --prompt="checkout: ")
  [ -n "$branch" ] && git checkout $(echo "$branch" | xargs)
}

# ── WINDOWS BINARIES ──────────────────────────────────────────
# node / npm / npx / bun / dotnet are NOT aliased — they are shims in
# ~/.local/bin so they also work inside scripts and other processes.
# Active Windows toolchain: /mnt/c/nvm4w/nodejs -> AppData/Local/nvm/v22.14.0

# Claude / Opencode (Windows)
alias claude='/mnt/c/Users/priyanshu.sharma1/.local/bin/claude.exe'
alias opencode='/mnt/c/Users/priyanshu.sharma1/.bun/bin/opencode.exe'
alias agy='/mnt/c/Users/priyanshu.sharma1/AppData/Local/agy/bin/agy.exe'
alias codex='/mnt/c/Users/priyanshu.sharma1/AppData/Local/Programs/OpenAI/Codex/bin/codex.exe'
alias cl='claude'
alias oc='opencode'
alias cx='codex'
