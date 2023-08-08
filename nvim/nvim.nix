{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    plugins = with pkgs.vimPlugins; [
      telescope-nvim
      nightfox-nvim
      lualine-nvim
      toggleterm-nvim

      nvim-web-devicons
      bufferline-nvim

      nvim-cmp
      cmp-nvim-lsp
      cmp-nvim-lsp-signature-help
      cmp-nvim-lsp-document-symbol
      cmp-buffer
      cmp-path
      cmp-cmdline
      cmp-nvim-lua
      cmp-git

      nvim-lspconfig
      lsp-status-nvim
      lspsaga-nvim
      lspkind-nvim

      nvim-treesitter
      nvim-treesitter-parsers.rust
      nvim-treesitter-parsers.lua
      nvim-treesitter-parsers.nix
    ];
    extraLuaConfig = builtins.readFile ./init.lua;
  };
}