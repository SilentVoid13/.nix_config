{ pkgs, ... }:
{
  home.packages = with pkgs; [
    black # python
    isort # python
    nodePackages_latest.prettier # js/ts
    clang-tools # c/c++
    jq # json
    stylua # lua
    shfmt # bash
    yamlfmt # yaml
    taplo # toml
    google-java-format # java
    ktfmt # kotlin
    nixfmt-rfc-style # nix
  ];

  programs.nixvim = {
    # NOTE: LSP formatting is used on save, this is a fallback
    plugins.conform-nvim = {
      enable = true;
      settings = {
        formatters_by_ft = {
          rust = [ "rustfmt" ];
          python = [
            "black"
            "isort"
          ];
          typescript = [ "prettier" ];
          javascript = [ "prettier" ];
          svelte = [ "prettier" ];
          c = [ "clang-format" ];
          cpp = [ "clang-format" ];
          java = [ "google-java-format" ];
          kotlin = [ "kfmt" ];
          lua = [ "stylua" ];
          sh = [ "shfmt" ];
          toml = [ "taplo" ];
          json = [ "jq" ];
          yaml = [ "yamlfmt" ];
          nix = [ "nixfmt" ];
          graphql = [ "prettier" ];
        };
        formatters = {
          clang-format.prepend_args = [ "--fallback-style=webkit" ];
          google-java-format.prepend_args = [ "--aosp" ];
        };
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>nf";
        action.__raw = "function() require('conform').format({ bufnr = vim.api.nvim_get_current_buf() }); vim.api.nvim_command('write') end";
      }
    ];
  };
}
