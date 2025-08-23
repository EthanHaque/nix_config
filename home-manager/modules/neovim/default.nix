{ config, lib, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withPython3 = true;
    withNodeJs = true;

    extraPackages = with pkgs; [
      gcc
      xclip
      ripgrep
      lua-language-server
      stylua
      pyrefly
      eslint
      ruff
      vtsls
    ];
  };

  # This line now handles everything else.
  xdg.configFile."nvim".source = pkgs.fetchFromGitHub {
    owner = "EthanHaque";
    repo = "nvim_lazy_config";
    rev = "25d5d9aa31a50e5e537c3b1302d904c56b38f180";
    sha256 = "8JiufR+NdRqEZy8HG4RPUEPE/OkF28sffMnyLbYkYzY=";
  };
}
