# dotfiles

GNU stow layout: each top-level directory is a *package* whose contents mirror
`$HOME`. `stow zsh` links `zsh/.zshrc` to `~/.zshrc`.

```sh
cd ~/dotfiles
stow zsh tmux starship bin nvim   # shared, on every machine
stow local-mac alacritty-mac      # ...plus what the machine adds: local-wsl
                                  # on the work laptop, nothing on lifeos
```

Use `stow -R <pkg>` to re-link after moving files, and `stow -D <pkg>` to unlink.
Links made by hand with `ln -s` are what caused `~/.config/starship.toml` to
silently point at a path that no longer existed — starship ran on its built-in
defaults for months. Let stow generate them.

## Packages

| Package             | Machine   | Links to                                             |
| ------------------- | --------- | ---------------------------------------------------- |
| `zsh`               | all       | `~/.zshrc`                                            |
| `tmux`              | all       | `~/.tmux.conf`                                        |
| `starship`          | all       | `~/.config/starship.toml`                             |
| `bin`               | all       | `~/.local/bin/tmux-{sessionizer,git-branch}`          |
| `nvim`              | all       | `~/.config/nvim`                                      |
| `alacritty-mac`     | mac       | `~/.config/alacritty`                                 |
| `local-mac`         | mac       | `~/.config/zsh`, `~/.config/tmux-sessionizer`         |
| `local-wsl`         | WSL       | ...the same, plus `~/.config/nvim-local` and `~/.local/bin/{node,npm,npx,bun,dotnet}` |
| `alacritty`         | —         | not stowed; imported by `alacritty-mac`, see below    |

The three machines are the Mac, the WSL box on the work laptop, and `lifeos`,
the GCP box reached with `os`. Stow at most one `local-*` per machine — they
target the same paths. `lifeos` takes none: it is reached over mosh, so it has
no terminal emulator of its own and nothing machine-specific to say. That is
the supported case, not an oversight — but it does mean anything you put in a
`local-*` package will never exist there.

**Never `stow local-wsl` on a native box.** It links Windows shims over
`node`, `npm`, `npx`, `bun` and `dotnet` in `~/.local/bin`, which is first on
`PATH`, so every one of those commands would exec a `/mnt/c` path that isn't
there. That split is the whole reason `bin` and `local-wsl` are separate
packages.

## Machine-local config

`zsh/.zshrc` is shared and holds nothing machine-specific. It sources
`~/.config/zsh/local.zsh` last, which comes from the `local-*` package: that is
where Windows paths, WSL mounts, and work checkouts live. A box with no
`local-*` package stowed still gets a complete shell.

`<prefix> f` (tmux-sessionizer) reads its search roots from
`~/.config/tmux-sessionizer/paths`, also from the `local-*` package:

```
/mnt/c/GWR/*    # a trailing /* offers each immediate child
~/dotfiles      # any other line is offered as-is
```

Roots that don't exist are skipped silently, so a stale line is harmless. With
no paths file at all, `~/dotfiles` is the only candidate.

Neovim does the same thing: `plugin/local.lua` loads every `*.lua` in
`~/.config/nvim-local`, and loads nothing when that directory is absent. The
floating terminal exposes `:FloatermRun <cmd>` rather than naming any project,
so a work runner is one machine-local keymap:

```lua
vim.keymap.set("n", "<space>gwr", function()
  vim.cmd("FloatermRun cd src/rendering && npm run start:connected_onpremise_ssl")
end, { desc = "Start GWR brochure site" })
```

## Colors

`nvim/.config/nvim/colors/zed-onedark.lua` is the **single source of truth** for
the palette — it is a port of Zed's `one.json`, and its `terminal_color_0..15`
block is the canonical 16-color ANSI ramp.

`alacritty/onedark.toml` is that ramp in Alacritty form. It is *imported*, never
copied — `alacritty-mac` pulls it in with `general.import`, and the Windows
Alacritty does the same across the share. `tmux/.tmux.conf` holds no hex at all:
it uses ANSI names (`yellow`, `brightblack`) plus `bg=default`, so it inherits
One Dark under `alacritty-mac`. On `lifeos` this matters more, not less: tmux
runs on the GCP box but its output is painted by whichever terminal you are
sitting in front of, so the remote session picks up the local palette for free.
That is why there is no per-machine tmux variant.

Accent is **yellow** — tmux status bar, starship prompt, and the Snacks
dashboard keys — chosen to match the Obsidian vault's accent. It was magenta,
picked because violet was the one ramp slot with no syntax load. Yellow does
carry syntax load (`constant`, `DiagnosticWarn`, `GitSignsChange`, and the
`IncSearch` background), but only inside a buffer, and none of the accented
surfaces are buffers — so the two never appear side by side.

The accent is named, never hex. `yellow` resolves to One Dark's `#e5c07b` under
`alacritty-mac`, and to whatever yellow the attached terminal defines anywhere
else, which is what keeps one tmux config serving every machine. Obsidian's accent is the exact gold `#eab308`,
set in `life-os` rather than here; it is the same colour family, not the same
hex, and matching them exactly would mean editing the ANSI ramp itself and
repainting every constant and warning in the editor along with it.

## The Option key on macOS

Alacritty defaults `window.option_as_alt` to `"None"` on macOS, which makes
Option a compose key: Option-a types `å` rather than sending `ESC a`. Every Alt
binding in tmux — the `M-a` prefix, the `M-s` status toggle — is swallowed
before tmux ever sees it. `alacritty-mac` sets `option_as_alt = "Both"`. Any new
macOS terminal needs the equivalent setting or the tmux prefix will not work.

## The Windows exception

The Alacritty that launches the WSL setup is a Windows application and reads
`%APPDATA%\alacritty\alacritty.toml`, which cannot be stowed from inside WSL.
That file stays where Windows expects it and pulls the palette across the share:

```toml
[general]
import = ['\\wsl.localhost\archlinux\home\priyanshu\dotfiles\alacritty\onedark.toml']
```

Shell, font, and window settings stay inline there deliberately: if the import
ever fails, Alacritty still starts a usable terminal, just with default colors.

## Windows toolchain under WSL

`node`, `npm`, `npx`, `bun`, and `dotnet` are **shims** in `~/.local/bin` from
the `local-wsl` package, not aliases. An alias only exists at the command
position of an interactive zsh, so npm scripts, git hooks, and separate
processes like starship never saw one — which is why the prompt could never show
a node version.

There is deliberately no WSL-native node and no WSL nvm. Node lives on the
Windows side only, managed by nvm4w (`/mnt/c/nvm4w/nodejs` → `AppData/Local/nvm/<version>`).

Known wart: Windows npm crashes with `EISDIR` when its stdout is a WSL *pipe*
(`npm run lint | grep …`). Redirect to a file instead. Plain runs are fine.
