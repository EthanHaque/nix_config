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
      pyrefly
      eslint
      ruff
      vtsls
    ];
  };

  xdg.configFile."nvim".source = inputs.nvim-lazy-config;
}
