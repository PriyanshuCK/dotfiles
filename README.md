# dotfiles

GNU stow layout: each top-level directory is a *package* whose contents mirror
`$HOME`. `stow zsh` links `zsh/.zshrc` to `~/.zshrc`.

```sh
sudo pacman -S stow          # not installed by default
cd ~/dotfiles
stow zsh tmux starship nvim  # WSL / Linux boxes
```

Use `stow -R <pkg>` to re-link after moving files, and `stow -D <pkg>` to unlink.
Links made by hand with `ln -s` are what caused `~/.config/starship.toml` to
silently point at a path that no longer existed — starship ran on its built-in
defaults for months. Let stow generate them.

## Packages

| Package             | Machine        | Links to                       |
| ------------------- | -------------- | ------------------------------ |
| `zsh`               | all            | `~/.zshrc`                     |
| `tmux`              | all            | `~/.tmux.conf`                 |
| `starship`          | all            | `~/.config/starship.toml`      |
| `nvim`              | mac + WSL      | `~/.config/nvim`               |
| `nvim-omarchy`      | omarchy        | `~/.config/nvim`               |
| `alacritty-mac`     | mac            | `~/.config/alacritty`          |
| `alacritty-omarchy` | omarchy        | `~/.config/alacritty`          |
| `alacritty`         | —              | not stowed; see below          |

`nvim` and `nvim-omarchy` both target `~/.config/nvim`, as do the two alacritty
packages for `~/.config/alacritty`. Stow exactly one of each per machine.

## Colors

`nvim/.config/nvim/colors/zed-onedark.lua` is the **single source of truth** for
the palette — it is a port of Zed's `one.json`, and its `terminal_color_0..15`
block is the canonical 16-color ANSI ramp.

`alacritty/onedark.toml` is that ramp in Alacritty form. It is *imported*, never
copied. `tmux/.tmux.conf` holds no hex at all — it uses ANSI names (`magenta`,
`brightblack`) plus `bg=default`, so it inherits One Dark here and whatever
theme omarchy has active there. That is why there is no `tmux-omarchy`.

Accent is **magenta**. In One Dark, blue is `func`/`tag`/`attr` and cyan is
`type`/`operator`, so violet is the only ramp slot carrying no syntax load.

## The Windows exception

The Alacritty that launches this WSL setup is a Windows application and reads
`%APPDATA%\alacritty\alacritty.toml`, which cannot be stowed from inside WSL.
That file stays where Windows expects it and pulls the palette across the share:

```toml
[general]
import = ['\\wsl.localhost\archlinux\home\priyanshu\dotfiles\alacritty\onedark.toml']
```

Shell, font, and window settings stay inline there deliberately: if the import
ever fails, Alacritty still starts a usable terminal, just with default colors.

## Windows toolchain under WSL

`node`, `npm`, `npx`, `bun`, and `dotnet` are **shims** in `~/.local/bin`, not
aliases. An alias only exists at the command position of an interactive zsh, so
npm scripts, git hooks, and separate processes like starship never saw one —
which is why the prompt could never show a node version.

There is deliberately no WSL-native node and no WSL nvm. Node lives on the
Windows side only, managed by nvm4w (`/mnt/c/nvm4w/nodejs` → `AppData/Local/nvm/<version>`).

Known wart: Windows npm crashes with `EISDIR` when its stdout is a WSL *pipe*
(`npm run lint | grep …`). Redirect to a file instead. Plain runs are fine.
