## NixOS Config

This is my personal NixOS configuration, managed with flakes and Home Manager.

### 📁 Structure

```
nix_config/
├── flake.nix
├── flake.lock
├── LICENSE
├── README.md
│
├── hosts/
│   ├── gluon/
│   │   ├── default.nix
│   │   └── hardware-configuration.nix
│   └── <other-hosts>/
│
├── home-manager/
│   ├── muon.nix
│   └── modules/
│       ├── bash/
│       ├── browsers/
│       ├── git/
│       ├── gnome/
│       ├── gtk/
│       ├── kitty/
│       ├── neovim/
│       │   ├── default.nix
│       │   └── nvim/
│       │       ├── config/*.lua
│       │       └── plugins/*.lua
│       ├── ranger/
│       ├── starship/
│       ├── tmux/
│       └── wallpapers/

```

### ⚙️ Setup Instructions

1. **Clone this repo** to your system:
   ```bash
   git clone https://github.com/EthanHaque/nix_config.git ~/projects/nix_config
   cd ~/projects/nix_config
   ```

2. **Build and switch to the config:**
   ```bash
   sudo nixos-rebuild switch --flake ~/projects/nix_config#<pc>
   ```
   Replace `<pc>` with hostname (as defined in the flake).
