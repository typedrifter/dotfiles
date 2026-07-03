# dotfiles

# Conventional Commit Convention for Dotfiles

A lightweight and practical commit convention tailored for dotfiles, configs, scripts, and homelab repositories.

---

## Format

```txt
<type>(<scope>): <message>
```

### Examples

```txt
feat(zsh): add kubectl aliases
fix(nvim): restore treesitter highlighting
perf(fzf): cache desktop entries
add(foot): add catppuccin theme
remove(i3): remove unused keybindings
refactor(scripts): split backup utilities
docs: document fresh install process
```

---

# Commit Types

| Type | Usage |
|---|---|
| `feat` | New functionality or behavior |
| `fix` | Bug fixes or broken config behavior |
| `refactor` | Restructure without changing behavior |
| `perf` | Performance improvements |
| `add` | Add a new config, script, theme, or module |
| `remove` | Remove config, script, or deprecated setup |
| `docs` | Documentation only |
| `chore` | Maintenance, tooling, bootstrap, symlinks, cleanup |

---

# Scope Guidelines

Scopes should use consistent lowercase names.

## Recommended Scopes

```txt
nvim
zsh
tmux
hypr
foot
git
scripts
waybar
kitty
alacritty
```

Use:

- application names
- folder names
- subsystem names

Avoid mixing aliases like:

```txt
vim / nvim / neovim
```

Pick one and stay consistent.

---

# Examples

## Adding Features

```txt
feat(nvim): add harpoon keymaps
feat(zsh): add docker shortcuts
feat(hypr): add workspace animations
```

## Fixing Issues

```txt
fix(tmux): restore clipboard integration
fix(waybar): fix cpu widget formatting
fix(foot): fix transparency on startup
```

## Performance Improvements

```txt
perf(zsh): lazy load pyenv
perf(fzf): cache desktop entries
perf(nvim): reduce startup time
```

## Refactoring

```txt
refactor(nvim): reorganize plugin structure
refactor(scripts): split backup utilities
refactor(zsh): simplify prompt logic
```

## File Management

```txt
add(kitty): add Tokyo Night theme
remove(i3): remove legacy workspace bindings
add(scripts): add backup-dotfiles.sh
```

## Maintenance

```txt
chore: update stow installation script
chore(git): cleanup ignored files
chore(scripts): improve bootstrap script
```

## Documentation

```txt
docs: add setup instructions for new machine
docs(nvim): document keybindings
docs(hypr): explain monitor layout
```

---

# Provisioning (Ansible + Stow)

Stow packages live at the repo root (one dir per app). Ansible drives stow
rather than replacing it: the `stow` role restows each package with
`--no-folding` so editing `~/.config/<pkg>/...` edits the repo file directly.

## Machines

| hostname | variant | notes |
|---|---|---|
| `flc-thinkpad` | `laptop` | full waybar module set |
| `flc-desktop` | `desktop` | prune modules in `config.desktop.jsonc` |

Per-hosts vars: `ansible/host_vars/<hostname>.yml`. Shared: `ansible/group_vars/all.yml`.

## Waybar per-machine config

`waybar/.config/waybar/config.<variant>.jsonc` holds each machine's bar layout.
The `waybar` role symlinks `config.jsonc -> config.<variant>.jsonc` in-repo
**before** stow runs, so the host-specific layout flows into `~/.config/waybar/`
via stow. `config.jsonc` itself is gitignored (runtime, host-specific).

## Apply

```sh
# from each machine, after `git pull`:
ansible-playbook ansible/local.yml -i ansible/inventory.yml

# or via auto-pull (needs deploy key for the private repo):
ansible-pull -U git@github.com:FLchs/dotfiles_wayland.git ansible/local.yml
```

## Fresh install

See `ansible/bootstrap.md` for one-time steps (install ansible/git/stow/yay,
set hostname, clone, apply) and the tentative package reference list.
