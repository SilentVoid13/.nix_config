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

      origami = {
        enable = true;
        settings = {
          useLspFoldsWithTreesitterFallback.enabled = true;
          pauseFoldsOnSearch = true;
        };
      };
    };

    opts = {
      # foldmethod = "expr";
      # foldexpr = "nvim_treesitter#foldexpr()";
      # foldexpr = "v:lua.vim.lsp.foldexpr()";
      # foldexpr = "v:lua.vim.treesitter.foldexpr()";
      # foldcolumn = "0";
      # foldtext = "";
      foldlevel = 99;
      foldlevelstart = 99;
    };
  };
}
