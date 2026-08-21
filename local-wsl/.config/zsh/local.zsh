# WSL box only. Stowed by `stow local-wsl`; never present on the Mac.

# ── PATH ──────────────────────────────────────────────────────
# Drop the Windows paths WSL interop injects. Keeps `which` honest and stops
# Windows executables shadowing Linux ones. The shims below are the only
# deliberate crossings.
path=(${path:#/mnt/c/*})

# Shims for the Windows toolchain (node, npm, npx, bun, dotnet) live in
# ~/.local/bin from the local-wsl package. They are real executables, so npm
# scripts, git hooks, and separate processes like starship can find them —
# which aliases could never do.
# Node lives on the Windows side only, managed by nvm4w:
#   /mnt/c/nvm4w/nodejs -> AppData/Local/nvm/v22.14.0
# There is deliberately no WSL node and no WSL nvm; sourcing nvm.sh was one
# of the slowest lines in shell startup and had nothing left to manage.

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

# ── WINDOWS BINARIES ──────────────────────────────────────────
# These have no Linux build, so an alias is enough — unlike the toolchain
# shims, nothing calls them from inside a script.
alias claude='/mnt/c/Users/priyanshu.sharma1/.local/bin/claude.exe'
alias opencode='/mnt/c/Users/priyanshu.sharma1/.bun/bin/opencode.exe'
alias agy='/mnt/c/Users/priyanshu.sharma1/AppData/Local/agy/bin/agy.exe'
alias codex='/mnt/c/Users/priyanshu.sharma1/AppData/Local/Programs/OpenAI/Codex/bin/codex.exe'
