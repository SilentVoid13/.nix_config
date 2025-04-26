{ pkgs, ... }:
{
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
          svelte
        ];

        settings = {
          ensure_installed = [ ];
          highlight = {
            enable = true;
            # https://github.com/nvim-treesitter/nvim-treesitter/issues/1573
            additional_vim_regex_highlighting = [ "python" ];
          };
        };
      };
      treesitter-context = {
        enable = true;
      };
    };
  };
}
