# Shared across every machine. Anything that names a Windows path, a WSL
# mount, or a work checkout belongs in ~/.config/zsh/local.zsh instead —
# stowed from local-wsl or local-mac, so each box only ever sees its own.

# ── PATH ──────────────────────────────────────────────────────
# typeset -U keeps this idempotent: nested shells (tmux -> zsh -> zsh) used
# to prepend these twice on every level.
typeset -U path PATH

path=("$HOME/.local/bin" "$HOME/.bun/bin" $path)

# ── SHELL INIT ────────────────────────────────────────────────
eval "$(starship init zsh)"
eval "$(fzf --zsh)"
# --cmd cd defines cd itself, which keeps `cd -`, bare `cd`, and completions
# working. `alias cd=z` threw those away. `cdi` gives the interactive picker.
eval "$(zoxide init zsh --cmd cd)"

# ── SHELL ALIASES ─────────────────────────────────────────────
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias lg='lazygit'

# ── FUZZY BRANCH SWITCHER ─────────────────────────────────────
gch() {
  local branch
  branch=$(git branch -a | grep -v HEAD | sed 's/remotes\/origin\///' | sort -u | fzf --height=40% --prompt="checkout: ")
  [ -n "$branch" ] && git checkout $(echo "$branch" | xargs)
}

# ── MACHINE-LOCAL ─────────────────────────────────────────────
# Sourced last so a machine can override anything above it. Absent on a box
# with no local package stowed, which is fine — the shell above is complete.
[ -r "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/local.zsh" ] \
  && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/local.zsh"
