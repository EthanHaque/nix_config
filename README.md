# NixOS Config

My personal NixOS and Home Manager configuration using flakes.


## Quick Start

1.  **Clone:**
    ```bash
    git clone [https://github.com/EthanHaque/nix_config.git](https://github.com/EthanHaque/nix_config.git) ~/projects/nix_config
    cd ~/projects/nix_config
    ```

2.  **Apply:**
    ```bash
    # Replace <hostname> with hostname defined in flake.nix
    sudo nixos-rebuild switch --flake .#<hostname>
    ```
