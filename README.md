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
