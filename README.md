# dotfiles

My personal dotfiles for a Wayland-based Linux setup. Managed with GNU Stow
and Ansible.

## What's inside

- **nvim** -- NeoVim config
- **zsh** -- Zsh config, aliases, prompt
- **tmux** -- Tmux config
- **foot** -- Terminal emulator config (per-machine overrides via Ansible)
- **waybar** -- Wayland bar config (per-machine variants)
- **lf** -- File manager config
- **mango** -- Mangowm config
- **scripts** -- Utility scripts
- **ansible** -- Playbooks for provisioning and applying dotfiles

## How it works

Every directory at the repo root is a stow package. Stow symlinks the files
into `~/.config/<name>/` so editing a config file edits the repo file directly.

Ansible handles the per-machine bits (hostname-specific waybar layouts, font
sizes, etc.) and runs stow for you. See `ansible/local.yml` for details.

## Applying the config

```sh
ansible-playbook ansible/local.yml -i ansible/inventory.yml
```

Or on a fresh machine, follow the steps in `ansible/bootstrap.md`.
