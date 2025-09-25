{ config, lib, pkgs, inputs, ... }:
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
      pyright
      pyrefly
      ty
      eslint
      ruff
      vtsls
    ];
  };

  xdg.configFile."nvim".source = inputs.nvim-lazy-config;
}
