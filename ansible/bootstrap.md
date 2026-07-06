# Bootstrap a fresh machine

Manual one-time steps. Run on each new box, then switch to `ansible-pull`.

## 1. Base system + yay

```sh
sudo pacman -S --needed ansible git stow base-devel
# yay (manual, AUR chicken-and-egg):
git clone https://aur.archlinux.org/yay.git /tmp/yay && (cd /tmp/yay && makepkg -si)
```

## 2. Set the hostname

Must match an inventory entry (`flc-thinkpad` / `flc-desktop`) so
`host_vars/<hostname>.yml` gets loaded:

```sh
sudo hostnamectl set-hostname flc-thinkpad   # or flc-desktop
```

## 3. Clone + apply

```sh
git clone git@github.com:FLchs/dotfiles_wayland.git ~/Projects/dotfiles_wayland
cd ~/Projects/dotfiles_wayland
ansible-playbook ansible/local.yml -i ansible/inventory.yml
```

## 4. (Optional) auto-pull on a timer

Backed by a systemd user unit or cron. Private repo requires a deploy key per box.

```sh
ansible-pull -U git@github.com:FLchs/dotfiles_wayland.git ansible/local.yml
```

---

## Notes / known gaps (fix before relying on `pacman_packages_base`)

### Waybar is a custom fork

`mango/.config/mango/autostart.sh` launches
`~/Projects/Personal/Waybar-fork/build/waybar`, a fork that ships the
`ext/workspaces` module. Stock `waybar` from pacman does NOT have it.
Build the fork out-of-band (not ansible-provisionable here):

```sh
git clone <Waybar-fork URL> ~/Projects/Personal/Waybar-fork
cd ~/Projects/Personal/Waybar-fork && meson setup build && ninja -C build
```

### Manual (non-package) setup steps

```sh
# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
# bun (zshrc sources ~/.bun/_bun)
curl -fsSL https://bun.sh/install | bash
# nvim plugins (vim.pack fetches nvim-pack-lock.json on first launch)
nvim +qa
# TPM installs tmux plugins fresh on first tmux launch (prefix=C-s, then I)
```

### Package reference (tentative -- verify with `pacman -Si` / `yay -Ss`)

The `pacman_packages_base` / `yay_packages_base` lists in
`group_vars/all.yml` start empty. Below is a *starting point* from a repo
audit, with uncertain/`mango`-ecosystem items commented out for you to fix
later.

```yaml
pacman_packages_base:
  - foot
  - lf
  - tmux
  - neovim
  - git
  - ripgrep
  - fd
  - fzf
  - chafa
  - wl-clipboard
  - grim
  - slurp
  - socat
  - jq
  - inotify-tools
  - swayidle
  - waybar          # see waybar-fork note above
  - pipewire
  - wireplumber     # provides wpctl
  - pulseaudio      # provides pactl (for waybar switchaudio.sh)
  - libnotify       # notify-send
  - rofi
  - mpd
  - mpc
  - xdg-desktop-portal
  - xdg-desktop-portal-gtk
  - qt6ct
  - qt6-wayland
  - qt6-declarative  # provides qmlls6
  - gcc              # base-devel, for treesitter parsers
  - clang            # provides clang-format
  - starship
  - lazygit
  - gopls
  - mako             # notification daemon (added to autostart.sh)
  - polkit-gnome     # polkit agent (added to autostart.sh)
  - cliphist         # clipboard history (added to autostart.sh)

yay_packages_base:
  - lua-language-server
  - stylua
  - ctpv             # lf previews
  - trashy           # lf trash.sh
  - sway-audio-idle-inhibit
  - mpd-mpris
  - nextcloud-client
  - ttf-firacode-nerd
  - ttf-sourcecodepro-nerd
  # --- mango ecosystem (verify exact names, currently uncertain) ---
  # - mango-git          # ?verify -- compositor (DreamMaoMao/mango)
  # - awww-git           # ?verify -- wallpaper daemon
  # - quickshell-git     # ?verify -- provides `qs` for quicklock
  # - wlr-dpms           # ?verify -- used by lock.sh (source unclear)
  # - lsdesktop          # ?verify -- fzf-apps uses lsdesktop/desklaunch
  # - desklaunch         # ?verify -- see lsdesktop
  # - rmpc               # ?verify -- SUPER,m scratchpad binds rmpc
```

Things still to decide (not provisioned here):
- mail stack (isync/mbsync + notmuch + neomutt) referenced in zshrc but
  out of scope
- `opencode` CLI (used by toggle-opencode.sh + nvim plugin) -- install method
  TBD
```
