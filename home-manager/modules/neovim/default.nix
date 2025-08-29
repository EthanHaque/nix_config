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
    rev = "ae191c1cbb4428c37c9cbe87503964461b42346e";
    sha256 = "ywfJnh8NuoJmVcUBmSDkmoF8ayDUZPMNltL8QbzaY/M=";
  };
}
