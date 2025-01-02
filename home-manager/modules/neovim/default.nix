{
pkgs,
config,
...
}:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      xclip
      ripgrep
      fd
      pyright
    ];

    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-autopairs;
        type = "lua";
        config = builtins.readFile ./nvim/plugins/autopairs.lua;
      }
      {
        plugin =
        nvim-cmp;
        type = "lua";
        config = builtins.readFile ./nvim/plugins/cmp.lua;
      }
      cmp-nvim-lsp
      cmp-buffer
      {
        plugin = cyberdream-nvim;
        config = ''
        colorscheme cyberdream
        '';
      }
      {
        plugin = comment-nvim;
        type = "lua";
        config = builtins.readFile ./nvim/plugins/comment.lua;
      }
      {
        plugin = gitsigns-nvim;
        type = "lua";
        config = builtins.readFile ./nvim/plugins/gitsigns.lua;
      }
      {
        plugin = lualine-nvim;
        type = "lua";
        config = builtins.readFile ./nvim/plugins/lualine.lua;
      }
      luasnip
      {
        plugin = nvim-lspconfig;
        config = builtins.readFile ./nvim/plugins/lsp.lua;
        type = "lua";
      }
      {
        plugin = telescope-nvim;
        type = "lua";
        config = builtins.readFile ./nvim/plugins/telescope.lua;
      }
      telescope-fzf-native-nvim
      {
        plugin = toggleterm-nvim;
        type = "lua";
        config = builtins.readFile ./nvim/plugins/toggleterm.lua;
      }
      {
        plugin = nvim-treesitter;
        type = "lua";
        config = builtins.readFile ./nvim/plugins/treesitter.lua;
      }
      nvim-treesitter.withAllGrammars
      nvim-treesitter-textobjects
    ];

    extraLuaConfig = ''
      ${builtins.readFile ./nvim/config/keymaps.lua}
      ${builtins.readFile ./nvim/config/options.lua}
      ${builtins.readFile ./nvim/config/autocmds.lua}
    '';
  };
}
