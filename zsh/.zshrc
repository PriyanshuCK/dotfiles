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

# ── C++ SCRATCH RUNNER ────────────────────────────────────────
# DSA practice: compile one file and run it. Picks real GCC when present so
# <bits/stdc++.h> resolves — Apple's `g++` is clang with libc++ and has no
# such header. Binary goes to TMPDIR, so no a.out litter next to the source.
# Sanitizers + _GLIBCXX_DEBUG are on by default: at practice sizes the cost
# is invisible, and they turn silent UB into a pointed error message.
cpr() {
  emulate -L zsh
  local src=${1:?usage: cpr file.cpp [input]}
  local cxx c
  for c in g++-16 g++-15 g++-14 g++; do
    (( $+commands[$c] )) && { cxx=$c; break }
  done
  local bin=${TMPDIR:-/tmp}/cpr-${src:t:r}
  $cxx -std=c++23 -O2 -g -Wall -Wextra \
       -fsanitize=address,undefined -D_GLIBCXX_DEBUG \
       "$src" -o "$bin" || return
  # gcc -g runs dsymutil on macOS, leaving a .dSYM bundle ~4x the binary.
  # ASan still resolves file:line without it, so it is pure weight.
  rm -rf "$bin.dSYM"
  # An explicit 2nd arg wins; otherwise fall back to input.txt beside the
  # source; otherwise read stdin so you can just type the case in.
  if   [[ -n $2 ]];                 then "$bin" < "$2"
  elif [[ -f ${src:h}/input.txt ]]; then "$bin" < ${src:h}/input.txt
  else "$bin"
  fi
}

# ── MACHINE-LOCAL ─────────────────────────────────────────────
# Sourced last so a machine can override anything above it. Absent on a box
# with no local package stowed, which is fine — the shell above is complete.
[ -r "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/local.zsh" ] \
  && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/local.zsh"
