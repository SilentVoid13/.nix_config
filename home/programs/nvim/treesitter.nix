{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      treesitter = {
        enable = true;

        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          c
          lua
          rust
          javascript
          typescript
          python
          nix
          markdown
          markdown_inline
          vim
          vimdoc
        ];

        settings = {
          ensure_installed = [];
          highlight.enable = true;
        };
      };
      treesitter-context = {
        enable = true;
      };
    };
  };
}
